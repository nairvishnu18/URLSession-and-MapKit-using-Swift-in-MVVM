//
//  ApiHandler.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 09/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation

struct ApiHandler {
    
    func getAPIData<T: Decodable>(from requestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (data, URLResponse, error) in
            guard let responseData = data else {
                debugPrint("Data Error")
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                return
            }
            // Parse ResponseData
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: responseData)
//                debugPrint(result)
                completionHandler(result)
            }
            catch let error {
                    debugPrint("Error Occured while Parsing: \(error.localizedDescription)")
            }
        }.resume()
        
    }
}
