//
//  Slot.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 18/10/22.
//

import Foundation

// MARK: - AvailableSlot
struct Slot: Codable {
    let slot: String?
    let booked, availableSlotLeft: Int?
    
    enum CodingKeys: String, CodingKey {
        case slot, booked
        case availableSlotLeft = "left"
    }
}
