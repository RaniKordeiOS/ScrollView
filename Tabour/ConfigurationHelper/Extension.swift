//
//  Extension.swift

import Foundation
import UIKit
//MARK:      UIViewController Extension
extension UIViewController {
 
    //MARK: Show Alert
    func alert(alert_message: String) {
        //self.showAlert(title: self.alert_txt, message: alert_message.localizableString(loc: current_language))
        self.showAlert(title: "Tabour", message: alert_message)
    }
    //MARK: Show Alert
    public func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    public func showAlertA(msg: String) {
        let alert = UIAlertController(title: "Tabour", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showLoginAlert(msg: String) {
       // msg = "Login Successful"
        let alert = UIAlertController(title: "Tabour", message: msg, preferredStyle: .alert)
     
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (_) in
            self.performSegue(withIdentifier: "", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: EMAIL validation
    public func isEmailValid(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    //MARK: NAME validation
    public func isNameValid(name:String) -> Bool {
        let nameRegEx = "[A-Za-z ]{2,}"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: name)
    }
    
    //MARK: URL CALL function
    public func urlCallFunction(url: String) {
        guard let readURL = URL(string: "\(String(describing: url))") else { return }
        UIApplication.shared.open(readURL)
    }
    //MARK: PASSWORD Validation
    public func isPasswordValid(password_txt:String) -> Bool {
        let passwordRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;]{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password_txt)
    }
    //MARK: COLOT From RGB 
    public func colorRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}

extension UICollectionViewCell {
    public func colorRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
    extension UITableViewCell {
        
        public func colorRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
            return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
        }
}
//MARK:      UIColor Extension
extension UIColor {
    
    
    //view.backgroundColor = UIColorFromRGB(0x209624)
    public func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
//MARK:      String Extension
extension String {
    //MARK: PHONE NUMBER validation
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
//MARK:      UIButton Extension
extension UIButton {
    //MARK: BOTTOM BORDER AND COLOR
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    func continueAsGuestBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0 + 14, y: self.frame.size.height - width, width: self.frame.size.width - 28.0, height: width)
        self.layer.addSublayer(border)
    }
    func goBackBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0 + 14, y: self.frame.size.height - width, width: self.frame.size.width - 28.0, height: width)
        self.layer.addSublayer(border)
    }
}
//MARK:      UIView Extension
extension UIView {
    func borderView(borderWidth: Int, cornerRadius: Int, color: UIColor) {
        let border = CALayer()
        border.borderWidth = CGFloat(borderWidth)
        border.borderColor = color.cgColor
        border.cornerRadius = CGFloat(cornerRadius)
    }
    
    func borrderView(editView: UIView) {
        editView.layer.borderWidth = 0.5
        editView.layer.borderColor = UIColor.lightGray.cgColor
        editView.layer.cornerRadius = 5
    }
}

//MARK:      Date Extension
extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentTimeForAttendance() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}
//MARK:      Double Extension
extension Double {
    
    var decimalPlaces: Int {
        let decimals = String(self).split(separator: ".")[1]
        return decimals == "0" ? 0 : decimals.count
    }
}
