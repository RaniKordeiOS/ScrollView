//
//  HomeNewViewController.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//

import UIKit
import SwiftKeychainWrapper
import CoreLocation

class HomeNewViewController: UIViewController,  UIScrollViewDelegate {
    
    
    @IBOutlet weak var searchView: UIView!
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
    
    @IBOutlet weak var collectionNearByRes: UICollectionView!
    
    @IBOutlet weak var btnViewMoreNearByRes: UIButton!
    
    @IBOutlet weak var topScrollView: NSLayoutConstraint!
    
    @IBOutlet weak var heightOfFoodCategory: NSLayoutConstraint!
    
    
    lazy var nearByResCellID: String = "NearByResCollCell"
    lazy var exploreCellID: String = "ExploreCollectionViewCell"
    lazy var foodCategoryCellID: String = "FoodCategoryCell"
    
    lazy var previousOffsetState: CGFloat = 0
   
    var listFoodCategories = [AllFoodCategriesModel]()
    lazy var listAllRestaurants_res1 = [AllRestaurantModel]()
    lazy var listAllRestaurants_cafe2 = [AllRestaurantModel]()
    lazy var listNearByRes_res1 = [NearByRestaurantsModel]()
    lazy var listNearByRes_cafe2 = [NearByRestaurantsModel]()
    
    let allRes_VM = AllRestaurants_VM()
    let foodCat_VM = AllFoodCategories_VM()
    let nearRes_VM = NearByRestaurants_VM()
    //MARK:  locationManager
    var locationManager = CLLocationManager()
    var currentlocation:CLLocation!
    var latitudeCurrentLocation : Double = 0.0
    var longitudeCurrentLocation : Double = 0.0
    
