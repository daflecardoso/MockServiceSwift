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
    
    var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    public var didChangeMock: ((EndpointMock) -> Void)?
    
    init() { }
    
    public func reset(_ reset: Bool) -> Self {
        //clear all data
        return self
    }
    
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
        
        print("start 😀")
        for (key, value) in defaults.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        print("end 😀")
        
        services.enumerated().forEach { index, services in
            print(index + 1, "-", services.title)
            
            services.apis.forEach { api in
                print("    -", api.key)
                
                api.mocks.forEach { mock in
                    print("      *", mock.fileName)
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
    var method: String { get }
    var path: String { get }
    var mocks: [ResponseMock] { get }
    var key: String { get }
}

extension EndpointMock {
    
    public var key: String {
        let pieces = String(reflecting: self).split(separator: ".")
        if pieces.count > 2 {
            let contextName = pieces[1]
            let endPointEnumName = pieces[2]
            let enumName = endPointEnumName.split(separator: "(").first ?? ""
            return "\(contextName).\(enumName).\(method)"
        }
        return ""
    }
    
    public var isEnabled: Bool {
        get { MockServices.shared.defaults.bool(forKey: "\(key).isEnabled") }
        set { MockServices.shared.defaults.set(newValue, forKey: "\(key).isEnabled") }
    }
    
    public var json: String {
        let storeFileKey = "\(key).file"
        let storedFileName = MockServices.shared.defaults.string(forKey: storeFileKey)
        let currentMock = mocks.first(where: { $0.fileName == storedFileName })
        let fileName = (currentMock?.fileName ?? "")
        let data = fileName.dataFromJsonFile
        return String(data: data, encoding: .utf8) ?? ""
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
