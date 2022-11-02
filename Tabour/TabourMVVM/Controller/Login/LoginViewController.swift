//
//  LoginViewController.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 28/09/22.
//

import UIKit
import SwiftKeychainWrapper
import CoreLocation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var viewForMobileText: UIView!
    
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var labelISDcode: UILabel!
    
    @IBOutlet weak var textPhoneNumber: UITextField!
    
    
    @IBOutlet weak var labelTermsOfUse: UILabel!
    
    //@IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnApple: UIButton!
    
    @IBOutlet weak var btnGuest: UIButton!
    
    @IBOutlet weak var btnContinue: UIButton!
    //MARK:      INITIALIZATION
    let country_vm = CountryCode_VM()
    var countryList = [CountryCodeModel]() {
        didSet {
            if !countryList.isEmpty {
                self.tableFlag.reloadData()
            }
        }
    }
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    let otpResponse_VM = OTPRes_VM()
    var otpResModel = OTPResModel()
    
    let transparentView = UIView()
    let tableFlag = UITableView()
    var selectedButton = UIButton()
    var selectedFlag = ""
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        return activityView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
      //  print(deviceID)//204DBED7-996F-4DC0-95F2-09C4378C4F87
     //   print(UIDevice.current.model) //iPhone
       // getLocationAndCountryCode()
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCountryCode()
        configureLabelTermsOfUse()
        configureViews()
        configureViewForMobileText()
        configTableView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
//    @objc func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
    
    @IBAction func onClickContinue(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
        if textPhoneNumber.text!.count >= 1 {
            let textMobile = textPhoneNumber.text!.trimmingCharacters(in: .whitespaces)
            //let phoneNumberValidator = trimmedString.isPhoneNumber
            if textMobile.isPhoneNumber == false {
                alert(alert_message: "Please enter valid mobile number")
            }
            else
            {
                //print("ok done")
                let userMobileCC: String = self.labelISDcode.text! + " " + textMobile
                
                KeychainWrapper.standard.set(self.labelISDcode.text!, forKey: "countryCode")
                KeychainWrapper.standard.set(textMobile, forKey: "mobile")
                KeychainWrapper.standard.set(userMobileCC, forKey: "userMobile")
                
                // print(KeychainWrapper.standard.string(forKey: "userMobile")!)
                self.sendOTPFunc(mob: textMobile)
            }
        } else {
            self.showAlertA(msg: "please check credentials")
        }
        
    } else{
        self.showAlertA(msg: "please check your intenet connection or try again later")
            }
      
    }
    @IBAction func onClickButtonSelect(_ sender: UIButton)
    {
        selectedButton = btnSelect
        addTransparentView(frames: btnSelect.frame)
    }
    @IBAction func onClickGuest(_ sender: UIButton) {
        KeychainWrapper.standard.set(0, forKey: "userIdentity")
        KeychainWrapper.standard.set("0", forKey: "authToken")
            self.moveToDashboardContainerVC()
        
    }
 
    @IBAction func onClickAppleLogin(_ sender: UIButton) {
    }
   
    
