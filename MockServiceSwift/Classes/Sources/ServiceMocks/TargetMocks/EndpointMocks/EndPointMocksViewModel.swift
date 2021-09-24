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
    
    private(set) var items: [MockType] = []
    
    internal let endpoint: MockTargetEndpoint
    
    init(endpoint: MockTargetEndpoint) {
        self.endpoint = endpoint
    }
    
    func fetch() {
        self.items = endpoint.mock().items
        reload?()
    }
    
    func delete(item: MockType) {
        let mock = endpoint.mock()
        guard let index = mock.items.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        items.remove(at: index)
        mock.items = items
        endpoint.save(item: mock)
        fetch()
    }
    
    func didTapEndPoint(selectedItem: MockType) {
        let mock = endpoint.mock()
        items.forEach { i in
            i.isEnabled = i.id == selectedItem.id
        }
        mock.items = items
        endpoint.save(item: mock)
        fetch()
    }
}
