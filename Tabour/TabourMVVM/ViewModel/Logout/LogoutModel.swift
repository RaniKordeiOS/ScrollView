//
//  LogoutModel.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 07/10/22.
//

import Foundation

struct LogoutModel
{
    var message, status: String?
    var data: Class2?
}
struct Class2 {
}
/*
{
     "user_id": 56,
     "auth_token": "QWgGW9ji537gz5oJdsy6"
}
{
    "message": "User logged out successfully",
    "status": "success",
    "data": {}
}
{
    "message": "Token mismatch",
    "status": "fail",
    "data": {}
}
*/
