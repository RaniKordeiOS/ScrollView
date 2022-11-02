//
//  SearchTabViewController.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 19/10/22.
//

import UIKit
import SwiftKeychainWrapper
class SearchTabViewController: UIViewController {

    
    @IBOutlet weak var collectionSearchView: UICollectionView!
    @IBOutlet weak var imageTop: UIImageView!
    
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var viewBackSearch: UIView!
    
    @IBOutlet weak var searchResult: UILabel!
    
    @IBOutlet weak var labelWefound: UILabel!
    lazy var nearByResCellID: String = "NearByResCollCell"
    lazy var listData = [ResFiltersModel]()
    let res_VM = ResFilter_VM()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        return activityView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textSearch.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        configureNavigation()
        self.viewBackSearch.layer.cornerRadius = 5
        self.getAllRes(restaurant_name: "")
        labelWefound.isHidden = true
        configureCollectionView()
        configureTextSearch()
        //MARK:    tap dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //MARK:    configureLabel
    func configureLabel()
    {
        //SofiaPro-SemiBold
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 16.0), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 16.0), NSAttributedString.Key.foregroundColor : colorRGB(r: 244, g: 162, b: 97)]
        
        let attributedString1 = NSMutableAttributedString(string:"We found ", attributes: attrs1 as [NSAttributedString.Key : Any] )
        
        let attributedString2 = NSMutableAttributedString(string:"\(listData.count) Results", attributes: attrs2 as [NSAttributedString.Key : Any])
        let attributedString3 = NSMutableAttributedString(string:" for your search", attributes: attrs1 as [NSAttributedString.Key : Any])
        
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        
        self.labelWefound.attributedText = attributedString1
    }
    func configureCollectionView()  {
        //MARK:    configure CollectionView
        collectionSearchView.dataSource = self
        collectionSearchView.delegate = self
        collectionSearchView.register(UINib(nibName: nearByResCellID, bundle: nil), forCellWithReuseIdentifier: nearByResCellID)
        collectionSearchView.backgroundColor = .clear
        
    }
    func configureNavigation()  {
        
        //MARK:    configure NAVIGATION BAR
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        self.navigationController!.navigationBar.topItem!.title = "Search"
        self.navigationController!.navigationBar.isHidden = true
    }
    func conviewBackSearch()  {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
       // print("\nscreenWidth :  \(screenWidth)")
       let top = screenHeight * 0.1
      //  print(top)
        self.viewBackSearch.translatesAutoresizingMaskIntoConstraints = false
        self.viewBackSearch.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        self.viewBackSearch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        self.viewBackSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.viewBackSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    func getAllRes(restaurant_name: String)
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        res_VM.getRestaurantsByFilters(user_id: userIdentity!, auth_token: authToken!, restro_name: restaurant_name)
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.listData = _data
                self.collectionSearchView.reloadData()
                self.textSearch.text = ""
                self.textSearch.placeholder = "Search"
                self.labelWefound.isHidden = false
                self.configureLabel()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    func configureTextSearch()
    {
        textSearch.delegate = self
       // self.textSearch.tintColor = colorRGB(r: 121, g: 161, b: 174)
      //  textFirstName.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
      //  textSearch.becomeFirstResponder()
        self.textSearch.text = ""
        self.textSearch.placeholder = " Search"
    }
}
extension SearchTabViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             textField.resignFirstResponder()
          return true
       }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // Make sure the user entered a number
        let restaurantName = textField.text ?? ""
        print("\nSEND RESTRO NAME :\n\(restaurantName)")
        //print(restaurantName)
        self.getAllRes(restaurant_name: restaurantName)
      return true
    }
}
extension SearchTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK: Collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("search list: \(listData.count)")
        return listData.count
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        //for near by
        let nearbyH = screenWidth * 0.66
        let nearbyW = screenWidth * 0.95
       // print("height width")
       // print(nearbyW)
       // print(nearbyH)
        return CGSize(width: nearbyW, height: nearbyH)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nearByResCellID, for: indexPath as IndexPath) as! NearByResCollCell
        cell.setResFilters(model: listData[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nearByResCellID, for: indexPath as IndexPath) as! NearByResCollCell
        
            let newViewController = EstDetailsVC()
            newViewController.restaurantId = "\(listData[indexPath.item].id!)"
            newViewController.modalPresentationStyle = .overCurrentContext
        self.navigationController?.pushViewController(newViewController, animated: true)
           // self.present(newViewController, animated: true, completion: nil)
    }
}
