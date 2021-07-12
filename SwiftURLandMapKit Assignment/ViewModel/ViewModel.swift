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
        let requestURL = "http://www.mocky.io/v2/5dc3f2c13000003c003477a0"
        apiHandler.getAPIData(from: URL(string: requestURL)!, resultType: [CarDataModel].self) { [weak self] (carData) in
            if carData.count != 0 {
                //debugPrint(carData)
                self?.dataModel = carData
                self?.outputDelegate?.didSuccess()
                
            } else  {
                debugPrint("Error in assigning to Model")
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
//        let regionCoordinates = MKCoordinateRegion(
//            center: centerCoordinates,
//            span: MKCoordinateSpan(
//                latitudeDelta: 0.1,
//                longitudeDelta: 0.1))
        
        let mapCoordinates = MKCoordinateRegion(center: centerCoordinates, latitudinalMeters: 500, longitudinalMeters: 500)

        return mapCoordinates
    }

}

