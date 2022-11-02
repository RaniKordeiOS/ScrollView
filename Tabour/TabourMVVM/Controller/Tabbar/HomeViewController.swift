//
//  HomeViewController.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//

import UIKit
import SwiftKeychainWrapper
import CoreLocation

class HomeViewController: UIViewController,  UIScrollViewDelegate {
    
    
    @IBOutlet weak var imageHomeTop: UIImageView!
    @IBOutlet weak var viewFC: UIView!
    
    @IBOutlet weak var viewEx: UIView!
    
    @IBOutlet weak var viewRN: UIView!
    
    @IBOutlet weak var btnCafes: UIButton!
    @IBOutlet weak var btnRestaurants: UIButton!
    @IBOutlet weak var imageLocation: UIImageView!
    @IBOutlet weak var imageGuest: UIImageView!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var heightOfBackImage: NSLayoutConstraint!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var viewOnScrollView: UIView!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var labelMood: UILabel!
    @IBOutlet weak var collectionMood: UICollectionView!
    @IBOutlet weak var labelExplore: UILabel!
    @IBOutlet weak var collectionExplore: UICollectionView!
    @IBOutlet weak var labelNearByRes: UILabel!
    @IBOutlet weak var colllectionNearByRes: UICollectionView!
    @IBOutlet weak var btnViewMoreNearByRes: UIButton!

    lazy var exploreCellID: String = "ExploreCollectionViewCell"
    lazy var foodCategoryCellID: String = "FoodCategoryCell"
    
    lazy var previousOffsetState: CGFloat = 0
    
    
    var listFoodCategories = [AllFoodCategriesModel]()
    lazy var listAllRestaurants_res1 = [AllRestaurantModel]()
    lazy var listAllRestaurants_cafe2 = [AllRestaurantModel]()
    
