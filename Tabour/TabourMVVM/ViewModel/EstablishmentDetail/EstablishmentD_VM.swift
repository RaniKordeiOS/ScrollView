//
//  EstablishmentD_VM.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 27/10/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class EstablishmentD_VM {
    lazy var parameters: [String: Any] = [
        "user_id": "",
        "auth_token": "",
        "restaurant_id":""
    ]
    var responseModel : ResponseEstablishDetail?
    var listResData : EstDetail?
    var listResDataNil = EstDetail(id: 0, name: "", email: "", phoneNumber: "", mobileNumber: "", address: "", pincode: "", latitude: "", longitude: "", restroType: 0, cuisineType: "", restroCuisines: nil, seatingOptions: [""], dataDescription: "", menuCategory: "", parking: 0, image: "", images: nil, workingHours: nil)
    
    func getEsDetails(user_id: Int, auth_token: String, resID: String, completion: @escaping(Bool, String, EstDetail) -> Void) {
        
        let url = URLConstant.establishment_details
        self.parameters.updateValue(user_id, forKey: "user_id")
        self.parameters.updateValue(auth_token, forKey: "auth_token")
        self.parameters.updateValue(resID, forKey: "restaurant_id")
       // self.parameters.updateValue(latitude, forKey: "latitude")
        //self.parameters.updateValue(longitude, forKey: "longitude")
        
        
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
                    self.responseModel = try? decoder.decode(ResponseEstablishDetail.self, from: json)
                    
                    self.listResData = self.responseModel?.data!
                    
                    completion(true, "Restaurants fetched successfully", self.listResData!)
                }
                
            case let .failure(error):
                completion(false, "Server problem! please try after some time", self.listResData!)
            }//switch
            
        }
        
    }
}


