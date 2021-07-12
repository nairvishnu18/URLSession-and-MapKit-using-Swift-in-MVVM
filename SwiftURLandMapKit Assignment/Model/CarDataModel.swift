//
//  CarDataModel.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 08/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation

// MARK: - Root Model
struct CarDataModel: Codable {
    let modelName: String
    let carImageURL: String
    let licensePlate: String
    let vehicleDetails: VehicleDetails
    let location: Location

    enum CodingKeys: String, CodingKey {
        case modelName, licensePlate
        case carImageURL = "carImageUrl"
        case vehicleDetails, location
    }
}


enum SeriesType: String, Codable {
    case lux = "LUX"
    case regular = "REGULAR"
}

enum Make: String, Codable {
    case bmw = "BMW"
}

// MARK: - VehicleDetails
struct VehicleDetails: Codable {
    let name: String
    let make: Make
    let series: SeriesType

    enum CodingKeys: String, CodingKey {
        case name, make,series
    }
}


// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}
