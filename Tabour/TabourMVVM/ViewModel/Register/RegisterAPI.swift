//
//  RegisterAPI.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 30/09/22.
//

import Foundation
struct RegModel {
    var userId: Int?
    var authToken, fname, lname, country_phonecode, mobile_no, profile_pic: String?
}
/*
 {  //same email
     "message": "The email has already been taken.",
     "status": "fail",
     "data": {}
 }
 {//same mobile number
     "message": "user already exist please login",
     "status": "Success",
     "data": {
         "userstatus": "1"
     }
 
*/
