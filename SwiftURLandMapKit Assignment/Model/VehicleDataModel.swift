//
//  CarDataModel.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 08/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation

// MARK: - Response Data Model
struct VehicleDataModel: Decodable {
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


enum SeriesType: String, Decodable {
    case lux = "LUX"
    case regular = "REGULAR"
}

enum Make: String, Decodable {
    case bmw = "BMW"
}

// MARK: - VehicleDetails
struct VehicleDetails: Decodable {
    let name: String
    let make: Make
    let series: SeriesType

    enum CodingKeys: String, CodingKey {
        case name, make,series
    }
}


// MARK: - Location
struct Location: Decodable {
    let latitude, longitude: Double
}