    lazy var isFoodCategorySelected = false
    lazy var isResSelected = true
    lazy var selectedCuisineID = 0
    lazy var isHiddenFC = false
    
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleSearchViewTap))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
       searchView.addGestureRecognizer(tap)
        
      //  let tapLocationView = UITapGestureRecognizer(target: self, action: #selector(self.handleLocationViewTap))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
     // locationView.addGestureRecognizer(tapLocationView)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.isHidden = false
        configureViews()
        getFoodCategory()
        configureSearchView()
        //Looks for single or multiple taps.
    }
    //MARK:    configure search view
    func configureSearchView()
    {
        searchView.layer.cornerRadius = 5
    }
    @objc func handleLocationViewTap() {
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       // let newViewController = storyBoard.instantiateViewController(withIdentifier: "bsViewController")

        //https://stuartbreckenridge.net/custom-detent-height-in-ios-16/
       // let smallId = UISheetPresentationController.Detent.Identifier("small")
        //let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
       //     return 80
        //}
        //sheetPresentationController?.detents = [smallDetent, .medium(), .large()]
        
        
        if let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bsViewController") as? BottomSheetViewController{
            if let sheet = newViewController.sheetPresentationController{
                let smallId = UISheetPresentationController.Detent.Identifier("small")
                if #available(iOS 16.0, *) {
                    print(newViewController.view.frame.height)
                    print(newViewController.view.frame.height * 0.75)
                    let heigth = newViewController.view.frame.height * 0.75
                    let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
                        return heigth
                    }
                    sheet.detents = [smallDetent, .medium(), .large()]
                } else {
                    // Fallback on earlier versions
                    sheet.detents = [.medium(), .large()]
                }
                //sheet.detents = [.medium(), .large()]
                //sheet.detents = [.large()]
                //sheet.prefersScrollingExpandsWhenScrolledToEdge = true
                sheet.preferredCornerRadius = 20
                sheet.prefersGrabberVisible = true
            }
            self.present(newViewController, animated: true, completion: nil)
        }
        print("ok")
    }
    @objc func handleSearchViewTap() {
        self.tabBarController?.selectedIndex = 1
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
        collectionMood.backgroundColor = .clear
        collectionExplore.dataSource = self
        collectionExplore.delegate = self
        collectionExplore.register(UINib(nibName: exploreCellID, bundle: nil), forCellWithReuseIdentifier: exploreCellID)
        collectionExplore.backgroundColor = .clear
        collectionNearByRes.dataSource = self
        collectionNearByRes.delegate = self
        collectionNearByRes.register(UINib(nibName: nearByResCellID, bundle: nil), forCellWithReuseIdentifier: nearByResCellID)
        collectionNearByRes.backgroundColor = .clear
    }
    
    func configureViews()  {
        
        //MARK:    configure NAVIGATION BAR
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        let userG = KeychainWrapper.standard.integer(forKey: "userIdentity")
        if userG == 0
        {
            self.navigationController!.navigationBar.topItem!.title = "Hi!"
        }
        else
        {
            let userName = KeychainWrapper.standard.string(forKey: "userName") ?? ""
            self.navigationController!.navigationBar.topItem!.title = "Hi! \(userName),"
        }
        
        //MARK:    configure NAVIGATION BAR
        //        let paragraph = NSMutableParagraphStyle()
        //        paragraph.alignment = .center
        //        navigationController?.navigationBar.largeTitleTextAttributes = [.paragraphStyle: paragraph]
        
        
        //MARK:    hidden part due to isse
        /*
         navigationController?.navigationBar.prefersLargeTitles = true
         let attrs = [ NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)
         ]
         navigationController?.navigationBar.largeTitleTextAttributes = attrs
         //MARK:    configure viewOnScrollView
         // print(self.viewOnScrollView.frame.width)
         let size = self.viewOnScrollView.frame.width * 0.07
         myScrollView.backgroundColor = .clear
         
         let path = UIBezierPath(roundedRect: self.viewOnScrollView.bounds,
         byRoundingCorners:[.topRight, .topLeft],
         cornerRadii: CGSize(width: size, height:  size))
         let maskLayer = CAShapeLayer()
         maskLayer.path = path.cgPath
         self.viewOnScrollView.layer.mask = maskLayer
         //MARK:    configure SCROLL VIEW
         self.myScrollView.layer.mask = maskLayer
         
         */
        //MARK:    hidden part due to isse
        
        
        //MARK:    corner radius to scroll view
        myScrollView.layer.cornerRadius = 20
        viewOnScrollView.layer.cornerRadius = 20
        
        
        //MARK:    configure locationView
        self.locationView.layer.cornerRadius = 8
        
       
        if (isResSelected == true)
        {
            //MARK:   Initial Res button
            self.btnRestaurants.isSelected = true
            self.isResSelected = true
            self.btnRestaurants.layer.cornerRadius = 6
            self.btnRestaurants.setTitle("Restaurants", for: .normal)
            self.btnRestaurants.setImage(UIImage(named: "resLogoW"), for: .normal)
            self.btnRestaurants.backgroundColor = colorRGB(r: 233, g: 196, b: 106)
            self.btnRestaurants.layer.borderWidth = 0
            
            //MARK:     Initial Cafes button
            btnCafes.isSelected = false
            self.btnCafes.setTitle("Cafes", for: .normal)
            self.btnCafes.layer.cornerRadius = 6
            self.btnCafes.setImage(UIImage(named: "cafeLogo"), for: .normal)
            self.btnCafes.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
            self.btnCafes.backgroundColor = .clear
            self.btnCafes.layer.borderColor = colorRGB(r: 64, g: 121, b: 140).cgColor
            self.btnCafes.layer.borderWidth = 2
        }
        else{
            //MARK:    Cafes button
            btnCafes.isSelected = true
            self.isResSelected = false
            self.btnCafes.setTitle("Cafes", for: .normal)
            self.btnCafes.layer.cornerRadius = 6
            self.btnCafes.setImage(UIImage(named: "cafeLogoW"), for: .normal)
            btnCafes.backgroundColor = colorRGB(r: 233, g: 196, b: 106)
            btnCafes.layer.borderWidth = 0
        
            //MARK:    Res button
            btnRestaurants.isSelected = false
            self.btnRestaurants.setTitle("Restaurants", for: .normal)
            self.btnRestaurants.layer.cornerRadius = 6
            btnRestaurants.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
            btnRestaurants.setImage(UIImage(named: "resLogo"), for: .normal)
            btnRestaurants.backgroundColor = .clear
            btnRestaurants.layer.borderColor = colorRGB(r: 64, g: 121, b: 140).cgColor
            btnRestaurants.layer.borderWidth = 2
        }
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
    /*
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
     //print("Scrollview offset y :  \(scrollView.contentOffset.y)")
     let offsetDiff = previousOffsetState - scrollView.contentOffset.y
     previousOffsetState = scrollView.contentOffset.y
     
     let contraintNewHeight =  self.heightOfBackImage.constant + offsetDiff
     self.heightOfBackImage.constant = contraintNewHeight
     }
     
     */
    
    //MARK:  HANDLER OF RES AND CAFE BUTTON
    
    
    @IBAction func onClickRestaurants(_ sender: UIButton) {
        
        if !btnRestaurants.isSelected {
            self.isResSelected = true
            btnRestaurants.isSelected = true
            
            btnRestaurants.setTitleColor(UIColor.white, for: UIControl.State.normal)
            btnRestaurants.setImage(UIImage(named: "resLogoW"), for: .normal)
            btnRestaurants.backgroundColor = colorRGB(r: 233, g: 196, b: 106)
            // btnRestaurants.layer.borderColor = colorRGB(r: 233, g: 196, b: 106).cgColor
            btnRestaurants.layer.borderWidth = 0
            
            btnCafes.isSelected = false
            btnCafes.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
            btnCafes.setImage(UIImage(named: "cafeLogo"), for: .normal)
            
            btnCafes.backgroundColor = .clear
            btnCafes.layer.borderColor = colorRGB(r: 64, g: 121, b: 140).cgColor
            btnCafes.layer.borderWidth = 2
        }
        collectionExplore.reloadData()
        collectionNearByRes.reloadData()
    }
    @IBAction func onClickCafes(_ sender: UIButton) {
        
        if !btnCafes.isSelected {
            btnCafes.isSelected = true
            self.isResSelected = false
            btnCafes.setTitleColor(UIColor.white, for: UIControl.State.normal)
            btnCafes.setImage(UIImage(named: "cafeLogoW"), for: .normal)
            btnCafes.backgroundColor = colorRGB(r: 233, g: 196, b: 106)
            //btnCafes.layer.borderColor = colorRGB(r: 233, g: 196, b: 106).cgColor
            btnCafes.layer.borderWidth = 0
            
            btnRestaurants.isSelected = false
            btnRestaurants.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
            btnRestaurants.setImage(UIImage(named: "resLogo"), for: .normal)
            btnRestaurants.backgroundColor = .clear
            btnRestaurants.layer.borderColor = colorRGB(r: 64, g: 121, b: 140).cgColor
            btnRestaurants.layer.borderWidth = 2
        }
        collectionExplore.reloadData()
        collectionNearByRes.reloadData()
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
extension HomeNewViewController
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
                let cuisineId = ""
                self.getAllResDefault(cuisineId: cuisineId)
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
    func getAllResDefault(cuisineId: String)
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        allRes_VM.getAllRestaurants(user_id: userIdentity!, auth_token: authToken!, resType: 1, cuisineId: cuisineId)
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.listAllRestaurants_res1 = _data
                //print("\nlistAllRestaurants_res1.count")
                //print(self.listAllRestaurants_res1.count)
                self.getAllCafes(cuisineId: cuisineId)
            } else{
                self.showAlertA(msg: _message)
                
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
    func getAllCafes(cuisineId: String)
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        allRes_VM.getAllRestaurants(user_id: userIdentity!, auth_token: authToken!, resType: 2, cuisineId: cuisineId)
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.listAllRestaurants_cafe2 = _data
             
                if(self.isFoodCategorySelected){
                    print("near res not changes")
                    self.collectionExplore.reloadData()
                }else{
                    self.collectionMood.reloadData()
                    self.collectionExplore.reloadData()
                    self.getNearByRestaurants()
                }
                
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    //MARK:  get NearBy Restaurants
    func getNearByRestaurants()
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        nearRes_VM.getNearByRestaurants(user_id: userIdentity!, auth_token: authToken!, resType: 1, latitude: "", longitude: "")
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.listNearByRes_res1 = _data
                self.getNearByCafes()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    func getNearByCafes()
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        nearRes_VM.getNearByRestaurants(user_id: userIdentity!, auth_token: authToken!, resType: 2, latitude: "", longitude: "")
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.listNearByRes_cafe2 = _data
                self.collectionNearByRes.reloadData()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
}
extension HomeNewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK: Collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionMood {
            let selectedItem = self.listFoodCategories[indexPath.row]
           // self.delegate?.didChoosedProduct(item: selectedItem)
            self.isFoodCategorySelected = true
            print(selectedItem.name!)
            print(selectedItem.id!)
            //String ID
            let cuisineId = "\(selectedItem.id!)"
            //Int ID
            self.selectedCuisineID = selectedItem.id!
           getAllResDefault(cuisineId: cuisineId)
        }
        else if (collectionView == collectionExplore){
            let newViewController = EstDetailsVC()
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exploreCellID, for: indexPath as IndexPath) as! ExploreCollectionViewCell
            
            if( btnRestaurants.isSelected == true)
            {
                    newViewController.restaurantId = "\(listAllRestaurants_res1[indexPath.item].id!)"
                    newViewController.modalPresentationStyle = .overCurrentContext
            }
            else
            {
                newViewController.restaurantId = "\(listAllRestaurants_cafe2[indexPath.item].id!)"
            newViewController.modalPresentationStyle = .overCurrentContext
            }
            self.navigationController?.pushViewController(newViewController, animated: true)
              
        }
        else
        {
            let newViewController = EstDetailsVC()
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nearByResCellID, for: indexPath as IndexPath) as! NearByResCollCell
            if( btnRestaurants.isSelected == true)
            {
                newViewController.restaurantId = "\(listNearByRes_res1[indexPath.item].id!)"
            newViewController.modalPresentationStyle = .overCurrentContext
            }
            else
            {
                newViewController.restaurantId = "\(listNearByRes_cafe2[indexPath.item].id!)"
            newViewController.modalPresentationStyle = .overCurrentContext
            }
            self.navigationController?.pushViewController(newViewController, animated: true)
              
        }
          
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionMood {
            return listFoodCategories.count
        }
        else if (collectionView == collectionExplore){
        
            if( btnRestaurants.isSelected == true)
            {
                print("res explore: \(listAllRestaurants_res1.count)")
                return listAllRestaurants_res1.count
            }
            else
            {
                print("cafe explore: \(listAllRestaurants_cafe2.count)")
                return listAllRestaurants_cafe2.count
            }
        }
        else
        {
            let newViewController = EstDetailsVC()
            if( btnRestaurants.isSelected == true)
            {
                print("res near by: \(listNearByRes_res1.count)")
                return listNearByRes_res1.count
            }
            else
            {
                print("cafes near by: \(listNearByRes_cafe2.count)")
                return listNearByRes_cafe2.count
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        // print(screenWidth * 0.3)
        let fcH = screenWidth * 0.29
        let fcW = screenWidth * 0.27
        //let exH = screenWidth * 0.6
        let exH = screenWidth * 0.5
        let exW = screenWidth * 0.9
        //for near by
        let nearbyH = screenWidth * 0.66
        let nearbyW = screenWidth * 0.9
        //330  185
        if collectionView == collectionMood {
            return CGSize(width: fcW, height: fcH)
        }
        else if (collectionView == collectionExplore){
            return CGSize(width: exW, height: exH)
        }
        else
        {
            return CGSize(width: nearbyW, height: nearbyH)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionMood {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCategoryCellID, for: indexPath as IndexPath) as! FoodCategoryCell
            cell.setData(model: listFoodCategories[indexPath.item])
            return cell
        }
        else if (collectionView == collectionExplore){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exploreCellID, for: indexPath as IndexPath) as! ExploreCollectionViewCell
            
            if( btnRestaurants.isSelected == true)
            {
                if( isFoodCategorySelected == true )
                {
                    cell.setRes(model: listAllRestaurants_res1[indexPath.item], foodCat: true, cuisineIdentity: self.selectedCuisineID)
                }
                else{
                    cell.setRes(model: listAllRestaurants_res1[indexPath.item])
                }
                return cell
            }
            else
            {
                if( isFoodCategorySelected == true )
                {
                    cell.setRes(model: listAllRestaurants_cafe2[indexPath.item], foodCat: true, cuisineIdentity: self.selectedCuisineID)
                }
                else{
                    cell.setRes(model: listAllRestaurants_cafe2[indexPath.item])
                }
                return cell
            }
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nearByResCellID, for: indexPath as IndexPath) as! NearByResCollCell
            if( btnRestaurants.isSelected == true)
            {
                cell.setNearByRes(model: listNearByRes_res1[indexPath.item])
                return cell
            }
            else
            {
                cell.setNearByRes(model: listNearByRes_cafe2[indexPath.item])
                return cell
            }
        }
        
        // cell.sliderImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        // cell.sliderImage.sd_setImage(with: URL(string: hotelSlider_data[indexPath.item].image!), completed: nil)
        // cell.contentLabel.text = hotelSlider_data[indexPath.item].text!.htmlToString
        
    }

    func changeHeightOfFoodCategory(_ multiplier: CGFloat)
    {
        let newConstraint = heightOfFoodCategory.constraintWithMultiplier(multiplier)
        view.removeConstraint(heightOfFoodCategory)
        view.addConstraint(newConstraint)
        view.layoutIfNeeded()
        heightOfFoodCategory = newConstraint
    }
}

extension NSLayoutConstraint {
    
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
