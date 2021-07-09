//
//  ApiHandler.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 09/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation

struct ApiHanlder {
    
    func getAPIData<T: Decodable>(from requestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T) -> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { (responseData, HttpURLResponse, error) in
            if (error == nil && responseData?.count != 0) {
                
                // Parse ResponseData
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    completionHandler(result)
                }
                catch let error {
                    debugPrint("Error Occured while Parsing: \(error.localizedDescription)")
                }
            }
        }
        
    }
}
