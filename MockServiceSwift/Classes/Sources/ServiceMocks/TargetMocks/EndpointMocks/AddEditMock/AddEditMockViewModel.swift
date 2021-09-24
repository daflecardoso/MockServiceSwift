//
//  AddEditMockViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

class AddEditMockViewModel {
    
    private let endpoint: MockTargetEndpoint
    internal let mockItem: MockType?
    
    var saved: (() -> Void)?
    
    init(endpoint: MockTargetEndpoint, mock: MockType?) {
        self.endpoint = endpoint
        self.mockItem = mock
    }
    
    var title: String {
        if let mockItem = self.mockItem {
            return mockItem.name
        }
        return "Novo mock"
    }
    
    func request(request: MockType) {
        let mock = endpoint.mock()
        
        var items = mock.items
        if let mockItem = self.mockItem {
            guard let index = items.firstIndex(where: { $0.id == mockItem.id }) else {
                return
            }
            request.isEnabled = mockItem.isEnabled
            items[index] = request
        } else {
            items.insert(request, at: 0)
        }
        mock.items = items
        endpoint.save(item: mock)
        saved?()
    }
}
