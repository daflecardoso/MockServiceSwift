//
//  AddEditMockViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

class AddEditMockViewModel {
    
    private let endpoint: EndpointMock
    internal let mockItem: ResponseMock
    
    var saved: (() -> Void)?
    
    init(endpoint: EndpointMock, mock: ResponseMock) {
        self.endpoint = endpoint
        self.mockItem = mock
    }
    
    lazy var json = mockItem.fileName.dataFromJsonFile.prettyPrintedJSONString ?? ""
    
    var lines: String {
        var text = ""
        json.components(separatedBy: "\n").enumerated().forEach { index, _ in
            text.append("\(index + 1)\n")
        }
        return text
    }
}
