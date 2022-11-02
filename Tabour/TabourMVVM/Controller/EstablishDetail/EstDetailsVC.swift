//
//  EstDetailsVC.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 27/10/22.
//

import UIKit
import SwiftKeychainWrapper

class EstDetailsVC: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var omr_segment: UISegmentedControl!
    
    let estDetails_VM = EstablishmentD_VM()
    var resData : EstDetail?
    
    var arrayPhoto: [UIImage?] = []
    
    var arrayName: [String?] = []
    
    var listImg: [EstImage]? = []
      //TIMER AND COUNTER
      var timer = Timer()
      var counter = 0
    lazy var cuisineData = ""
    lazy var seatingData = ""
    var restaurantId: String?
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        return activityView
    }()
    
    @IBOutlet weak var labelResCafe: UILabel!
    
    @IBOutlet weak var labelOpenNow: UILabel!
    
    @IBOutlet weak var labelClosedAt: UILabel!
    
    @IBOutlet weak var labelParkingValue: UILabel!
    
    @IBOutlet weak var labelClosetime: UILabel!
    
    @IBOutlet weak var labelParking: UILabel!
    
    @IBOutlet weak var labelSeating: UILabel!
    
    @IBOutlet weak var labelDescData: UILabel!
    
    @IBOutlet weak var cuiView: UIView!
    
    @IBOutlet weak var labelCuisine: UILabel!
    
    @IBOutlet weak var seatingView: UIView!
    
    @IBOutlet weak var btnBackArrow: UIButton!
    
    @IBOutlet weak var btnJoinQ: UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnBooknow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RESTRO ID: \(self.restaurantId)")
        //self.navigationController!.navigationBar.isHidden = true
    
        //COLLECTION VIEW
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        sliderCollectionView.register(UINib(nibName: "EstablishDetailsCell", bundle: nil), forCellWithReuseIdentifier: "EstablishDetailsCell")
       //addDataToArrayPhoto()
           //UIPageControl
        
        pageControl.numberOfPages = listImg?.count ?? 1
        //pageControl.numberOfPages = arrayPhoto.count
           pageControl.currentPage = 0
           //TIMER WITH SELECTOR AND REPEAT
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
      //  con_OMR_segment()
        configureViews()
        configureButtons()
        getDataFromServer()
        con_OMR_segment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        con_OMR_segment()
        configureViews()
        configureButtons()
    }
    //MARK: configureViews
    func configureViews()
    {
        labelDescData.text = "Well built resort, clean & modern rooms, friendly & courteous staff, delicious food & a lot of activities"
        labelClosetime.text = "00:59 AM"
        labelParkingValue.text = "Valet"
        //MARK: cuisine value
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 17.0), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        //SofiaPro-SemiBold
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 17.0), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        let attributedString1 = NSMutableAttributedString(string:"Cuisines ", attributes: attrs1 as [NSAttributedString.Key : Any] )
        cuisineData = "Indian"
        let attributedString2 = NSMutableAttributedString(string: self.cuisineData, attributes: attrs2 as [NSAttributedString.Key : Any])
        attributedString1.append(attributedString2)
        self.labelCuisine.attributedText = attributedString1
        //MARK: cuisine value
        let attrs11 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 17.0), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        //SofiaPro-SemiBold
        let attrs22 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 17.0), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        
        let attributedString11 = NSMutableAttributedString(string:"Seating ", attributes: attrs11 as [NSAttributedString.Key : Any] )
        seatingData = "Indoor, Outdoor, Seafront"
        let attributedString22 = NSMutableAttributedString(string: self.seatingData, attributes: attrs22 as [NSAttributedString.Key : Any])
        
        attributedString11.append(attributedString22)
        self.labelSeating.attributedText = attributedString11
    }
    //MARK: configure button
    func configureButtons()
    {
        //MARK:      btn save
        btnSave.layer.cornerRadius = btnSave.frame.width / 2
        btnSave.layer.masksToBounds = true
        
        //MARK:    Book now button
        self.btnBooknow.layer.cornerRadius = 6
        
        //MARK:    join queue button
        self.btnJoinQ.layer.cornerRadius = 6
        self.btnJoinQ.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
        self.btnJoinQ.backgroundColor = .clear
        self.btnJoinQ.layer.borderColor = colorRGB(r: 64, g: 121, b: 140).cgColor
        self.btnJoinQ.layer.borderWidth = 2
    
    }
    //MARK:   Data from server
    func getDataFromServer()
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        
       // let id: String = "\(self.restaurantId!)"
       // print(id)
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        estDetails_VM.getEsDetails(user_id: userIdentity!, auth_token: authToken!, resID:"\(self.restaurantId!)")
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.resData = _data
                let c =  self.resData?.seatingOptions!.count
                
                self.labelDescData.text = self.resData?.dataDescription
                self.listImg = self.resData?.images
                print(self.listImg?.count)
               self.sliderCollectionView.reloadData()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    //MARK:    SEGMENT CONTROL
    func con_OMR_segment()
    {
        //colorRGB(r: 77, g: 101, b: 108)
        
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: colorRGB(r: 233, g: 196, b: 106), NSAttributedString.Key.font : UIFont(name: "SofiaPro-SemiBold", size: 22.0)!] as [NSAttributedString.Key : Any]
        //light orange
        UISegmentedControl.appearance().setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        let normalTextAttributesDefault = [NSAttributedString.Key.foregroundColor: colorRGB(r: 77, g: 101, b: 108), NSAttributedString.Key.font : UIFont(name: "SofiaPro-SemiBold", size: 22.0)!] as [NSAttributedString.Key : Any]
        
        UISegmentedControl.appearance().setTitleTextAttributes(normalTextAttributesDefault, for: .normal)
      
        omr_segment.backgroundColor = colorRGB(r: 2, g: 35, b: 47)
        omr_segment.selectedSegmentTintColor = colorRGB(r: 2, g: 35, b: 47)
    }
 
    //OBJECT METHOD
       @objc func changeImage() -> Void {
           print("llslls")
         //  if counter < arrayPhoto.count
          if counter < listImg?.count ?? 1
           {
               let index = IndexPath.init(item: counter, section: 0)
               
               self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
               pageControl.currentPage = counter
               counter = counter + 1
           } else {
               counter  = 0
               let index = IndexPath.init(item: counter, section: 0)
               self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               pageControl.currentPage = counter
               counter  = 1
           }
       }

    @IBAction func onClickBackArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
       // self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onClickCSController(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0:
                print("Overview")
                print(sender.selectedSegmentIndex)
                break
            case 1:
                print("Menu")
                print(sender.selectedSegmentIndex)
                break
            default:
                print("hello 0")
                print(sender.selectedSegmentIndex)
            }
        }
}
extension EstDetailsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK:    array photo
    func addDataToArrayPhoto() -> Void {
        arrayPhoto.append(UIImage(named: "01"))
        arrayPhoto.append(UIImage(named: "02"))
        arrayPhoto.append(UIImage(named: "03"))
        arrayPhoto.append(UIImage(named: "04"))
        arrayName.append("New Era Restaurant")
        arrayName.append("Annapurna Restaurant")
        arrayName.append("Taj Hotel")
        arrayName.append("The Orchid Hotel")
    }

    //COLLECTION VIEW FUNCTIONS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  arrayPhoto.count
       listImg!.count
    }
    
    //MARK:    collection cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EstablishDetailsCell", for: indexPath) as! EstablishDetailsCell
      //  cell.setCell(photoR: arrayPhoto[indexPath.item]!, name: arrayName[indexPath.item]!)
      cell.setImage(data: listImg![indexPath.item], name: (resData?.name!)!)
        return cell
    }
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        // print(screenWidth * 0.3)
        let cellHeight = screenHeight * 0.32
    //let cellHeight = self.sliderCollectionView.frame.height
        let cellWidth = screenWidth
       // return CGSize(width: self.sliderCollectionView.frame.width, height: self.sliderCollectionView.frame.height)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }

 

}

