//
//  ViewModel.swift
//  SwiftURLandMapKit Assignment
//
//  Created by Vishnu Balakrishnan Nair on 09/07/21.
//  Copyright © 2021 Vishnu Balakrishnan Nair. All rights reserved.
//

import Foundation

protocol ViewModelOpeartions {
    var dataModel: [CarDataModel]? {get}
    func getData()
}

protocol RequestStatus: class {
    func didSuccess()
    func didFail()
}

class ViewModelController: ViewModelOpeartions {
    
    var dataModel: [CarDataModel]?
    private let apiHandler : ApiHanlder
    weak var requestStatusDelegate: RequestStatus?
    
    init(_client: ApiHanlder, _requestStatus: RequestStatus) {
        apiHandler = _client
        requestStatusDelegate = _requestStatus
    }
    
    
    func getData() {
        let requestURL = "http://www.mocky.io/v2/5dc3f2c13000003c003477a0"
        apiHandler.getAPIData(from: URL(string: requestURL)!, resultType: [CarDataModel].self) { [weak self] (carData) in
            self?.dataModel = carData
            self?.requestStatusDelegate?.didSuccess()
        }
    }
    
}
