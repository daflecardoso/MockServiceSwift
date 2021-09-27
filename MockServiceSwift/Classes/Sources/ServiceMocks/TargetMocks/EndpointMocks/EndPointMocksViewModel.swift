//
//  EndPointMocksViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

class EndPointMocksViewModel {
    
    var reload: (() -> Void)?
    
    private(set) lazy var items: [ResponseMock] = mock.mocks
    
    internal let mock: EndpointMock
    
    var key: String {
        "\(mock.key).file"
    }
    
    init(endpoint: EndpointMock) {
        self.mock = endpoint
    }
    
    func didTapEndPoint(selectedItem: ResponseMock) {
        MockServices.shared.defaults.set(selectedItem.fileName, forKey: key)
        reload?()
    }
    
    func isSelected(item: ResponseMock) -> Bool {
        let storedFileName = MockServices.shared.defaults.string(forKey: key)
        return item.fileName == storedFileName
    }
}
