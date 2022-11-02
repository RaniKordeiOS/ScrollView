//
//  VerificationViewController.swift
//  Tabour

import UIKit
import SwiftKeychainWrapper

class VerificationViewController: UIViewController {
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var labelVerificationCode: UILabel!
    @IBOutlet weak var labelSendVCode: UILabel!
    @IBOutlet weak var labelMobileNumber: UILabel!
    
    
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf4: UITextField!
    
    
    @IBOutlet weak var labelResendTimer: UILabel!
    @IBOutlet weak var btnResendCode: UIButton!
    
    @IBOutlet weak var labelTermsOfUse: UILabel!
    
    @IBOutlet weak var btnGoBack: UIButton!
    
    @IBOutlet weak var btnVerify: UIButton!
    
    //MARK:      label to show otp
    
    @IBOutlet weak var labelShowOTP: UILabel!
    
    //MARK:      INITIALIZATION
    let verifyResponse_VM = VerifyRes_VM()
    
    let profile_VM = Profile_VM()
    
    var verifyResModel = VerifyResModel()
    var count = 60  // 60sec if you want
    var resendTimer = Timer()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        return activityView
    }()
    let mobileNumberData : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLabel()
        configureLabelTermsOfUse()
        configureViews()
        configureUITextfeilds()
        clearText()
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)

    }
    private func configureLabel()
    {
        let mobileNumberData = KeychainWrapper.standard.string(forKey: "userMobile")!
        self.labelMobileNumber.text = mobileNumberData
        
        let ootp = KeychainWrapper.standard.integer(forKey: "userOTP")!
        print(ootp)
        self.labelShowOTP.text = "\(ootp)"
    }
    private func configureUITextfeilds()
    {
        tf1.delegate = self
        tf2.delegate = self
        tf3.delegate = self
        tf4.delegate = self
        tf1.keyboardType = .numberPad
        tf2.keyboardType = .numberPad
        tf3.keyboardType = .numberPad
        tf4.keyboardType = .numberPad
        self.tf1.tintColor = colorRGB(r: 121, g: 161, b: 174)
        self.tf2.tintColor = colorRGB(r: 121, g: 161, b: 174)
        self.tf3.tintColor = colorRGB(r: 121, g: 161, b: 174)
        self.tf4.tintColor = colorRGB(r: 121, g: 161, b: 174)
        tf1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        tf2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        tf3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        tf4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        tf1.becomeFirstResponder()
    }
    @IBAction func onClickVerify(_ sender: UIButton) {
        resendTimer.invalidate()
        if Reachability.isConnectedToNetwork(){
            if tf1.text!.count == 1 || tf2.text!.count == 1 || tf3.text!.count == 1 || tf3.text!.count  == 1{
                
                let ans = tf1.text! + tf2.text! + tf3.text! + tf4.text!
               // print(ans)
                if( ans == labelShowOTP.text! )
                {
                    verificationForUserRegisterFunc()
                }
                else {
                    self.showAlertA(msg: "please check credentials")
                    self.clearText()
                }
            } else {
                self.showAlertA(msg: "please check credentials")
            }
        }else{
            self.showAlertA(msg: "please check your intenet connection or try again later")
        }
        
    }
    @IBAction func onClickGoBack(_ sender: UIButton) {
        print("go back")
        self.clearText()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        newViewController.modalPresentationStyle = .overCurrentContext
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func onClickResendCode(_ sender: UIButton) {
        print("resend")
        self.clearText()
    }
    private func clearText()
    {
        self.tf1.text = ""
        self.tf2.text = ""
        self.tf3.text = ""
        self.tf4.text = ""
    }
    @objc func update() {
        if(count > 0) {
            count = count - 1
            print(count)
           // btn.setTitle("\(count) Resend Otp", for: .normal)
            let attrs1 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 12.0), NSAttributedString.Key.foregroundColor : UIColor.black]
            let attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaProLight", size: 12.0), NSAttributedString.Key.foregroundColor : colorRGB(r: 244, g: 162, b: 97)]
            let attributedString1 = NSMutableAttributedString(string:"Resend in ", attributes: attrs1 as [NSAttributedString.Key : Any] )
            let attributedString2 = NSMutableAttributedString(string:"\(count)", attributes: attrs2 as [NSAttributedString.Key : Any])
            
            attributedString1.append(attributedString2)
            self.labelResendTimer.attributedText = attributedString1
        }
        else {
            resendTimer.invalidate()
          //  print("call your api")
            // if you want to reset the time make count = 60 and resendTime.fire()
        }
    }
    func moveToRegisterPageVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController")
        newViewController.modalPresentationStyle = .overCurrentContext
        self.present(newViewController, animated: true, completion: nil)
    }
    func moveToDashboardContainerVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "dashboardContainerVC")
        newViewController.modalPresentationStyle = .overCurrentContext
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    
    func configureViews()
    {
        self.viewBack.layer.cornerRadius = self.viewBack.frame.width * 0.04
        
        var attrTitle = NSAttributedString(string: "Verify", attributes: [NSAttributedString.Key.font: UIFont(name: "SofiaPro-SemiBold", size: 20.0) as Any])
        self.btnVerify.setAttributedTitle(attrTitle, for: UIControl.State.normal)
        self.btnVerify.layer.cornerRadius = self.btnVerify.frame.width * 0.02
        
        self.btnGoBack.goBackBorder(color: colorRGB(r: 233, g: 196, b: 106), width: 2.0)
        
        attrTitle = NSAttributedString(string: "Resend Code", attributes: [NSAttributedString.Key.font: UIFont(name: "SofiaProLight", size: 14.0) as Any])
        self.btnResendCode.setAttributedTitle(attrTitle, for: UIControl.State.normal)
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
extension VerificationViewController {
    func verificationForUserRegisterFunc() {
         
        //self.labelMobileNumber.text!
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
       // print(deviceID)//204DBED7-996F-4DC0-95F2-09C4378C4F87
        //print(UIDevice.current.model)
        let deviceType = UIDevice.current.model
        let mobile = KeychainWrapper.standard.string(forKey: "mobile")!
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        verifyResponse_VM.getVerify(mob: mobile, device_id: deviceID) { (_isTrue, _message, _data) in
            if _isTrue {
                if _data.userstatus == "1"{
                    self.callLoginAPIForAuthToken()
                }
                else{
                    self.moveToRegisterPageVC()
                }
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
                KeychainWrapper.standard.set(id!, forKey: "userIdentity")
                KeychainWrapper.standard.set(authToken!, forKey: "authToken")
                    self.getUserProfile()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
    func getUserProfile()
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        profile_VM.getUserProfile(user_id: userIdentity!, auth_token: authToken!)
        { (_isTrue, _message, _data) in
            if _isTrue {
                let fname = _data.fname
                let lname = _data.lname
                let mobile_no = _data.mobile_no
                let country_phonecode = _data.country_phonecode
                
                let name = (fname ?? "") + " " + (lname ?? "")
                print("profile set..")
                KeychainWrapper.standard.set(name, forKey: "userName")
                self.moveToDashboardContainerVC()
            } else{
                self.showAlertA(msg: _message)
                
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
}

extension VerificationViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if text?.utf16.count==1{
            switch textField{
            case tf1:
                tf2.becomeFirstResponder()
            case tf2:
                tf3.becomeFirstResponder()
            case tf3:
                tf4.becomeFirstResponder()
            case tf4:
                tf4.resignFirstResponder()
            default:
                break
            }
        }else{
            print("text field did change")
        }
    }
    // Use this if you have a UITextField
    //https://www.hackingwithswift.com/example-code/uikit/how-to-limit-the-number-of-characters-in-a-uitextfield-or-uitextview
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // make sure the result is under 16 characters
        return updatedText.count <= 1
    }
}

