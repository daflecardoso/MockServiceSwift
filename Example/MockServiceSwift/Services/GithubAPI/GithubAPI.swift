//
//  GithubAPI.swift
//  MockServiceSwift_Example
//
//  Created by Dafle on 28/09/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Moya
import MockServiceSwift

enum GitHub {
    case userProfile(String)
}

extension GitHub: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .userProfile:
            return "/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userProfile:
            return .get
        }
    }
    
    var sampleData: Data {
        return mockData
    }
    
    var task: Task {
        switch self {
        case .userProfile:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

extension GitHub: EndpointMock {
    
    static var apis: [EndpointMock] {
        return [
            GitHub.userProfile("")
        ]
    }
    
    var description: String {
        switch self {
        case .userProfile:
            return "Get user profile"
        }
    }
    
    var mockMethod: String {
        return method.rawValue
    }
    
    var mockPath: String {
        return path
    }
    
    var mocks: [ResponseMock] {
        switch self {
        case .userProfile:
            return [
                .init(
                    name: "Success",
                    description: "Get user profile success",
                    fileName: "some_json_file"
                )
            ]
        }
    }
}
