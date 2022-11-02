//
//  NearByResModel.swift


import Foundation

// MARK: - NearByRestaurants
struct ResponseNearByRestaurants: Codable {
    let message, status: String?
    let data: [NearByRestaurantsModel]?
}

// MARK: - Datum
struct NearByRestaurantsModel: Codable {
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
    let distance: Double?
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
        case parking, image, status, distance
        case availableSlots = "available_slots"
    }
}
   
/*
 "{
 "user_id":"96",
        "auth_token":"ypbh2nqJuW38qfAkFFdj",
        "latitude":"25.366268",
        "longitude":"71.567098",
          "selected_date":"2022-10-15",
         "time_slot":"",
        "restro_type":"1",
         "cuisine_type":"5"
 }"
 {
     "message": "Nearby Restaurants fetched successfully",
     "status": "success",
     "data": [
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
             "status": 1,
             "distance": 0,
             "available_slots": [
                 {
                     "slot": "10:00 AM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "10:30 AM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "11:00 AM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "11:30 AM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "12:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "12:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "01:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "01:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "02:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "02:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "03:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "03:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "04:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "04:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "05:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "05:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "06:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "06:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "07:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "07:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "08:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "08:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "09:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "09:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "10:00 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "10:30 PM",
                     "booked": 0,
                     "left": 10
                 },
                 {
                     "slot": "11:00 PM",
                     "booked": 0,
                     "left": 10
                 }
             ]
         },
         {
             "id": 14,
             "name": "Eleven Madison Park",
             "email": "eleven@gmail.com",
             "phone_number": "9874562134",
             "mobile_number": "987456213",
             "address": "KH-758, Siraspur Rd, Sector 18, Rohini, Delhi, 110042, India",
             "pincode": "456123",
             "latitude": "28.6609677",
             "longitude": "77.2276704",
             "restro_type": 1,
             "cuisine_type": "abczxz",
             "restro_cuisines": [
                 {
                     "cuisine_id": 2,
                     "cuisine_name": "French"
                 },
                 {
                     "cuisine_id": 5,
                     "cuisine_name": "Italian"
                 },
                 {
                     "cuisine_id": 11,
                     "cuisine_name": "Beverages"
                 }
             ],
             "seating_options": [
                 "Casual dining"
             ],
             "description": "lorem ipsummmm nbnvbnfgh",
             "menu_category": "2,5,11",
             "parking": 1,
             "image": "http://103.252.168.24/tabour/public/restaurants/20221013112121.jpg",
             "status": 1,
             "distance": 411.8680526220114,
             "available_slots": [
               
                 {
                     "slot": "09:30 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "10:00 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "10:30 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "11:00 PM",
                     "booked": 0,
                     "left": 0
                 }
             ]
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
             "status": 1,
             "distance": 565.3998540747365,
             "available_slots": [
              
             ]
         },
         {
             "id": 11,
             "name": "JIMO",
             "email": "jimo@gmail.com",
             "phone_number": "8562365",
             "mobile_number": "784523659",
             "address": "New Sneh Nagar, Nagpur, Maharashtra",
             "pincode": "440015",
             "latitude": "21.108141",
             "longitude": "79.067905",
             "restro_type": 1,
             "cuisine_type": "Indian",
             "restro_cuisines": [
                 {
                     "cuisine_id": 5,
                     "cuisine_name": "Italian"
                 }
             ],
             "seating_options": [
                 "Cafe",
                 "Casual dining"
             ],
             "description": "Enjoy Meal",
             "menu_category": "5",
             "parking": 1,
             "image": "http://103.252.168.24/tabour/public/restaurants/20221013101042.jpg",
             "status": 1,
             "distance": 566.0212386388479,
             "available_slots": [
                 {
                     "slot": "06:00 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "06:30 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "07:00 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "07:30 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "08:00 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "08:30 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "09:00 PM",
                     "booked": 0,
                     "left": 0
                 },
             ]
         },
         {
             "id": 10,
             "name": "Ni Hao Restaurant",
             "email": "nihao@gmail.com",
             "phone_number": "895632147",
             "mobile_number": "74523648",
             "address": "Chatrapati Nagar ,Nagpur",
             "pincode": "441119",
             "latitude": "21.106174",
             "longitude": "79.069815",
             "restro_type": 1,
             "cuisine_type": "Chinese",
             "restro_cuisines": [
                 {
                     "cuisine_id": 5,
                     "cuisine_name": "Italian"
                 }
             ],
             "seating_options": [
                 "Outdoor",
                 "Casual dining"
             ],
             "description": "Enjoy Meal",
             "menu_category": "5",
             "parking": 1,
             "image": "http://103.252.168.24/tabour/public/restaurants/20221013093317.png",
             "status": 1,
             "distance": 566.2025540189555,
             "available_slots": [
                 {
                     "slot": "05:30 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "06:00 PM",
                     "booked": 0,
                     "left": 0
                 },
                 {
                     "slot": "06:30 PM",
                     "booked": 0,
                     "left": 0
                 },
             ]
         },
         {
             "id": 19,
             "name": "Paper Moon",
             "email": "moon@gmail.com",
             "phone_number": "5698547",
             "mobile_number": "985632154",
             "address": "Jaidah Square، Al Matar St, Doha, Qatar",
             "pincode": "45875",
             "latitude": "25.2730197",
             "longitude": "51.5447989",
             "restro_type": 1,
             "cuisine_type": "Italian",
             "restro_cuisines": [
                 {
                     "cuisine_id": 5,
                     "cuisine_name": "Italian"
                 },
                 {
                     "cuisine_id": 11,
                     "cuisine_name": "Beverages"
                 }
             ],
             "seating_options": [
                 "Outdoor",
                 "Casual dining"
             ],
             "description": "Enjoy Meal",
             "menu_category": "5,11",
             "parking": 1,
             "image": "http://103.252.168.24/tabour/public/restaurants/20221018085210.jpg",
             "status": 1,
             "distance": 1251.1492236446322,
             "available_slots": [
              
             ]
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
             "status": 1,
             "distance": 1253.1247655764857,
             "available_slots": [
                 
             ]
         }
     ]
 }
*/
