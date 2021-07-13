//
//  Constants.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 13/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let baseURL = URL(string: "http://www.mocky.io/v2/5dc3f2c13000003c003477a0")
    static let annotationImage = UIImage(named: "carIcon")
    static let defaultImage = UIImage(named: "defaultImage")
    
   
}

enum CustomErrors: String {
    case invalidURL = "Error: Invalid URL"
    case modelDataError = "Error: Error in assigning data to Model"
    case noDataFound = "Error: No Data Fetched from API"
    case didFail = "Failed to fetch Data"
    
}
