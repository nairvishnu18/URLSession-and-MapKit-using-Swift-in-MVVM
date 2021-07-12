//
//  ViewController.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 08/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, RequestStatus {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    var viewModel: ViewModelOpeartions!
    var vehicleOperations: VehicleOperations!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleOperations = VehicleServices()
        viewModel = ViewModelController(_requestStatus: self)
        viewModel.getData()
        
    }
    
    func didSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFail() {
        debugPrint("Operation Failed!!")
    }
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.dataModel!.count
        return viewModel.getRowCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! CarDeatilsTableViewCell
        
        tableCell.carImage.load(ImageURL: viewModel.dataModel![indexPath.row].carImageURL)
        tableCell.modelName.text = viewModel.dataModel![indexPath.row].modelName
        tableCell.makeName.text = viewModel.dataModel![indexPath.row].vehicleDetails.make.rawValue
        tableCell.licensePlate.text = viewModel.dataModel![indexPath.row].licensePlate
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let annotations = vehicleOperations.locateVehicle(
            latitude: viewModel.dataModel![indexPath.row].location.latitude,
            longitude: viewModel.dataModel![indexPath.row].location.longitude)
        
        mapView.addAnnotation(annotations)
        
    }
    
}


