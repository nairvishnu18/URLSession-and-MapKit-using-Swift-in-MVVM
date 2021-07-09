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
    @IBOutlet weak var mapKitView: MKMapView!
    var viewModel: ViewModelOpeartions!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModelController(_client: ApiHanlder(), _requestStatus: self)
        viewModel.getData()
    }
    
    func didSuccess() {
        tableView.reloadData()
    }
    
    func didFail() {
        debugPrint("Failed Opeartion!!")
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataModel!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! CarDeatilsTableViewCell
        tableCell.seriesType.text = viewModel.dataModel![indexPath.row].vehicleDetails.series.rawValue
        tableCell.makeName.text = viewModel.dataModel![indexPath.row].vehicleDetails.make.rawValue
        tableCell.carName.text = viewModel.dataModel![indexPath.row].vehicleDetails.name
        
        
        return tableCell
    }
    
    
}


