//
//  Profile_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class Profile_VM {
        
        func getUserProfile(user_id: Int, auth_token: String, completion: @escaping(Bool, String, ProfileModel) -> Void) {
            let url = URLConstant.user_profile
            let parameter = [
                "user_id": user_id,
                "auth_token": auth_token] as [String: Any]
            //print(parameter)
            var userProfileData = ProfileModel(id: 100, fname: "", lname: "", country_phonecode: "", mobile_no: "", email: "", earned_points: 0, profile_pic: "", subscription_id: "")
            
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                        completion(false, "Oops!! We are running some problem, please try after some time", userProfileData)
                        return
                    }
                    print(url, responseObj)
                    if status == "success" {
                        let data = responseObj["data"] as? [String: Any]
                        if !data!.isEmpty {
                            let id = data!["id"] as? Int
                            let name = data!["fname"] as? String
                            let last = data!["lname"] as? String
                            let mobile_no = data!["mobile_no"] as? String
                            let country_phonecode = data!["country_phonecode"] as? String
                            let profile_pic = data!["profile_pic"] as? String

                            userProfileData = ProfileModel(id: id ?? 0 ,fname: name ?? "", lname: last ?? "", country_phonecode: country_phonecode ?? "", mobile_no: mobile_no ?? "", email: "", earned_points: 0, profile_pic: profile_pic ?? "", subscription_id: "")
                            
                            completion(true, message, userProfileData)
                        } else{
                            completion(false, "Data not found", userProfileData)
                        }
                    } else{
                        completion(false, message, userProfileData)
                    }
                case .failure:
                    completion(false, "Server problem! please try after some time", userProfileData)
                }
            }
        }
    }


