//
//  BarAPI.swift
//  MockServiceSwift
//
//  Created by Dafle on 24/09/21.
//

import Foundation
import MockServiceSwift

enum BarAPI {
    case someGet, somePost, somePut, someDelete
}

extension BarAPI: MockTargetEndpoint {
    
    static var cases: [MockTargetEndpoint] {
        return [
            BarAPI.someGet,
            BarAPI.somePost,
            BarAPI.somePut,
            BarAPI.someDelete
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
            return []
        case .somePost:
            return [
                .init(id: UUID().uuidString,
                      isEnabled: true,
                      name: "Success",
                      description: "Success message response",
                      data: "BarAPI_somePost_Post_success".jsonData),
                .init(id: UUID().uuidString,
                      isEnabled: false,
                      name: "Error",
                      description: "Error message response",
                      data: "BarAPI_somePost_Post_error".jsonData)
            ]
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
            return "/v1/update/{id}"
        case .someDelete:
            return "/v1/delete/{id}"
        }
    }
}
