//
//  AllFoodCategories_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class AllFoodCategories_VM {
        
        func getFoodCategories(user_id: Int, auth_token: String, completion: @escaping(Bool, String, [AllFoodCategriesModel]) -> Void) {
            let url = URLConstant.all_food_categories
            let parameter = [
                "user_id": user_id,
                "auth_token": auth_token] as [String: Any]
            //print(parameter)
            var foodCategoryData : [AllFoodCategriesModel] = []
            //foodCategoryData.removeAll()
            
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                        completion(false, "Oops!! We are running some problem, please try after some time", foodCategoryData)
                        return
                    }
                    //print(url, responseObj)
                    if status == "success" {
                        let data = responseObj["data"] as? [[String: Any]]
                        if !data!.isEmpty {
                            for list in data! {
                                
                                let id = list["id"] as? Int
                                let name = list["name"] as? String
                                let image = list["image"] as? String
                                 var foodCategory = AllFoodCategriesModel(id: id ?? 0, name: name ?? "", image: image ?? "")
                             
                                foodCategoryData.append(foodCategory)
                               // print(foodCategoryData.count)
                            }
                            completion(true, message, foodCategoryData)
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

