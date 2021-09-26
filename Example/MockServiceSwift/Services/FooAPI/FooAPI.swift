//
//  FooAPI.swift
//  MockServiceSwift
//
//  Created by Dafle on 24/09/21.
//

import Foundation
import MockServiceSwift

enum FooAPI {
    case someGet, somePost, somePut, someDelete
    
    var key: String {
        let pieces = String(reflecting: self).split(separator: ".")
        let contextName = pieces[1]
        let endPointEnumName = pieces[2]
        let enumName = endPointEnumName.split(separator: "(").first ?? ""
        return "\(contextName).\(enumName).\(method)"
    }
    
    static var apis: [MockAPI] {
        return [
            FooAPI.someGet.mock,
            FooAPI.somePost.mock,
            FooAPI.somePut.mock,
            FooAPI.someDelete.mock
        ]
    }
    
    var description: String {
        switch self {
        case .someGet:
            return "This API get some data"
        case .somePost:
            return "This API create something"
        case .somePut:
            return "This API update something"
        case .someDelete:
            return "This API delete someting"
        }
    }
    
    var method: String {
        switch self {
        case .someGet:
            return "GET"
        case .somePost:
            return "POST"
        case .somePut:
            return "PUT"
        case .someDelete:
            return "DELETE"
        }
    }
    
    var path: String {
        switch self {
        case .someGet:
            return "/v1/some"
        case .somePost:
            return "/v1/create"
        case .somePut:
            return "/v1/update/{some}"
        case .someDelete:
            return "/v1/delete/{some}"
        }
    }
    
    var mock: MockAPI {
        switch self {
        case .someGet:
            return MockAPI(key: key,
                           method: method,
                           path: path,
                           description: description,
                           isEnabled: true,
                           items: [
                            .init(isSelected: true,
                                  name: "Success",
                                  description: "Success response two itens",
                                  fileName: "some_json_file_data_success_response"),
                            .init(isSelected: false,
                                  name: "Error",
                                  description: "Success response two itens",
                                  fileName: "some_json_file_data_success_response_none"),
                            .init(isSelected: false,
                                  name: "Error2",
                                  description: "Success response two itens",
                                  fileName: "some_json_file_data_success_response_none2"),
                            .init(isSelected: false,
                                  name: "Error3",
                                  description: "Success response two itens",
                                  fileName: "some_json_file_data_success_response_none3")
                           ])
        case .somePost:
            return MockAPI(key: key,
                           method: method,
                           path: path,
                           description: description,
                           isEnabled: false,
                           items: [])
        case .somePut:
            return MockAPI(key: key,
                           method: method,
                           path: path,
                           description: description,
                           isEnabled: false,
                           items: [])
        case .someDelete:
            return MockAPI(key: key,
                           method: method,
                           path: path,
                           description: description,
                           isEnabled: false,
                           items: [])
        }
    }
}
