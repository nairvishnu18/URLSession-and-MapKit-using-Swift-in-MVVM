//
//  ImageViewExtension.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 13/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation
import UIKit


class LoadImageView: UIImageView {
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    /// Displays Image on UI from given URL.
    ///
    /// - Parameter ImageURL: URL of Image to be displayed.
    public func loadImage(fromURL ImageURL: String) {
        self.image = Constants.defaultImage
        
        if let cachedImage = self.imageCache.object(forKey: ImageURL as NSString) {
            debugPrint("Image loaded from Cache.")
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: ImageURL) else {
            return
        }
        
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                debugPrint("Image Downloaded from Server.")
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageCache.setObject(image, forKey: ImageURL as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}


//extension UIImageView {
//    /// Displays Image on UI from given URL.
//    ///
//    /// - Parameter ImageURL: URL of Image to be displayed.
//    public func load(ImageURL: String) {
//        guard let url = URL(string: ImageURL) else {
//            return
//        }
//
//        DispatchQueue.main.async {
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self.image = image
//                    }
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.image = Constants.defaultImage
//                }
//
//            }
//        }
//    }
//
//}
