//
//  ProfileUpdate_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 07/10/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class ProfileUpdate_VM {
        
        func updateUserProfile(user_id: Int, auth_token: String, completion: @escaping(Bool, String, AllFoodCategriesModel) -> Void) {
            let url = URLConstant.all_food_categories
            let parameter = [
                "user_id": user_id,
                "auth_token": auth_token] as [String: Any]
            print(parameter)
            var foodCategoryData = AllFoodCategriesModel(id: 0, name: "", image: "")
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                        completion(false, "Oops!! We are running some problem, please try after some time", foodCategoryData)
                        return
                    }
                    print(url, responseObj)
                    if status == "success" {
                        let data = responseObj["data"] as? [String: Any]
                        if !data!.isEmpty {
                            let id = data!["id"] as? Int
                            let name = data!["name"] as? String
                            let image = data!["image"] as? String
                            foodCategoryData = AllFoodCategriesModel(id: id ?? 0, name: name ?? "", image: image ?? "")
                            completion(true, message, foodCategoryData)
                           // KeychainWrapper.standard.set(userStatus!, forKey: "userStatus")
                        } else{
                            completion(false, "Data not found", foodCategoryData)
                        }
                    } else{
                        completion(false, message, foodCategoryData)
                    }
                case .failure:
                    completion(false, "Server problem! please try after some time", foodCategoryData)
                }
            }
        }
    }


