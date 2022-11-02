//
//  EstablishmentModel.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 27/10/22.
//

import Foundation
// MARK: - ResponseEstablishDetail
struct ResponseEstablishDetail: Codable {
    let message, status: String?
    let data: EstDetail?
}

// MARK: - DataClass
struct EstDetail: Codable {
    let id: Int?
    let name, email, phoneNumber, mobileNumber: String?
    let address, pincode, latitude, longitude: String?
    let restroType: Int?
    let cuisineType: String?
    let restroCuisines: [Cuisine]?
    let seatingOptions: [String]?
    let dataDescription, menuCategory: String?
    let parking: Int?
    let image: String?
    let images: [EstImage]?
    let workingHours: [WorkingHour]?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case phoneNumber = "phone_number"
        case mobileNumber = "mobile_number"
        case address, pincode, latitude, longitude
        case restroType = "restro_type"
        case cuisineType = "cuisine_type"
        case restroCuisines = "restro_cuisines"
        case seatingOptions = "seating_options"
        case dataDescription = "description"
        case menuCategory = "menu_category"
        case parking, image, images
        case workingHours = "working_hours"
    }
}

// MARK: - Image
struct EstImage: Codable {
    let id: Int?
    let image: String?
    let imgType: String?
    let addedBy: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, image
        case imgType = "img_type"
        case addedBy = "added_by"
    }
}

// MARK: - WorkingHour
struct WorkingHour: Codable {
    let day, openingTime, closingTime: String?

    enum CodingKeys: String, CodingKey {
        case day
        case openingTime = "opening_time"
        case closingTime = "closing_time"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
