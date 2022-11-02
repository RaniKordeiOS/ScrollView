//
//  NearByRestaurants_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 11/10/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class NearByRestaurants_VM {
    lazy var parameters: [String: Any] = [
        "user_id": "",
        "auth_token": "",
        "latitude":"25.366268",
        "longitude":"71.567098",
        "selected_date":"2022-10-19",
        "time_slot":"",
        "restro_type":"",
        "cuisine_type":""
    ]
    var responseNearByRestaurantModel : ResponseNearByRestaurants?
    var listResData : [NearByRestaurantsModel] = []
    var listResDataNil : [NearByRestaurantsModel] = []
    func getNearByRestaurants(user_id: Int, auth_token: String, resType: Int, latitude: String, longitude: String, completion: @escaping(Bool, String, [NearByRestaurantsModel]) -> Void) {
        let url = URLConstant.nearby_restaurants
        self.parameters.updateValue(user_id, forKey: "user_id")
        self.parameters.updateValue(auth_token, forKey: "auth_token")
        self.parameters.updateValue(resType, forKey: "restro_type")
       // self.parameters.updateValue(latitude, forKey: "latitude")
        //self.parameters.updateValue(longitude, forKey: "longitude")
        //print(parameters)
        
        AF.request(url,method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: nil).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success:
                if let json = response.data
                {
                    let decoder = JSONDecoder()
                    self.responseNearByRestaurantModel = try? decoder.decode(ResponseNearByRestaurants.self, from: json)
                    self.listResData = self.responseNearByRestaurantModel?.data! ?? self.listResDataNil
                    completion(true, "Restaurants fetched successfully", self.listResData)
                }
                
            case let .failure(error):
                completion(false, "Server problem! please try after some time", self.listResData)
            }//switch
            
        }
        
    }
}


