//
//  MockAPIsViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

class TargetMocksViewModel {
    
    var items: [MockTargetEndpoint] {
        return target.apis
    }
    
    private let target: ServiceMockApis
    
    init(target: ServiceMockApis) {
        self.target = target
    }
    
    var title: String {
        //return String(describing: target)
        target.title
    }
    
    func reset(item: MockTargetEndpoint) {
        item.reset()
    }
    
    func toggleMock(item: MockTargetEndpoint, isOn: Bool) {
        let mock = item.mock()
        mock.isEnabled = isOn
        item.save(item: mock)
    }
}
