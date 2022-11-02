//
//  Login_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class Login_VM {
    
    func userLogin(mob: String, devID: String, devType: String, playerID: String, completion: @escaping(Bool, String, LoginModel) -> Void) {
        let url = URLConstant.login
        let parameter = ["mobile": mob,
                         "device_id": devID,
                         "device_type": devType,
                         "player_id": playerID] as [String: Any]
        print("\nParameter: ")
        print(parameter)
        var loginData = LoginModel(userId: 0,authToken: "0")
        
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                    completion(false, "Oops!! We are running some problem, please try after some time", loginData)
                    return
                }
                print("\nResponse user login: ")
                print(url, responseObj)
                if status == "Success" {
                    let data = responseObj["data"] as? [String: Any]
                    if !data!.isEmpty {
                        
                        let id = data!["userId"] as? Int
                        let authToken = data!["authToken"] as? String
                        loginData = LoginModel(userId: id ?? 0,authToken: authToken ?? "")
                        completion(true, message, loginData)
                        
                    } else{
                        completion(false, "Data not found", loginData)
                    }
                } else{
                    completion(false, message, loginData)
                }
            case .failure:
                completion(false, "Server problem! please try after some time", loginData)
                print("i am in login")
            }
        }
    }
}

    

    


        func userLoginnn(mob: String, devID: String, devType: String, playerID: String, completion: @escaping(Bool, String, LoginModel) -> Void) {
            let url = URLConstant.login
            let parameter = ["mobile": mob, "device_id": devID, "device_type": devType, "player_id": playerID] as [String: Any]
            print(parameter)
            var loginData = LoginModel(userId: 0,authToken: "0")
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                        completion(false, "Oops!! We are running some problem, please try after some time", loginData)
                        return
                    }
                    print(url, responseObj)
                    if status == "Success" {
                        let data = responseObj["data"] as? [String: Any]
                        if !data!.isEmpty {
                            let id = data!["userId"] as? Int
                            let authToken = data!["authToken"] as? String
                            loginData = LoginModel(userId: id ?? 0,authToken: authToken ?? "")
                            //print(loginData)
                            completion(true, message, loginData)
                        } else{
                            completion(false, "Data not found", loginData)
                        }
                    } else{
                        completion(false, message, loginData)
                    }
                case .failure:
                    completion(false, "Server problem! please try after some time", loginData)
                }
            }
        }
    


