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

extension BarAPI: EndpointMock {
    
    var description: String {
        switch self {
        case .someGet:
            return "This API get some data this text is so bigger writing anything here bye bye"
        case .somePost:
            return "This API create something"
        case .somePut:
            return "This API update something"
        case .someDelete:
            return "This API delete someting"
        }
    }
    
    
    static var apis: [EndpointMock] {
        return [
            BarAPI.someGet,
            BarAPI.somePost,
            BarAPI.somePut,
            BarAPI.someDelete
        ]
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
            return "/v1/some/long/path/url/api/extends/bigger/path/api/gigante"
        case .somePost:
            return "/v1/create"
        case .somePut:
            return "/v1/update/{id}"
        case .someDelete:
            return "/v1/delete/{id}"
        }
    }
    
    var mocks: [ResponseMock] {
        switch self {
        case .someGet:
            return [
                .init(description: "Success message response",
                      fileName: "BarAPI_somePost_Post_success",
                      statusCode: 200),
            ]
        case .somePost:
            return [
                .init(description: "Success message response",
                      fileName: "BarAPI_somePost_Post_success",
                      statusCode: 200),
                .init(description: "Error message response",
                      fileName: "BarAPI_somePost_Post_error",
                      statusCode: 200)
            ]
        case .somePut:
            return []
        case .someDelete:
            return []
        }
    }
}
