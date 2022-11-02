//
//  ResFilterModel.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 20/10/22.
//

import Foundation

// MARK: - ResponseResFilters
struct ResponseResFilters: Codable {
    let message, status: String?
    let data: [ResFiltersModel]?
}
// MARK: - ResFiltersModel
struct ResFiltersModel: Codable {
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
