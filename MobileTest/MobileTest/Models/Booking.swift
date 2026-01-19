//
//  BookingModels.swift
//  MobileTest
//
//  Created by yu on 2026/1/16.
//

import Foundation

// MARK: - Booking
struct Booking: Codable, Identifiable {
    let shipReference: String
    let shipToken: String
    let canIssueTicketChecking: Bool
    let expiryTime: String  
    let duration: Int
    let segments: [Segment]
    
    var id: String { shipToken }
    var expiryDate: Date? {
        guard let timestamp = TimeInterval(expiryTime) else { return nil }
        return Date(timeIntervalSince1970: timestamp)
    }
}

// MARK: - Segment
struct Segment: Codable, Identifiable {
    let id: Int
    let originAndDestinationPair: OriginDestinationPair
}

// MARK: - OriginDestinationPair
struct OriginDestinationPair: Codable {
    let destination: Location
    let destinationCity: String
    let origin: Location
    let originCity: String
}

// MARK: - Location
struct Location: Codable {
    let code: String
    let displayName: String
    let url: String
}
