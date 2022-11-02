//
//  AllRestaurants_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

   

class AllRestaurants_VM {
    lazy var parameters: [String: Any] = [
        "user_id":"",
                "auth_token":"",
                "restro_type":"",
                "selected_date":"2022-10-20",
                "time_slot":"",
                "cuisine_type":"",
                "latitude":"0.0",
                "longitude":"0.0"
    ]
    var responseAllRestaurantModel : ResAllRestaurantModel?
    var listResData : [AllRestaurantModel] = []
    var listResDataNil : [AllRestaurantModel] = []
    func getAllRestaurants(user_id: Int, auth_token: String, resType: Int, cuisineId: String, completion: @escaping(Bool, String, [AllRestaurantModel]) -> Void) {
        let url = URLConstant.all_restaurants
        self.parameters.updateValue(user_id, forKey: "user_id")
        self.parameters.updateValue(auth_token, forKey: "auth_token")
        self.parameters.updateValue(resType, forKey: "restro_type")
        self.parameters.updateValue(cuisineId, forKey: "cuisine_type")
        print(parameters)
        
        AF.request(url,method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: nil).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success:
                if let json = response.data
 {
                    let decoder = JSONDecoder()
                    self.responseAllRestaurantModel = try? decoder.decode(ResAllRestaurantModel.self, from: json)
                    self.listResData = self.responseAllRestaurantModel?.data! ?? self.listResDataNil
                    completion(true, "Restaurants fetched successfully", self.listResData)
                }
                
            case let .failure(error):
                completion(false, "Server problem! please try after some time", self.listResData)
            }//switch
            
        }
        
    }
}