    let allRes_VM = AllRestaurants_VM()
    let foodCat_VM = AllFoodCategories_VM()
    //MARK:  locationManager
    var locationManager = CLLocationManager()
    var currentlocation:CLLocation!
    var latitudeCurrentLocation : Double = 0.0
    var longitudeCurrentLocation : Double = 0.0
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        return activityView
    }()
    //MARK:  VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        // Do any additional setup after loading the view.
        self.myScrollView.delegate = self
        configure_collectionViews()
        // configureLocationManager()
    }
    override func viewWillAppear(_ animated: Bool) {
        configureViews()
        getFoodCategory()
        //Looks for single or multiple taps.
    }
    func configureLocationManager()
    {
        // locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Get Location Permission one time only
        locationManager.requestWhenInUseAuthorization()
        // Need to update location and get location data in locationManager object with delegate
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    func configure_collectionViews()
    {
        collectionMood.dataSource = self
        collectionMood.delegate = self
        collectionMood.register(UINib(nibName: foodCategoryCellID, bundle: nil), forCellWithReuseIdentifier: foodCategoryCellID)
        collectionExplore.dataSource = self
        collectionExplore.delegate = self
        collectionExplore.register(UINib(nibName: exploreCellID, bundle: nil), forCellWithReuseIdentifier: exploreCellID)
    }
    
    func configureViews()  {
        //MARK:    configure NAVIGATION BAR
        //        let paragraph = NSMutableParagraphStyle()
        //        paragraph.alignment = .center
        //        navigationController?.navigationBar.largeTitleTextAttributes = [.paragraphStyle: paragraph]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let attrs = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                      NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attrs
        //MARK:    configure viewOnScrollView
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        print("\nscreenWidth :  \(screenWidth)")
        let size = self.viewOnScrollView.frame.width * 0.07
      //  print("\nimageHomeTop: \(self.imageHomeTop.frame)")
       // print("\nframe viewOnScrollView: \(self.viewOnScrollView.frame)")
       // print("\nwidth viewOnScrollView: \(self.viewOnScrollView.frame.width)")
        print("\nmyScrollView: \(self.myScrollView.frame)")
       // let size = self.viewOnScrollView.frame.width
        myScrollView.backgroundColor = .systemPink
        let path = UIBezierPath(roundedRect: self.viewOnScrollView.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: size, height:  size))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.viewOnScrollView.layer.mask = maskLayer
        //MARK:    configure SCROLL VIEW
        self.myScrollView.layer.mask = maskLayer
        
        //MARK:    configure locationView
        self.locationView.layer.cornerRadius = 8
        //MARK:    Res button
        self.btnRestaurants.isSelected = true
        self.btnRestaurants.layer.cornerRadius = 6
        self.btnRestaurants.setTitle("Restaurants", for: .normal)
        self.btnRestaurants.setImage(UIImage(named: "resLogoW"), for: .normal)
        self.btnRestaurants.backgroundColor = colorRGB(r: 233, g: 196, b: 106)
        //MARK:    Cafes button
        
        self.btnCafes.setTitle("Cafes", for: .normal)
        self.btnCafes.layer.cornerRadius = 6
        self.btnCafes.setImage(UIImage(named: "cafeLogo"), for: .normal)
        self.btnCafes.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
        self.btnCafes.backgroundColor = .clear
        self.btnCafes.layer.borderColor = colorRGB(r: 64, g: 121, b: 140).cgColor
        self.btnCafes.layer.borderWidth = 2
        
    }
    
    //MARK:  GET CURRENT LOCATION
    func getCurrentLocation()
    {
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            //  print(currentLoc.coordinate.latitude)
            //  print(currentLoc.coordinate.longitude)
            
            latitudeCurrentLocation = currentLoc.coordinate.latitude
            longitudeCurrentLocation = currentLoc.coordinate.longitude
            print("\n\nLatitude: \(currentLoc.coordinate.latitude) and longitude\(currentLoc.coordinate.longitude)")
        }
    }
    //MARK:  View More
    
    @IBAction func onClickViewMoreNearByRes(_ sender: UIButton) {
        
    }
    
    //MARK:  SCROLL VIEW DELEGATE
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (50)
        {
            self.heightOfBackImage.constant = 150
            navigationController?.navigationBar.prefersLargeTitles = false
            //SET COLOR AND TEXT OF TITLE
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            let userG = KeychainWrapper.standard.integer(forKey: "userIdentity")
            if userG == 0
            {
                self.navigationController!.navigationBar.topItem!.title = "Hi!"
            }
            else
            {
                let userName = KeychainWrapper.standard.string(forKey: "userName") ?? " "
                self.navigationController!.navigationBar.topItem!.title = "Hi! \(userName),"
            }
        }
        else{
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        print("\nmyScrollView: \(self.myScrollView.frame)")
        
        print("screenWidth :  \(screenWidth)")
      //  print("width :  \(scrollView.frame.width)")
      //  print("width myScrollView:  \(myScrollView.frame.width)")
     //   print("width collectionExplore:  \(collectionExplore.frame.width)")
       // print("Scrollview offset y :  \(scrollView.contentOffset.y)")
        let offsetDiff = previousOffsetState - scrollView.contentOffset.y
        previousOffsetState = scrollView.contentOffset.y
        
        let contraintNewHeight =  self.heightOfBackImage.constant + offsetDiff
        self.heightOfBackImage.constant = contraintNewHeight
    }
    //MARK:  HANDLER OF RES AND CAFE BUTTON
    
    
    @IBAction func onClickRestaurants(_ sender: UIButton) {
        if !btnRestaurants.isSelected {
            
            btnRestaurants.isSelected = true
            
            btnRestaurants.setTitleColor(UIColor.white, for: UIControl.State.normal)
            btnRestaurants.setImage(UIImage(named: "resLogoW"), for: .normal)
            btnRestaurants.backgroundColor = colorRGB(r: 233, g: 196, b: 106)
            btnRestaurants.layer.borderWidth = 0
            
            btnCafes.isSelected = false
            btnCafes.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
            btnCafes.setImage(UIImage(named: "cafeLogo"), for: .normal)
            
            btnCafes.backgroundColor = .clear
            btnCafes.layer.borderColor = colorRGB(r: 64, g: 121, b: 140).cgColor
            btnCafes.layer.borderWidth = 2
        }
        collectionExplore.reloadData()
    }
    @IBAction func onClickCafes(_ sender: UIButton) {
        if !btnCafes.isSelected {
            btnCafes.isSelected = true
            
            btnCafes.setTitleColor(UIColor.white, for: UIControl.State.normal)
            btnCafes.setImage(UIImage(named: "cafeLogoW"), for: .normal)
            btnCafes.backgroundColor = colorRGB(r: 233, g: 196, b: 106)
            btnCafes.layer.borderWidth = 0
            
            btnRestaurants.isSelected = false
            btnRestaurants.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
            btnRestaurants.setImage(UIImage(named: "resLogo"), for: .normal)
            btnRestaurants.backgroundColor = .clear
            btnRestaurants.layer.borderColor = colorRGB(r: 64, g: 121, b: 140).cgColor
            btnRestaurants.layer.borderWidth = 2
        }
        collectionExplore.reloadData()
    }
    
}
/*
 extension HomeViewController: CLLocationManagerDelegate
 {
 func authorizelocationstates(){
 
 if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
 currentlocation = locationManager.location
 // print(currentlocation)
 latitudeCurrentLocation = currentlocation.coordinate.latitude
 longitudeCurrentLocation = currentlocation.coordinate.longitude
 print("\n\nLatitude: \(currentlocation.coordinate.latitude) and longitude\(currentlocation.coordinate.longitude)")
 
 }
 else{
 // Note : This function is overlap permission
 //  locationManager.requestWhenInUseAuthorization()
 //  authorizelocationstates()
 }
 }
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
 locationManager = manager
 // Only called when variable have location data
 authorizelocationstates()
 }
 }
 */
