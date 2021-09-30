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
    
    static let bundle: Bundle = {
        let bundleName = "Resources"
        let bundle = Bundle(for: MockServices.self)
        
        guard let resourceBundleURL = bundle.url(forResource: bundleName, withExtension: "bundle") else { return Bundle.main
        }
        
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            return Bundle.main
        }
        
        return resourceBundle
    }()
    
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
    let icon: UIImage?
    let apis: [EndpointMock]
    
    public init(title: String, icon: UIImage?, apis: [EndpointMock]) {
        self.title = title
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
    
    var currentMock: ResponseMock? {
        let storeFileKey = "\(key).file"
        let storedFileName = MockServices.shared.defaults.string(forKey: storeFileKey)
        return mocks.first(where: { $0.fileName == storedFileName })
    }
    
    public var mockData: Data {
        let fileName = currentMock?.fileName ?? ""
        return fileName.dataFromJsonFile
    }
    
    public var mockStatusCode: Int {
        return currentMock?.statusCode ?? -1
    }
    
    public var json: String {
        return String(data: mockData, encoding: .utf8) ?? ""
    }
    
    var methodColor: UIColor {
        switch mockMethod {
        case "GET":
            return UIColor(red: 35/255, green: 168/255, blue: 84/255, alpha: 1.0)
        case "POST":
            return UIColor(red: 198/255, green: 142/255, blue: 45/255, alpha: 1.0)
        case "PUT":
            return UIColor(red: 8/255, green: 107/255, blue: 190/255, alpha: 1.0)
        case "DELETE":
            return UIColor(red: 208/255, green: 32/255, blue: 40/255, alpha: 1.0)
        default:
            return .black
        }
    }
}

public class ResponseMock: Codable {
    
    public init(description: String,
                fileName: String,
                statusCode: Int) {
        self.description = description
        self.fileName = fileName
        self.statusCode = statusCode
    }
    
    var statusCodeColor: UIColor {
        if (200...299).contains(statusCode) {
            return UIColor(red: 35/255, green: 168/255, blue: 84/255, alpha: 1.0)
        } else {
            return UIColor(red: 208/255, green: 32/255, blue: 40/255, alpha: 1.0)
        }
    }

    public let description: String
    public let fileName: String
    public let statusCode: Int
}
