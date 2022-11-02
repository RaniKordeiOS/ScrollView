//
//  RegisterViewController.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 29/09/22.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var labelEmailAddress: UILabel!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var viewForFName: UIView!
    @IBOutlet weak var textFirstName: UITextField!
    @IBOutlet weak var viewForLName: UIView!
    @IBOutlet weak var textLastName: UITextField!
    @IBOutlet weak var viewForEmail: UIView!
    @IBOutlet weak var textEmailAddress: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnAnotherN: UIButton!
    @IBOutlet weak var labelTermsOfUse: UILabel!
    @IBOutlet weak var viewForCheckBox: UIView!
    @IBOutlet weak var btnCheckbox: UIButton!
    @IBOutlet weak var labelToCheckbox: UILabel!
    
    let register_VM = Register_VM()
    var registerModel = RegModel()
    
    var isSelectedCheckbox = false
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        return activityView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLabelTermsOfUse()
        configureViews()
        configureViewForAllText()
        clearTextAnd_ConfigureUITextfields()
        configureLabelEmailAnd_CBLabelAnd_MessageLabel()
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func onClickRegister(_ sender: UIButton) {
       lazy var trimmedEmail = ""
        if Reachability.isConnectedToNetwork(){
            if textFirstName.text!.count >= 1 || textLastName.text!.count >= 1
            {
                let trimmedFirstName = self.textFirstName.text!.trimmingCharacters(in: .whitespaces)
                if self.isNameValid(name: trimmedFirstName) == false {
                    alert(alert_message: "Please enter valid first name")
                }
                else{
                    let trimmedLastName = self.textLastName.text!.trimmingCharacters(in: .whitespaces)
                    if self.isNameValid(name: trimmedLastName) == false {
                        alert(alert_message: "Please enter valid last name")
                    }
                    else{
                       // trimmedEmail = self.textEmailAddress.text!
                        
//                        if(trimmedEmail.count >= 1 ){
//                                                    if self.isEmailValid(emailID: trimmedEmail) == false {
//                                                        alert(alert_message: "Please enter valid email")
//                                                    }
//                        }
                        //else
                       // {
                            trimmedEmail = self.textEmailAddress.text!
                             print("Register")
                        
                            let deviceID = UIDevice.current.identifierForVendor!.uuidString
                            // print(deviceID)//204DBED7-996F-4DC0-95F2-09C4378C4F87
                            //print(UIDevice.current.model)
                            let deviceType = UIDevice.current.model
                            let mobile = KeychainWrapper.standard.string(forKey: "mobile")!
                            let countryCode = KeychainWrapper.standard.string(forKey: "countryCode")!
                            
                            registerUserFunc(fn: trimmedFirstName, ln: trimmedLastName, email: trimmedEmail, cCode: countryCode, mobile: mobile, deviceID: deviceID, deviceType: deviceType)
                            
                        //}
                    }
                    
                }
                
            } else {
                self.showAlertA(msg: "please check credentials")
            }
            
        } else{
            self.showAlertA(msg: "please check your intenet connection or try again later")
    
        }
        
    }
    
    @IBAction func onClickCheckbox(_ sender: UIButton) {
        if isSelectedCheckbox == true {
            sender.setImage(UIImage(named: "uncheck.png"), for: .normal)
            isSelectedCheckbox = false
        }
        else
        {
            sender.setImage(UIImage(named: "check.png"), for: .normal)
            isSelectedCheckbox = true
        }
    }
    
    @IBAction func onClickEnterAnotherNumber(_ sender: UIButton) {
        print("Enter another number")
    }
    
    func moveToLoginPageVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        newViewController.modalPresentationStyle = .overCurrentContext
        self.present(newViewController, animated: true, completion: nil)
    }
    func moveToDashboardContainerVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "dashboardContainerVC")
        newViewController.modalPresentationStyle = .overCurrentContext
        self.present(newViewController, animated: true, completion: nil)
    }
    private func clearTextAnd_ConfigureUITextfields()
    {
        textFirstName.delegate = self
        textLastName.delegate = self
        textEmailAddress.delegate = self
        self.textFirstName.tintColor = colorRGB(r: 121, g: 161, b: 174)
        self.textLastName.tintColor = colorRGB(r: 121, g: 161, b: 174)
        self.textEmailAddress.tintColor = colorRGB(r: 121, g: 161, b: 174)
        textFirstName.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textLastName.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
      //  textEmailAddress.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textFirstName.becomeFirstResponder()
        self.textFirstName.text = ""
        self.textLastName.text = ""
        self.textEmailAddress.text = ""
        self.textFirstName.placeholder = " Enter first name"
        self.textLastName.placeholder = " Enter last name"
        self.textEmailAddress.placeholder = " Enter your email"
    }
    func configureViewForAllText()
    {
        self.viewForFName.layer.cornerRadius = self.viewForFName.frame.width * 0.04
        self.viewForFName.layer.borderColor = colorRGB(r: 121, g: 161, b: 174).cgColor
        self.viewForFName.layer.borderWidth = 2
        self.viewForFName.backgroundColor = .clear
        self.viewForLName.layer.cornerRadius = self.viewForLName.frame.width * 0.04
        self.viewForLName.layer.borderColor = colorRGB(r: 121, g: 161, b: 174).cgColor
        self.viewForLName.layer.borderWidth = 2
        self.viewForLName.backgroundColor = .clear
        self.viewForEmail.layer.cornerRadius = self.viewForEmail.frame.width * 0.04
        self.viewForEmail.layer.borderColor = colorRGB(r: 121, g: 161, b: 174).cgColor
        self.viewForEmail.layer.borderWidth = 2
        self.viewForEmail.backgroundColor = .clear
    }
    func configureViews()
    {
        self.viewBack.layer.cornerRadius = self.viewBack.frame.width * 0.04
        self.btnAnotherN.continueAsGuestBorder(color: colorRGB(r: 233, g: 196, b: 106), width: 2.0)
        
        let attrTitle = NSAttributedString(string: "Register", attributes: [NSAttributedString.Key.font: UIFont(name: "SofiaPro-SemiBold", size: 20.0) as Any])
        self.btnRegister.setAttributedTitle(attrTitle, for: UIControl.State.normal)
        self.btnRegister.layer.cornerRadius = self.btnRegister.frame.width * 0.02
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
    func configureLabelEmailAnd_CBLabelAnd_MessageLabel()
    {
        //MARK:      INITIALIZATION of Email Address Label
        var attrs1 = [NSAttributedString.Key.font : UIFont(name: "SofiaPro-SemiBold", size: 16.0), NSAttributedString.Key.foregroundColor : UIColor.black]
        //SofiaPro-SemiBold
        var attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 16.0), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        var attributedString1 = NSMutableAttributedString(string:"Email Address ", attributes: attrs1 as [NSAttributedString.Key : Any] )
        var attributedString2 = NSMutableAttributedString(string:"(Optional)", attributes: attrs2 as [NSAttributedString.Key : Any])
        
        attributedString1.append(attributedString2)
        self.labelEmailAddress.attributedText = attributedString1
        
        //MARK:      INITIALIZATION of Check Box Label
        self.btnCheckbox.setImage(UIImage(named: "uncheck.png"), for: .normal)
        isSelectedCheckbox = false
        attrs1 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 12.0), NSAttributedString.Key.foregroundColor : colorRGB(r: 121, g: 161, b: 174)]
        //SofiaPro-SemiBold
        attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 12.0), NSAttributedString.Key.foregroundColor : colorRGB(r: 64, g: 121, b: 140)]
        
        attributedString1 = NSMutableAttributedString(string:"I agree to the ", attributes: attrs1 as [NSAttributedString.Key : Any] )
        attributedString2 = NSMutableAttributedString(string:"Terms Of Use", attributes: attrs2 as [NSAttributedString.Key : Any])
        
        attributedString1.append(attributedString2)
        self.labelToCheckbox.attributedText = attributedString1
        
        //MARK:      INITIALIZATION of Message Label
        attrs1 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 12.0), NSAttributedString.Key.foregroundColor : colorRGB(r: 121, g: 161, b: 174)]
        attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 12.0), NSAttributedString.Key.foregroundColor : colorRGB(r: 64, g: 121, b: 140)]
        
        attributedString1 = NSMutableAttributedString(string:"This number ", attributes: attrs1 as [NSAttributedString.Key : Any] )
        
        let mobileNumberData = KeychainWrapper.standard.string(forKey: "userMobile")!
        
        attributedString2 = NSMutableAttributedString(string: mobileNumberData, attributes: attrs2 as [NSAttributedString.Key : Any])
        
        attributedString1.append(attributedString2)
        
        attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 12.0), NSAttributedString.Key.foregroundColor : colorRGB(r: 121, g: 161, b: 174)]
        attributedString2 = NSMutableAttributedString(string:" has not been found. Please create a new account.", attributes: attrs2 as [NSAttributedString.Key : Any])
        
        attributedString1.append(attributedString2)
        self.labelMessage.attributedText = attributedString1
    }
}
extension RegisterViewController {
    
