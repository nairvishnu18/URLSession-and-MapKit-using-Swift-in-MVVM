//
//  ViewModel.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 09/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation
import MapKit

protocol ViewModelOpeartions {
    var dataModel: [CarDataModel]? {get}
    func getData()
    func getRowCount() -> Int
    
}

protocol VehicleOperations {
    func locateVehicle(latitude: Double, longitude: Double) -> MKPointAnnotation
}

protocol RequestStatus: class {
    func didSuccess()
    func didFail()
}

class ViewModelController: ViewModelOpeartions {
   

    var dataModel: [CarDataModel]?
    private let apiHandler : ApiHandler
    weak var requestStatusDelegate: RequestStatus?
    
    init(_client: ApiHandler = ApiHandler(), _requestStatus: RequestStatus) {
        self.apiHandler = _client
        self.requestStatusDelegate = _requestStatus
    }
    
    
    func getData() {
        let requestURL = "http://www.mocky.io/v2/5dc3f2c13000003c003477a0"
        apiHandler.getAPIData(from: URL(string: requestURL)!, resultType: [CarDataModel].self) { [weak self] (carData) in
            if carData.count != 0 {
                //debugPrint(carData)
                self?.dataModel = carData
                self?.requestStatusDelegate?.didSuccess()
                
            } else  {
                debugPrint("Error in assigning to Model")
                self?.requestStatusDelegate?.didFail()
            }
        }
    }
    
    func getRowCount() -> Int {
        return dataModel?.count ?? 0
    }
    
 
}

class VehicleServices: VehicleOperations {
    
    
    func locateVehicle(latitude: Double, longitude: Double) -> MKPointAnnotation {
        debugPrint("Locating... \(latitude) & \(longitude)")
        let annotations = MKPointAnnotation()
        annotations.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return annotations
    }
    
    
}