extension HomeViewController
{
    func getFoodCategory()
    {
        
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        print(authToken!)
        print(userIdentity!)
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        foodCat_VM.getFoodCategories(user_id: userIdentity!, auth_token: authToken!)
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.listFoodCategories = _data
                // print("\nlistFoodCategories.count")
                //print(self.listFoodCategories.count)
                
                self.getAllResDefault()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
    func getAllResDefault()
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        allRes_VM.getAllRestaurants(user_id: userIdentity!, auth_token: authToken!, resType: 1,cuisineId: "")
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.listAllRestaurants_res1 = _data
                //print("\nlistAllRestaurants_res1.count")
                print("res count: \(self.listAllRestaurants_res1.count)")
            
                self.getAllCafes()
            } else{
                self.showAlertA(msg: _message)
                
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
    func getAllCafes()
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        allRes_VM.getAllRestaurants(user_id: userIdentity!, auth_token: authToken!, resType: 2,cuisineId: "")
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.listAllRestaurants_cafe2 = _data
                //print("\nlistAllRestaurants_cafe2.count")
                //print(self.listAllRestaurants_cafe2.count)
                self.collectionMood.reloadData()
              
                self.collectionExplore.reloadData()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    func getNearByRestaurants()
    {
        
        /*
         let authToken = KeychainWrapper.standard.string(forKey: "authToken")
         let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
         DispatchQueue.main.async {
         self.activityIndicator.startAnimating()
         }
         allRes_VM.getAllRestaurants(user_id: userIdentity!, auth_token: authToken!, resType: 2)
         { (_isTrue, _message, _data) in
         if _isTrue {
         self.listAllRestaurants_cafe2 = _data
         print("\nlistAllRestaurants_cafe2.count")
         print(self.listAllRestaurants_cafe2.count)
         self.collectionMood.reloadData()
         self.collectionExplore.reloadData()
         } else{
         self.showAlertA(msg: _message)
         }
         self.activityIndicator.stopAnimating()
         }
         */
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK: Collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionMood {
            return listFoodCategories.count
        }
        else{
            if( btnRestaurants.isSelected == true)
            {
                return listAllRestaurants_res1.count
            }
            else
            {
                return listAllRestaurants_cafe2.count
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        // print(screenWidth * 0.3)
        let fcH = screenWidth * 0.27
        let fcW = screenWidth * 0.24
        let exH = screenWidth * 0.42
        let exW = screenWidth * 0.8
        //330  185
        if collectionView == collectionMood {
            return CGSize(width: fcW, height: fcH)
        }
        else{
            if( btnRestaurants.isSelected == true)
            {
                return CGSize(width: exW, height: exH)
            }
            else
            {
                return CGSize(width: exW, height: exH)
            }
        }
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionMood {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCategoryCellID, for: indexPath as IndexPath) as! FoodCategoryCell
            cell.setData(model: listFoodCategories[indexPath.item])
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exploreCellID, for: indexPath as IndexPath) as! ExploreCollectionViewCell
            
            if( btnRestaurants.isSelected == true)
            {
                cell.setRes(model: listAllRestaurants_res1[indexPath.item])
                return cell
            }
            else
            {
                cell.setRes(model: listAllRestaurants_cafe2[indexPath.item])
                return cell
            }
            
        }
    }
    
    // cell.sliderImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
    // cell.sliderImage.sd_setImage(with: URL(string: hotelSlider_data[indexPath.item].image!), completed: nil)
    // cell.contentLabel.text = hotelSlider_data[indexPath.item].text!.htmlToString
    
}


/*
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 if collectionView != sliderCollectionView && collectionView != specialOffersCollectionView {
 let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HotelsDetailsVC") as! HotelsDetailsVC
 VC.hotelID = hotel_data[indexPath.item].hotelID!
 self.navigationController?.pushViewController(VC, animated: true)
 }
 }
 */

