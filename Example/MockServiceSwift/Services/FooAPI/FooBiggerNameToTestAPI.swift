//
//  FooAPI.swift
//  MockServiceSwift
//
//  Created by Dafle on 24/09/21.
//

import Foundation
import MockServiceSwift

enum FooBiggerNameToTestAPI {
    case someGet, somePost, somePut, someDelete
    
    var baseUrl: String {
        return "https://mocki.io"
    }
}

extension FooBiggerNameToTestAPI: EndpointMock {
    
    static var apis: [EndpointMock] {
        [
            FooBiggerNameToTestAPI.someGet,
            FooBiggerNameToTestAPI.somePost,
            FooBiggerNameToTestAPI.somePut,
            FooBiggerNameToTestAPI.someDelete
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
                .init(description: "Success response two itens e aqui vai um texto grande para ver como o layout vai se comportar",
                      fileName: "some_json_file_data_success_response",
                      statusCode: 200),
                .init(description: "Error 401",
                      fileName: "some_json_file_data_success_response_none",
                      statusCode: 401),
                .init(description: "Error 400",
                      fileName: "some_json_file_data_success_response_none2",
                      statusCode: 400),
                .init(description: "Error 500",
                      fileName: "some_json_file_data_success_response_none3",
                      statusCode: 500)
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
