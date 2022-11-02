//
//  Register_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 30/09/22.


import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class Register_VM {
    
    func getRegisterAPI(firstname: String, lastname: String, email: String, cou_code: String, mob: String, d_type: String, device_id: String, completion: @escaping(Bool, String, RegModel) -> Void) {
        let url = URLConstant.register
        let parameter = [
            "fname": firstname,
            "lname": lastname,
            "email": email,
            "country_phonecode": cou_code,
            "mobile": mob,
            "device_type": d_type,
            "device_id": device_id ] as [String: Any]
        var regData = RegModel(userId: 0, authToken: "",fname: "", lname: "", country_phonecode: "", mobile_no: "00", profile_pic: "" )
       print(parameter)
        
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                    completion(false, "Oops!! We are running some problem, please try after some time", regData)
                    return
                }
               print(url, responseObj)
                if status == "Success" {
                    let data = responseObj["data"] as? [String: Any]
                    if !data!.isEmpty {
                        let id = data!["userId"] as? Int
                        let authToken = data!["authToken"] as? String
                        let fname = data!["fname"] as? String
                        let lname = data!["lname"] as? String
                        let country_phonecode = data!["country_phonecode"] as? String
                        let mobile_no = data!["mobile_no"] as? String
                        let profile_pic = data!["profile_pic"] as? String
                      
                        regData = RegModel(userId: id ?? 0 ,authToken: authToken ?? "",fname: fname ?? "", lname: lname ?? "", country_phonecode: country_phonecode ?? "", mobile_no: mobile_no ?? "00", profile_pic: profile_pic ?? "")
                        //print(loginData)
                        completion(true, message, regData)

                    } else{
                        completion(false, "Data not found", regData)
                    }
                
                } else{
                    completion(false, message, regData)
                }
            case .failure:
                completion(false, "Server problem! please try after some time", regData)
            }
        }
    }
}

