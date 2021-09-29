//
//  MocksViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

public class ServicesMocksViewModel {
    
    public var services: [ServiceMockApis]
    public var apis: [EndpointMock] = []
    
    public init(items: [ServiceMockApis]) {
        self.services = items
    }
    
    func select(service: ServiceMockApis) {
        self.apis = service.apis
    }
    
    func toggle(item: EndpointMock, isOn: Bool) {
        var itemCopy = item
        itemCopy.isEnabled = isOn
    }
    
    func didTapMock(selectedItem: ResponseMock, endpoint: EndpointMock) {
        MockServices.shared.defaults.set(selectedItem.fileName, forKey: key(endpoint: endpoint))
    }
    
    func isSelected(item: ResponseMock, endpoint: EndpointMock) -> Bool {
        let storedFileName = MockServices.shared.defaults.string(forKey: key(endpoint: endpoint))
        return item.fileName == storedFileName
    }
    
    func key(endpoint: EndpointMock) -> String {
        "\(endpoint.key).file"
    }
    
}
