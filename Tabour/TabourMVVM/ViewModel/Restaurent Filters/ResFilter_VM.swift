//
//  ResFilter_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 20/10/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class ResFilter_VM {
    lazy var parameters: [String: Any] = [
        "user_id": "",
        "auth_token": "",
        "latitude":"25.366268",
        "longitude":"71.567098",
        "restro_type":"",
        "restro_name":"",
        "seating_options":"",
        "distance_radius":""
    ]
    var responseModel : ResponseResFilters?
    var listResData : [ResFiltersModel] = []
    var listResDataNil : [ResFiltersModel] = []
    
    func getRestaurantsByFilters(user_id: Int, auth_token: String, restro_name: String , completion: @escaping(Bool, String, [ResFiltersModel]) -> Void) {
        let url = URLConstant.restaurants_filter
        self.parameters.updateValue(user_id, forKey: "user_id")
        self.parameters.updateValue(auth_token, forKey: "auth_token")
        self.parameters.updateValue(restro_name, forKey: "restro_name")
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
                    self.responseModel = try? decoder.decode(ResponseResFilters.self, from: json)
                    print("Message:  \(self.responseModel?.status!)")
                    self.listResData = self.responseModel?.data! ?? self.listResDataNil
                    
                    print("count:  \(self.listResData.count)")
                    completion(true, "Restaurants fetched successfully", self.listResData)
                }
                
            case let .failure(error):
                completion(false, "Server problem! please try after some time", self.listResData)
            }//switch
            
        }
        
    }
}


