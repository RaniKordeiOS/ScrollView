//
//  ProfileModel.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//

import Foundation
struct ProfileModel {
    var id: Int?
    var fname, lname, country_phonecode, mobile_no, email : String?
    var earned_points: Int?
    var profile_pic, subscription_id: String?
}
/*
 {
    "user_id": 100,
   "auth_token": "G60x6HD8mfGK07YXAHuD"
 }
 {
     "message": "User profile fetched successfully",
     "status": "success",
     "data": {
         "id": 100,
         "fname": "Mahi",
         "lname": "Domino",
         "country_phonecode": "974",
         "mobile_no": "98989998",
         "email": "mahi-mahi@gmail.com",
         "profile_pic": "",
         "earned_points": 0,
         "subscription_id": " "
     }
 }

*/