//    func getLocationAndCountryCode() {
//        locationManager.requestAlwaysAuthorization()
//                if CLLocationManager.locationServicesEnabled() {
//                    locationManager.delegate = self
//                    locationManager.startMonitoringSignificantLocationChanges()
//                }
//    }
    
    func moveToDashboardContainerVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "dashboardContainerVC")
        newViewController.modalPresentationStyle = .overCurrentContext
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func moveToVerificationPageVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "VerificationViewController")
        newViewController.modalPresentationStyle = .overCurrentContext
        
        self.present(newViewController, animated: true, completion: nil)
    }
    func configTableView()  {
        tableFlag.delegate = self
        tableFlag.dataSource = self
        tableFlag.register(DataCell.self, forCellReuseIdentifier: "DataCell")
        selectedButton.setTitle("", for: .normal)
        selectedButton.layer.borderColor = UIColor.gray.cgColor
    }
    func configureViewForMobileText()
    {
        self.textPhoneNumber.text = ""
        self.textPhoneNumber.tintColor = colorRGB(r: 121, g: 161, b: 174)
        self.viewForMobileText.layer.cornerRadius = self.viewForMobileText.frame.width * 0.04
        self.viewForMobileText.layer.borderColor = colorRGB(r: 121, g: 161, b: 174).cgColor
        self.viewForMobileText.layer.borderWidth = 2
        self.viewForMobileText.backgroundColor = .clear
        self.btnSelect.layer.cornerRadius = self.btnSelect.frame.width * 0.5
        self.btnSelect.layer.masksToBounds = true
        self.btnSelect.setTitle(countryFlag(countryCode: "QA"), for: .normal)
        self.labelISDcode.text = "974"
    }
    func configureViews()
    {
        self.viewBack.layer.cornerRadius = self.viewBack.frame.width * 0.04
        self.btnApple.setTitle("", for: .normal)
        self.btnApple.setImage(UIImage(named: "appleLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnApple.setImage(UIImage(named: "appleLogo")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        self.btnApple.backgroundColor = .black
        self.btnApple.layer.cornerRadius = self.btnApple.frame.width * 0.02
        
        /*
        self.btnGoogle.setTitle("", for: .normal)
        self.btnGoogle.setImage(UIImage(named: "gmailIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnGoogle.setImage(UIImage(named: "gmailIcon")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        self.btnGoogle.backgroundColor = .clear
        self.btnGoogle.layer.borderColor = colorRGB(r: 179, g: 188, b: 191).cgColor
        self.btnGoogle.layer.borderWidth = 2
        self.btnGoogle.layer.cornerRadius = self.btnGoogle.frame.width * 0.04
        */
        self.btnGuest.continueAsGuestBorder(color: colorRGB(r: 233, g: 196, b: 106), width: 2.0)
        //  self.btnContinue.setTitle("Continue", for: .normal)
        // self.btnContinue.titleLabel?.font = UIFont(name: "SofiaPro-SemiBold", size: 24)
        let attrTitle = NSAttributedString(string: "Continue", attributes: [NSAttributedString.Key.font: UIFont(name: "SofiaPro-SemiBold", size: 20.0) as Any])
        self.btnContinue.setAttributedTitle(attrTitle, for: UIControl.State.normal)
        self.btnContinue.layer.cornerRadius = self.btnContinue.frame.width * 0.02
    }
    func configureLabelTermsOfUse()
    {
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 16.0), NSAttributedString.Key.foregroundColor : colorRGB(r: 179, g: 188, b: 191)]
        
        //SofiaPro-SemiBold
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaPro-SemiBold", size: 16.0), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attributedString1 = NSMutableAttributedString(string:"By signing in, you are agree to the ", attributes: attrs1 as [NSAttributedString.Key : Any] )
        
        let attributedString2 = NSMutableAttributedString(string:"Terms Of Use", attributes: attrs2 as [NSAttributedString.Key : Any])
        
        attributedString1.append(attributedString2)
        self.labelTermsOfUse.attributedText = attributedString1 
    }
    
}
extension LoginViewController {
    func sendOTPFunc(mob: String) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        otpResponse_VM.getOTP(mob: mob) { (_isTrue, _message, _data) in
            if _isTrue {
                //let otp = _data.otp
                
               // KeychainWrapper.standard.set(otp!, forKey: "pp")
               // print(otp!)
                self.moveToVerificationPageVC()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
}
extension LoginViewController: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == textPhoneNumber {
        let phoneNumberValidator = textPhoneNumber.text!.isPhoneNumber
        if phoneNumberValidator == false {
            alert(alert_message: "Please enter valid mobile number")
        }
        //print("ok done")
    }
}

}
extension LoginViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK:      Country Flag
    func countryFlag(countryCode: String) -> String {
        let base = 127397
        var tempScalarView = String.UnicodeScalarView()
        for i in countryCode.utf16 {
            if let scalar = UnicodeScalar(base + Int(i)) {
                tempScalarView.append(scalar)
            }
        }
        return String(tempScalarView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.sizeToFit()
        cell.textLabel?.font = cell.textLabel?.font.withSize(40)
        let a = countryFlag(countryCode: countryList[indexPath.item].iso2!)
        let b = countryList[indexPath.item].phonecode!
        let c = countryList[indexPath.item].name!
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        cell.textLabel?.text = a + " " + c + "        " + b
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flagiso2 = countryList[indexPath.item].iso2!
        let countryCode = countryList[indexPath.item].phonecode!
        selectedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 60)
        selectedButton.setTitle(countryFlag(countryCode: flagiso2), for: .normal)
        // selectedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 60)
        removeTransparentViewA()
        self.selectedFlag = countryFlag(countryCode: flagiso2)
        labelISDcode.text = countryCode
        textPhoneNumber.text = ""
        // print(flagiso2)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    // ADD TRANSPARENT VIEW ACTIVITY
    func addTransparentView(frames: CGRect)
    {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableFlag.frame = CGRect(x: frames.origin.x + 40, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableFlag)
        tableFlag.layer.cornerRadius = 10
        
        transparentView.backgroundColor = UIColor(red:38/255, green: 109/255, blue: 100/255, alpha: 0.3)
        
        // self.ddATableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentViewA))
        transparentView.addGestureRecognizer(tapgesture)
        //ANIMATION
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableFlag.frame = CGRect(x: frames.origin.x + 20, y: frames.origin.y + frames.height + 5, width: self.viewBack.frame.width, height: CGFloat(10 * 42))
        }, completion: nil)
    }//end of addTransparentView
    // REMOVE TRANSPARENT VIEW ACTIVITY
    @objc func removeTransparentViewA()
    {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            
            self.tableFlag.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
}
extension LoginViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let currentLocation = locations.first else { return }

            geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
                guard let currentLocPlacemark = placemarks?.first else { return }
                print(currentLocPlacemark.country ?? "No country found")
                print(currentLocPlacemark.isoCountryCode ?? "No country code found")
            }
        }
    }
extension LoginViewController {
    
    private func getCountryCode()
    {
        if Reachability.isConnectedToNetwork(){
            countryCodeAPIFunc()
        } else{
            self.showAlert(title: "Lost internet connect!!", message: "please check your intenet connection or try again later")
        }
        
    }
    func countryCodeAPIFunc() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        country_vm.getCountryDetailsAPI() { (_isTrue, _message, _data) in
            if _isTrue {
                self.countryList = _data
               // print("Done")
            } else{
                self.showAlert(title: "Alert!", message: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
}
