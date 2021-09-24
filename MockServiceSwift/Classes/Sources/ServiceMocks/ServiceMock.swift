//
//  MockAPIModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

public struct ServiceMockApis {
    let title: String
    let color: UIColor
    let icon: UIImage?
    let apis: [MockTargetEndpoint]
    
    public init(title: String, color: UIColor, icon: UIImage?, apis: [MockTargetEndpoint]) {
        self.title = title
        self.color = color
        self.icon = icon
        self.apis = apis
    }
}

public protocol MockTargetEndpoint {
    
    static var cases: [MockTargetEndpoint] { get }
    
    var description: String { get }
    
    var defaultMocks: [MockType] { get }
    
    var requestMethod: String { get }
    
    var endpointPath: String { get }
}

public class MockAPI: Codable {
    var isEnabled: Bool
    var items: [MockType]
    
    internal init(isEnabled: Bool, items: [MockType]) {
        self.isEnabled = isEnabled
        self.items = items
    }
}

public class MockType: Codable {
    
    public init(id: String, isEnabled: Bool, name: String, description: String, data: Data) {
        self.id = id
        self.isEnabled = isEnabled
        self.name = name
        self.description = description
        self.data = data
    }
    
    let id: String
    var isEnabled: Bool
    let name: String
    let description: String
    let data: Data
    
    var isValid: Bool {
        return !name.isEmpty
    }
}

public extension MockTargetEndpoint {
    
    var key: String {
        let pieces = String(reflecting: self).split(separator: ".")
        let contextName = pieces[1]
        let endPointEnumName = pieces[2]
        let enumName = endPointEnumName.split(separator: "(").first ?? ""
        let method = self.requestMethod
        return "\(contextName).\(enumName).\(method)"
    }
    
    var mockIsOn: Bool {
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
            if let item = try? JSONDecoder().decode(MockAPI.self, from: savedData) {
                return item.isEnabled
            }
        }
        return false
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: key)
        save(item: mock())
    }
    
    func mock() -> MockAPI {
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
            if let item = try? JSONDecoder().decode(MockAPI.self, from: savedData) {
                return item
            }
        }
        return MockAPI(isEnabled: false, items: defaultMocks)
    }
    
    func save(item: MockAPI) {
        if let encoded = try? JSONEncoder().encode(item) {
            UserDefaults.standard.set(encoded, forKey: key)
            print("mock is \(item.isEnabled) for key: \(key)")
        }
    }
    
    var pathFormated: String {
        return endpointPath.replacingOccurrences(of: "-1", with: "{some}")
    }
    
    var currentAPIMock: MockAPI? {
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
            if let item = try? JSONDecoder().decode(MockAPI.self, from: savedData) {
                return item
            }
        }
        return nil
    }
    
    var currentSavedMock: Data {
        if let mockItem = currentAPIMock?.items.first(where: { $0.isEnabled }) {
            return mockItem.data
        }
        return Data()
    }
}
