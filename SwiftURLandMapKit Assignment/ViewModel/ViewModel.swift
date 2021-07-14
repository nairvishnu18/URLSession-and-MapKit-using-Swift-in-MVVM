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
    
    
    /// Fucntion to get API data from API Handler.
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
    
    /// Returns the row count for tableView
    ///
    /// - Returns: row count of type **Integer**
    func getRowCount() -> Int {
        return dataModel?.count ?? 0
    }
    
    /// Function to get Location coordinates to plot in MapView.
    ///
    /// - Returns: Array of type MKPointAnnotation.
    func addAnnotationstoMap() -> [MKPointAnnotation] {
        var locations = [[String:Double]]()
        var pinAnnotations: [MKPointAnnotation] = []
        
        dataModel?.forEach({ (coordinates) in
            locations.append(
                [
                    "latitude":coordinates.location.latitude,
                    "longitude": coordinates.location.longitude
                ])
        })
        
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
    
    /// Function to get coordinates to locate a region in map.
    ///
    /// - Returns: Coordinate Regions for zoom level of region.
    func getRegionCoordinates() -> MKCoordinateRegion {
        let centerCoordinates = CLLocationCoordinate2D(latitude: 12.950415, longitude: 77.642605)
        let mapCoordinates = MKCoordinateRegion(center: centerCoordinates, latitudinalMeters: 600, longitudinalMeters: 600)
        
        return mapCoordinates
    }
    
}

