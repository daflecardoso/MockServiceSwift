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
}

extension FooAPI: MockTargetEndpoint {
    
    static var cases: [MockTargetEndpoint] {
        return [
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
    
    var defaultMocks: [MockType] {
        switch self {
        case .someGet:
            return [
                .init(id: UUID().uuidString,
                      isEnabled: true,
                      name: "Sucesso",
                      description: "Cenário de sucesso com 2 itens",
                      data: "some_json_file_data_success_response".jsonData)
            ]
        case .somePost:
            return []
        case .somePut:
            return []
        case .someDelete:
            return []
        }
    }
    
    var requestMethod: String {
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
    
    var endpointPath: String {
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
}
