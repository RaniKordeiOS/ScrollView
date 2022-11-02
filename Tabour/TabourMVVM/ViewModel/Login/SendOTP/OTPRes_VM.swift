//
//  OTPRes_VM.swift
//  Tabour
import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper


class OTPRes_VM {
    
    func getOTP(mob: String, completion: @escaping(Bool, String, OTPResModel) -> Void) {
        
        let url = URLConstant.sendotp
        let parameter = ["mobile": mob] as [String: Any]
        var otpData = OTPResModel(message: "", status: "", otp: 0, data: nil)
     
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                    completion(false, "Oops!! We are running some problem, please try after some time", otpData)
                    return
                }
                // print(url, responseObj)
                if status == "Success" {
                    let otpGet = responseObj["otp"] as? Int
                    if otpGet! != 0 {
                       // let userID = data!["user_id"] as? String
                         print(otpGet!)
                        otpData = OTPResModel(message: message, status: status, otp: otpGet, data: nil)
                        completion(true, message, otpData)
                        KeychainWrapper.standard.set(otpGet!, forKey: "userOTP")
                       // print(KeychainWrapper.standard.integer(forKey: "userOTP")!)
                    }
                    else{
                        completion(false, "Data not found", otpData)
                    }
                } else{
                    completion(false, message, otpData)
                }
            case .failure:
                completion(false, "Server problem! please try after some time", otpData)
            }
        }
    }
}

