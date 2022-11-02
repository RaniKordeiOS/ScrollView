//
//  VerifyRes_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 30/09/22.

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper


class VerifyRes_VM {
        
        func getVerify(mob: String, device_id: String, completion: @escaping(Bool, String, VerifyResModel) -> Void) {
            let url = URLConstant.userVerify
            let parameter = [
                "mobile": mob,
                "device_id": device_id ] as [String: Any]
           print("\nParameter: ")
           print(parameter)
            var verifyData = VerifyResModel(userstatus: "")
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                        completion(false, "Oops!! We are running some problem, please try after some time", verifyData)
                        return
                    }
                    print("\nResponse verify: ")
                    print(url, responseObj)
                    if status == "Success" {
                        let data = responseObj["data"] as? [String: Any]
                        if !data!.isEmpty {
                            let userStatus = data!["userstatus"] as? String
                             verifyData = VerifyResModel(userstatus: userStatus ?? "")
                            completion(true, message, verifyData)
                            KeychainWrapper.standard.set(userStatus!, forKey: "userStatus")
                        } else{
                            completion(false, "Data not found", verifyData)
                        }
                    } else{
                        completion(false, message, verifyData)
                    }
                case .failure:
                    completion(false, "Server problem! please try after some time", verifyData)
                }
            }
        }
    }
