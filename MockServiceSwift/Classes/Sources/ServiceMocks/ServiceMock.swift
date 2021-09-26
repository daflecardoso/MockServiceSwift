//
//  MockAPIModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

public class MockServices {
    
    public static let shared = MockServices()
    
    public struct Style {
        public let tintColor: UIColor
        
        public init(tintColor: UIColor) {
            self.tintColor = tintColor
        }
    }
    
    var style: Style = Style(
        tintColor: .systemBlue
    )
    
    private var services: [ServiceMockApis] = []
    
    private let rootKeyUserDefaults = "MockServiceSwift"
    
    public var didChangeMock: ((MockAPI) -> Void)?
    
    init() { }
    
    public func setStyle(_ style: Style) -> Self {
        self.style = style
        return self
    }
    
    public func services(_ services: [ServiceMockApis]) -> Self {
        self.services = services
        saveServices(services: services)
        showStructure()
        return self
    }
    
    func saveServices(services: [ServiceMockApis]) {
       
    }
    
    public func showStructure() {
        
        services.enumerated().forEach { index, services in
            print(index + 1, "-", services.title)
            
            services.apis.forEach { api in
                print("    -", api.key)
                
                api.items.forEach { mock in
                    print("      *", mock.fileName, mock.isSelected)
                }
                print("\n")
            }
            print("\n\n")
        }
    }
    
    public func makeMocksViewController() -> ServicesMocksViewController {
        let viewModel = ServicesMocksViewModel(items: services)
        return ServicesMocksViewController(viewModel: viewModel)
    }
}

public class ServiceMockApis {
    let title: String
    let color: UIColor
    let icon: UIImage?
    let apis: [MockAPI]
    
    public init(title: String, color: UIColor, icon: UIImage?, apis: [MockAPI]) {
        self.title = title
        self.color = color
        self.icon = icon
        self.apis = apis
    }
}

public class MockAPI: Codable {
    public init(key: String,
                method: String,
                path: String,
                description: String,
                isEnabled: Bool,
                items: [MockType]) {
        self.key = key
        self.method = method
        self.path = path
        self.description = description
        self.isEnabled = isEnabled
        self.items = items
    }
    
    public let key: String
    public let method: String
    public let path: String
    public let description: String
    public var isEnabled: Bool
    public var items: [MockType]
    
    var containerColor: UIColor {
        isEnabled
           ? MockServices.shared.style.tintColor.withAlphaComponent(0.3)
           : UIColor.headerNavigationTint
    }
    
    var countMocks: String {
        "\(items.count) mocks"
    }
}

public class MockType: Codable {
    
    public init(isSelected: Bool,
                name: String,
                description: String,
                fileName: String) {
        self.isSelected = isSelected
        self.name = name
        self.description = description
        self.fileName = fileName
    }
    
    public var isSelected: Bool
    public let name: String
    public let description: String
    public let fileName: String
    
    var isValid: Bool {
        return !name.isEmpty
    }
}
