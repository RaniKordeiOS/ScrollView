//
//  Logout_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 07/10/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class Logout_VM {
        
        func logoutUser(user_id: Int, auth_token: String, completion: @escaping(Bool, String, LogoutModel) -> Void) {
            let url = URLConstant.user_log_out
            let parameter = [
                "user_id": user_id,
                "auth_token": auth_token] as [String: Any]
            //print(parameter)
            var data = LogoutModel(message: "", status: "", data: nil)
         
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                        completion(false, "Oops!! We are running some problem, please try after some time", data)
                        return
                    }
                    print(url, responseObj)
                    if status == "success" {
                            data = LogoutModel(message: message, status: status, data: nil)
                            completion(true, message, data)
                    } else{
                        completion(false, message, data)
                    }
                case .failure:
                    completion(false, "Server problem! please try after some time", data)
                }
            }
            
        }
    }

