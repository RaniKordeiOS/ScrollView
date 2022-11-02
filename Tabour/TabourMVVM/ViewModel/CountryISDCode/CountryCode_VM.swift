//
//  CountryCode_VM.swift
//  Tabour
import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper


class CountryCode_VM {
    
    func getCountryDetailsAPI(completion: @escaping(Bool, String, [CountryCodeModel]) -> Void) {
        let url = URLConstant.countryData
        var countryData = [CountryCodeModel]()
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let responseObj = response.value as? [String: Any], let status = responseObj["status"] as? String, let message = responseObj["message"] as? String else{
                    completion(false, "Oops!! We are running some problem, please try after some time", countryData)
                    return
                }
                // print(url, responseObj)
                if status == "success" {
                    let data = responseObj["data"] as? [[String: Any]]
                    if !data!.isEmpty {
                        for list in data! {
                            
                            let id = list["id"] as? Int
                            let name = list["name"] as? String
                            let iso2 = list["iso2"] as? String
                            let phonecode = list["phonecode"] as? String
                            
                            let country = CountryCodeModel(id: id ?? 0, name: name ?? "", iso2: iso2 ?? "", phonecode: phonecode ?? "")
                            countryData.append(country)
                        }
                        completion(true, message, countryData)
                    }
                    else{
                        completion(false, "Data not found", countryData)
                    }
                } else{
                    completion(false, message, countryData)
                }
            case .failure:
                completion(false, "Server problem! please try after some time", countryData)
            }
        }
    }
}

