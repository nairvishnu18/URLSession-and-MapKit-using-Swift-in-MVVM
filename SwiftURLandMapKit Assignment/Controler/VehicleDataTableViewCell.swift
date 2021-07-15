//
//  CarDeatilsTableViewCell.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 08/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import UIKit

class VehicleDataTableViewCell: UITableViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var licensePlate: UILabel!
    @IBOutlet weak var makeName: UILabel!
    @IBOutlet weak var modelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Appends Model data to table view content cell .
    ///
    /// - Parameter modelData: Model Data
    func loadDataToTableCell(modelData: VehicleDataModel) {
        self.carImage.load(ImageURL: modelData.carImageURL)
        self.licensePlate.text = modelData.licensePlate
        self.makeName.text = modelData.vehicleDetails.make.rawValue
        self.modelName.text = modelData.modelName
    }

    
}
