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
    
    var attributedJson: NSAttributedString {
        let prettyPrinted = mockItem.fileName.dataFromJsonFile.prettyPrintedJSONString as String?
        let json = prettyPrinted ?? ""
        return json.makeJsonAttributed()
    }
}
