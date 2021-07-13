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
        debugPrint(CustomErrors.didFail.rawValue)
    }
 
}





