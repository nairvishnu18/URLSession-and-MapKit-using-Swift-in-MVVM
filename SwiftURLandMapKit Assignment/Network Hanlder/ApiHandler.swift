//
//  ApiHandler.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 09/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation

struct ApiHandler {
    
    /// A generic API Hanlder to parse the request URL and Decode it to given type.
    ///
    /// - Parameters:
    ///   - requestUrl: URL which need to be parsed and decoded.
    ///   - resultType: Type of the Model which holds the response data.
    ///   - completionHandler: @escaping to hold and return the data after function block.
    func getAPIData<T: Decodable>(from requestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T?, Error?) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (data, URLResponse, error) in
            guard let responseData = data else {
                debugPrint(CustomErrors.noDataFound.rawValue)
                if let error = error {
                    completionHandler(nil,error)
                    debugPrint(error.localizedDescription)
                }
                return
            }
            // Parse ResponseData
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: responseData)
                completionHandler(result, nil)
            }
            catch let error {
                debugPrint("\(error.localizedDescription)")
            }
            }.resume()
        
    }
}
