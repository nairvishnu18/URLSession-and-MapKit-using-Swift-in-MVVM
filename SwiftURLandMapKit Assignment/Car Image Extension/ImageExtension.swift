//
//  ImageExtension.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 08/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    public func load(urlstring: String) {
        guard let url = URL(string: urlstring) else {
            return
        }
        
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "defaultImage")
                }
                
            }
        }
    }
}
