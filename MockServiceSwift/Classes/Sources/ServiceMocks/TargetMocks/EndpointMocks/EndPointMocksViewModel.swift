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
    
    private(set) lazy var items: [MockType] = mock.items
    
    internal let mock: MockAPI
    
    init(endpoint: MockAPI) {
        self.mock = endpoint
    }
    
    func didTapEndPoint(selectedItem: MockType) {
        items.forEach { i in
            i.isSelected = i.fileName == selectedItem.fileName
        }
        reload?()
        MockServices.shared.didChangeMock?(mock)
    }
}
