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
    
    var baseUrl: String {
        return "https://mocki.io"
    }
}

extension FooAPI: EndpointMock {
    
    static var apis: [EndpointMock] {
        [
            FooAPI.someGet,
            FooAPI.somePost,
            FooAPI.somePut,
            FooAPI.someDelete
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
    
    var mockMethod: String {
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
    
    var mockPath: String {
        switch self {
        case .someGet:
            return "/v1/d4867d8b-b5d5-4a48-a4ab-79131b5809b8"
        case .somePost:
            return "/v1/create"
        case .somePut:
            return "/v1/update/{some}"
        case .someDelete:
            return "/v1/delete/{some}"
        }
    }
    
    var mocks: [ResponseMock] {
        switch self {
        case .someGet:
            return [
                .init(name: "Success",
                      description: "Success response two itens",
                      fileName: "some_json_file_data_success_response"),
                .init(name: "Error",
                      description: "Success response two itens",
                      fileName: "some_json_file_data_success_response_none"),
                .init(name: "Error2",
                      description: "Success response two itens",
                      fileName: "some_json_file_data_success_response_none2"),
                .init(name: "Error3",
                      description: "Success response two itens",
                      fileName: "some_json_file_data_success_response_none3")
            ]
        case .somePost:
            return []
        case .somePut:
            return []
        case .someDelete:
            return []
        }
    }
}
