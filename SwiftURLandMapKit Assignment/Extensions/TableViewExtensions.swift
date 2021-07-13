//
//  TableViewExtensions.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 13/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation
import UIKit

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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")
        headerCell?.textLabel?.text = "Available Cars"
        return headerCell
    }
    
    
}
