//
//  Constant.swift

import Foundation

struct URLConstant {
    static let baseURl = "http://103.252.168.24/tabour/api/user/"
    
    static let countryData = baseURl + "country_data"
    static let sendotp = baseURl + "sendotp"  //1
    static let userVerify = baseURl + "after_otp_varification"  //2
    static let login = baseURl + "login"//6
    static let register = baseURl + "register" //3
    static let user_log_out = baseURl + "user_log_out"
    static let user_deactivate = baseURl + "user_account_deactivate"
    static let social_login = baseURl + "social_login"
    //MARK:  home/ dashboard
    static let all_food_categories = baseURl + "all_food_categories"
    static let all_restaurants = baseURl + "all_restaurants"
    static let nearby_restaurants = baseURl + "nearby_restaurants"
    //MARK:   profile
    static let user_profile = baseURl + "user_profile"
    static let user_profile_update = baseURl + "user_profile_update"
    //MARK:   save
    static let save_establishment = baseURl + "save_establishment"
    static let unsave_establishment = baseURl + "unsave_establishment"
    static let saved_establishment = baseURl + "saved_establishment"
    
    static let restaurants_filter = baseURl + "restaurants_filter"
    static let establishment_details =  baseURl + "establishment_details"
    
    //static let all_restaurants = baseURl + "all_restaurants"
    static let googlePlacesAPIKey = "AIzaSyCgOmJ8H2dnCCJTFYg1pK73IAE8M0mrvJ0"
}
//http://103.252.168.24/tabour/api/user/country_data


