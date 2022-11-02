//
//  Cuisine.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 20/10/22.
//

import Foundation

// MARK: - RestroCuisine
struct Cuisine: Codable {
    let cuisineID: Int?
    let cuisineName: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisineID = "cuisine_id"
        case cuisineName = "cuisine_name"
    }
}

