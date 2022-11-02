//
//  OTPResModel.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 30/09/22.
//

import Foundation

struct OTPResModel {
    var message, status: String?
    var otp: Int?
    var data: DataClass?
}

struct DataClass {
}

//{
//    "message": "OTP from Tabour your otp is 1114",
//    "status": "Success",
//    "otp": 1114,
//    "data": {}
//}

//input
//        "{
//                ""mobile"":""1234567839"",
//                ""device_id"":""124578125125222"",
//                ""device_type"":""android"",
//                ""player_id"":""asdzxcvbnm""
//        }"
//   output: "{
//        ""message"": ""login Successfull"",
//        ""status"": ""Success"",
//        ""data"": {
//            ""userId"": 12,
//            ""authToken"": ""JX1SdDu3QXbEXyJlEVCg""
//        }
//    }"

