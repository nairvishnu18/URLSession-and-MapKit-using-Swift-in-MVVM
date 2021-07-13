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
    func addAnnotationstoMap() -> [MKPointAnnotation]
    func getRegionCoordinates() -> MKCoordinateRegion
    
}


protocol OutputDelegate: class {
    func didSuccess()
    func didFail()
}



class ViewModelController: ViewModelOpeartions {
    
    var dataModel: [CarDataModel]?
    private let apiHandler : ApiHandler
    weak var outputDelegate: OutputDelegate?
    
    init(_client: ApiHandler = ApiHandler(), _output: OutputDelegate) {
        self.apiHandler = _client
        self.outputDelegate = _output
    }
    
    
    func getData() {
        guard let requestURL = Constants.baseURL else {
            debugPrint(CustomErrors.invalidURL.rawValue)
            return
        }
        apiHandler.getAPIData(from:requestURL, resultType: [CarDataModel].self) { [weak self] (apiData, error)  in
            if error == nil {
                //debugPrint(carData)
                self?.dataModel = apiData
                self?.outputDelegate?.didSuccess()
                
            } else  {
                debugPrint(CustomErrors.modelDataError.rawValue)
                self?.outputDelegate?.didFail()
            }
        }
    }
    
    func getRowCount() -> Int {
        return dataModel?.count ?? 0
    }
    
    func addAnnotationstoMap() -> [MKPointAnnotation] {
        var locations = [[String:Double]]()
        dataModel?.forEach({ (coordinates) in
            locations.append(
                [
                    "latitude":coordinates.location.latitude,
                    "longitude": coordinates.location.longitude
                ])
        })
        var pinAnnotations: [MKPointAnnotation] = []
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.coordinate = CLLocationCoordinate2D(
                latitude: location["latitude"]!,
                longitude: location["longitude"]!
            )
            pinAnnotations.append(annotations)
        }
        
        return pinAnnotations
    }
    
    func getRegionCoordinates() -> MKCoordinateRegion {
        let centerCoordinates = CLLocationCoordinate2D(latitude: 12.950415, longitude: 77.642605)
        let mapCoordinates = MKCoordinateRegion(center: centerCoordinates, latitudinalMeters: 600, longitudinalMeters: 600)
        
        return mapCoordinates
    }
    
}

