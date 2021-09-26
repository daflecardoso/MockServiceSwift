//
//  BarAPI.swift
//  MockServiceSwift
//
//  Created by Dafle on 24/09/21.
//

import Foundation
import MockServiceSwift

//enum BarAPI {
//    case someGet, somePost, somePut, someDelete
//}
//
//extension BarAPI: MockTargetEndpoint {
//    
//    var description: String {
//        switch self {
//        case .someGet:
//            return "This API get some data this text is so bigger writing anything here bye bye"
//        case .somePost:
//            return "This API create something"
//        case .somePut:
//            return "This API update something"
//        case .someDelete:
//            return "This API delete someting"
//        }
//    }
//    
//    
//    static var cases: [MockTargetEndpoint] {
//        return [
//            BarAPI.someGet,
//            BarAPI.somePost,
//            BarAPI.somePut,
//            BarAPI.someDelete
//        ]
//    }
//    
//      
//    var requestMethod: String {
//        switch self {
//        case .someGet:
//            return "GET"
//        case .somePost:
//            return "POST"
//        case .somePut:
//            return "PUT"
//        case .someDelete:
//            return "DELETE"
//        }
//    }
//    
//    var endpointPath: String {
//        switch self {
//        case .someGet:
//            return "/v1/some/long/path/url/api/extends/bigger/path/api/gigante"
//        case .somePost:
//            return "/v1/create"
//        case .somePut:
//            return "/v1/update/{id}"
//        case .someDelete:
//            return "/v1/delete/{id}"
//        }
//    }
//    
//    var mock: MockAPI {
//        switch self {
//        case .someGet:
//            return MockAPI(isEnabled: false, items: [])
//        case .somePost:
//            return MockAPI(isEnabled: false, items: [
//                .init(isSelected: true,
//                      name: "Success",
//                      description: "Success message response",
//                      fileName: "BarAPI_somePost_Post_success"),
//                .init(isSelected: false,
//                      name: "Error",
//                      description: "Error message response",
//                      fileName: "BarAPI_somePost_Post_error")
//            ])
//        case .somePut:
//            return MockAPI(isEnabled: false, items: [])
//        case .someDelete:
//            return MockAPI(isEnabled: false, items: [])
//        }
//    }
//}
