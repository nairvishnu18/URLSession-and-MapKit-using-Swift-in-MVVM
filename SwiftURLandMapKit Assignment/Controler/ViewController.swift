//
//  ViewController.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 08/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, OutputDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    var viewModel: ViewModelOpeartions!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModelController(_output: self)
        viewModel.getData()
      
    }
    
    func didSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.mapView.setRegion(self.viewModel.getRegionCoordinates(), animated: true)
            self.mapView.addAnnotations(self.viewModel.addAnnotationstoMap())
            
        }
    }
    
    func didFail() {
        debugPrint("Operation Failed!!")
    }
 
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        }
        else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "carIcon")
        
        return annotationView
    }
    
}


