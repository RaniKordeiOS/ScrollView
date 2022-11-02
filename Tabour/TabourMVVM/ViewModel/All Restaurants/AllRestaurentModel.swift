//
//  AllRestaurantModel.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//

import Foundation

struct ResAllRestaurantModel: Codable {
    let message, status: String?
    let data: [AllRestaurantModel]?
}

// MARK: - Datum
struct AllRestaurantModel: Codable {
    let id: Int?
    let name, email, phoneNumber, mobileNumber: String?
    let address, pincode, latitude, longitude: String?
    let restroType: Int?
    let cuisineType: String?
    let restroCuisines: [Cuisine]?
    let seatingOptions: [String]?
    let datumDescription, menuCategory: String?
    let parking: Int?
    let image: String?
    let status: Int?
    let availableSlots: [Slot]?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case phoneNumber = "phone_number"
        case mobileNumber = "mobile_number"
        case address, pincode, latitude, longitude
        case restroType = "restro_type"
        case cuisineType = "cuisine_type"
        case restroCuisines = "restro_cuisines"
        case seatingOptions = "seating_options"
        case datumDescription = "description"
        case menuCategory = "menu_category"
        case parking, image, status
        case availableSlots = "available_slots"
    }
}

/*
 {
       "user_id":"96",
         "auth_token":"ypbh2nqJuW38qfAkFFdj",
        "restro_type":1,
          "selected_date":"2022-10-15",
          "time_slot":"",
          "cuisine_type":""
 }
 
 {
     "message": "Restaurants fetched successfully",
     "status": "success",
     "data": [
         {
             "id": 4,
             "name": "Al Hubara Restaurant",
             "email": "hub@gmail.com",
             "phone_number": "8787676556",
             "mobile_number": "7689087678",
             "address": "Doha",
             "pincode": "678765",
             "latitude": "25.366268",
             "longitude": "71.567098",
             "restro_type": 1,
             "cuisine_type": "American",
             "restro_cuisines": [
                 {
                     "cuisine_id": 1,
                     "cuisine_name": "American"
                 },
                 {
                     "cuisine_id": 2,
                     "cuisine_name": "French"
                 }
             ],
             "seating_options": [],
             "description": "uiyte iuete upouoputuooey  oprypioeoy orooo",
             "menu_category": "1,2",
             "parking": 1,
             "image": "http://103.252.168.24/tabour/public/restaurants/20220924070708.jpg",
             "status": 1
         },
         {
             "id": 5,
             "name": "Al Nahham Restaurant",
             "email": "nahham@gmail.com",
             "phone_number": "6677567896",
             "mobile_number": "7689087678",
             "address": "Doha",
             "pincode": "678765",
             "latitude": "25.366268",
             "longitude": "71.567098",
             "restro_type": 1,
             "cuisine_type": "Lebanese",
             "restro_cuisines": [
                 {
                     "cuisine_id": 1,
                     "cuisine_name": "American"
                 },
                 {
                     "cuisine_id": 5,
                     "cuisine_name": "Italian"
                 }
             ],
             "seating_options": [],
             "description": "uiyte iuete upouoputuooey  oprypioeoy orooo",
             "menu_category": "1,5",
             "parking": 1,
             "image": "http://103.252.168.24/tabour/public/restaurants/20220924124838.jpg",
             "status": 1
         },
         {
             "id": 6,
             "name": "Radisson Blu Hotel",
             "email": "radisson@gmail.com",
             "phone_number": "985632147",
             "mobile_number": "7854236589",
             "address": "Salwa Road, Intersection of, C Ring Rd, Doha, Qatar",
             "pincode": "856245",
             "latitude": "25.27298",
             "longitude": "51.51319",
             "restro_type": 1,
             "cuisine_type": "Indian",
             "restro_cuisines": [
                 {
                     "cuisine_id": 1,
                     "cuisine_name": "American"
                 },
                 {
                     "cuisine_id": 5,
                     "cuisine_name": "Italian"
                 }
             ],
             "seating_options": [
                 "Outdoor"
             ],
             "description": "This 4-star hotel in the heart of Doha's shopping district features an outdoor pool and health club",
             "menu_category": "1,5",
             "parking": 1,
             "image": "http://103.252.168.24/tabour/public/restaurants/20221012084144.jpg",
             "status": 1
         },
         {
             "id": 7,
             "name": "Haldiram's Thaat Baat Restaurant",
             "email": "thaatbaat@gmail.com",
             "phone_number": "856254788",
             "mobile_number": "9623547852",
             "address": "125, Abhyankar Marg, Variety Square, Sitabuldi, Nagpur",
             "pincode": "440012",
             "latitude": "21.143298",
             "longitude": " 79.081237",
             "restro_type": 1,
             "cuisine_type": "Indian",
             "restro_cuisines": [
                 {
                     "cuisine_id": 2,
                     "cuisine_name": "French"
                 },
                 {
                     "cuisine_id": 5,
                     "cuisine_name": "Italian"
                 }
             ],
             "seating_options": [
                 "Cafe"
             ],
             "description": "Vegetarian Friendly, Vegan Options, Gluten Free Options",
             "menu_category": "2,5",
             "parking": 0,
             "image": "http://103.252.168.24/tabour/public/restaurants/20221013060527.jpg",
             "status": 1
         },
         {
             "id": 9,
             "name": "Flavours Restaurant",
             "email": "flavours@gmail.com",
             "phone_number": "856231458",
             "mobile_number": "9856324",
             "address": "Vivekanand Nagar, Nagpur, Maharashtra",
             "pincode": "440015",
             "latitude": "21.111782",
             "longitude": "79.068236",
             "restro_type": 1,
             "cuisine_type": "Indian",
             "restro_cuisines": [
                 {
                     "cuisine_id": 11,
                     "cuisine_name": "Beverages"
                 }
             ],
             "seating_options": [
                 "Cafe",
                 "Casual dining"
             ],
             "description": "Flavours Restaurant",
             "menu_category": "11",
             "parking": 0,
             "image": "http://103.252.168.24/tabour/public/restaurants/20221013092156.jpg",
             "status": 1
         }
     ]
 }
 
*/
