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
    
    var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    init() { }

    public func setStyle(_ style: Style) -> Self {
        self.style = style
        return self
    }
    
    public func services(_ services: [ServiceMockApis]) -> Self {
        self.services = services
        return self
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
    let apis: [EndpointMock]
    
    public init(title: String, color: UIColor, icon: UIImage?, apis: [EndpointMock]) {
        self.title = title
        self.color = color
        self.icon = icon
        self.apis = apis
    }
}

public protocol EndpointMock: Codable {
    static var apis: [EndpointMock] { get }
    var description: String { get }
    var mockMethod: String { get }
    var mockPath: String { get }
    var mocks: [ResponseMock] { get }
    
    /**
        Stored key mock
     */
    var key: String { get }
}

extension EndpointMock {
    
    public var key: String {
        let pieces = String(reflecting: self).split(separator: ".")
        if pieces.count > 2 {
            let contextName = pieces[1]
            let endPointEnumName = pieces[2]
            let enumName = endPointEnumName.split(separator: "(").first ?? ""
            return "\(contextName).\(enumName).\(mockMethod)"
        }
        return ""
    }
    
    public var isEnabled: Bool {
        get { MockServices.shared.defaults.bool(forKey: "\(key).isEnabled") }
        set { MockServices.shared.defaults.set(newValue, forKey: "\(key).isEnabled") }
    }
    
    public var mockData: Data {
        let storeFileKey = "\(key).file"
        let storedFileName = MockServices.shared.defaults.string(forKey: storeFileKey)
        let currentMock = mocks.first(where: { $0.fileName == storedFileName })
        let fileName = (currentMock?.fileName ?? "")
        return fileName.dataFromJsonFile
    }
    
    public var json: String {
        return String(data: mockData, encoding: .utf8) ?? ""
    }
}

public class ResponseMock: Codable {
    
    public init(name: String,
                description: String,
                fileName: String) {
        self.name = name
        self.description = description
        self.fileName = fileName
    }
    
    public let name: String
    public let description: String
    public let fileName: String
    
    var isValid: Bool {
        return !name.isEmpty
    }
}
