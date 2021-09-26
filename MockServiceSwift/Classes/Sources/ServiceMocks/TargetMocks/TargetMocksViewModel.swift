//
//  MockAPIsViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

class TargetMocksViewModel {
    
    private(set) lazy var items = target.apis
    
    internal let target: ServiceMockApis
    
    init(target: ServiceMockApis) {
        self.target = target
    }
    
    func toggle(item: MockAPI, isOn: Bool) {
        item.isEnabled = isOn
        MockServices.shared.didChangeMock?(item)
    }
}