    func registerUserFunc(fn: String, ln: String, email: String, cCode: String, mobile: String, deviceID: String, deviceType: String) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        register_VM.getRegisterAPI(firstname: fn, lastname: ln, email: email, cou_code: cCode, mob: mobile, d_type: deviceType, device_id: deviceID) { (_isTrue, _message, _data) in
            if _isTrue {
                //  self.moveToLoginPageVC()
                let id = _data.userId
                let authToken = _data.authToken
                let fname = _data.fname
                let lname = _data.lname
                KeychainWrapper.standard.set(id!, forKey: "userIdentity")
                KeychainWrapper.standard.set(authToken!, forKey: "authToken")
                let name = (fname ?? "") + " " + (lname ?? "")
                KeychainWrapper.standard.set(name, forKey: "userName")
                let authTokenn = KeychainWrapper.standard.string(forKey: "authToken")
                let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
                let userName = KeychainWrapper.standard.string(forKey: "userName")
                print(userName!)
                print(authTokenn!)
                print(userIdentity!)
                //self.callLoginAPIForAuthToken()
                 self.moveToDashboardContainerVC()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    func callLoginAPIForAuthToken()
    {
        let mylogin_VM = Login_VM()
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        // print(deviceID)//204DBED7-996F-4DC0-95F2-09C4378C4F87
        //print(UIDevice.current.model)
        let deviceType = UIDevice.current.model
        let mobile = KeychainWrapper.standard.string(forKey: "mobile")!
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        mylogin_VM.userLogin(mob: mobile, devID: deviceID, devType: deviceType, playerID: "988") { (_isTrue, _message, _data) in
            if _isTrue {
                let id = _data.userId
                let authToken = _data.authToken
                //   print(id!)
                // print(authToken!)
                KeychainWrapper.standard.set(id!, forKey: "userIdentity")
                KeychainWrapper.standard.set(authToken!, forKey: "authToken")
                self.moveToDashboardContainerVC()
            } else{
                
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
}
extension RegisterViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textFirstName {
            if self.isNameValid(name: textFirstName.text!) == false {
                alert(alert_message: "Please enter valid name")
            }
        }
        if textField == textLastName {
            if self.isNameValid(name: textLastName.text!)  == false {
                alert(alert_message: "Please enter valid last name")
            }
        }
        if textField == textEmailAddress {
            if self.isEmailValid(emailID: textEmailAddress.text!) == false {
                alert(alert_message: "Please enter valid email address")
            }
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if text?.utf16.count==1{
            switch textField{
            case textFirstName:
                textFirstName.becomeFirstResponder()
            case textLastName:
                textLastName.becomeFirstResponder()
            case textEmailAddress:
                textEmailAddress.resignFirstResponder()
            default:
                break
            }
        }else{
            //print("text field did change")
        }
    }
}
