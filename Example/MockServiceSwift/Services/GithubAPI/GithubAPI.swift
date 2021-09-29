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
    case userProfile(String), other, otherToo
}

extension GitHub: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .userProfile:
            return "/user"
        case .other:
            return "/user/other/other"
        case .otherToo:
            return "/user/other/other/too"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userProfile:
            return .get
        case .other:
            return .get
        case .otherToo:
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
        case .other:
            return .requestPlain
        case .otherToo:
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
            GitHub.userProfile(""),
            GitHub.other,
            GitHub.otherToo
        ]
    }
    
    var description: String {
        switch self {
        case .userProfile:
            return "Get user profile"
        case .other:
            return "Do something"
        case .otherToo:
            return "Do anything"
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
                .init(description: "Get user profile success",
                      fileName: "some_json_file",
                      statusCode: 200),
                .init(description: "Error 400",
                      fileName: "some_json_file0",
                      statusCode: 400),
                .init(description: "Other error",
                      fileName: "some_json_file1",
                      statusCode: 401),
                .init(description: "Another error",
                      fileName: "some_json_file3",
                      statusCode: 403)
            ]
        case .other:
            return [
                .init(description: "Get user profile success",
                      fileName: "some_json_filesss",
                      statusCode: 200),
                .init(description: "Error 400",
                      fileName: "some_json_fileee0d",
                      statusCode: 400),
                .init(description: "Get user profile success",
                      fileName: "some_json_fileeesss",
                      statusCode: 300),
                .init(description: "Error 400",
                      fileName: "some_json_file0eed",
                      statusCode: 500),
            ]
        case .otherToo:
            return [
                .init(description: "Get user profile success",
                      fileName: "some_json_files",
                      statusCode: 200),
                .init(description: "Error 400",
                      fileName: "some_json_file0s",
                      statusCode: 400),
                .init(description: "Error test",
                      fileName: "some_json_fidddle0s",
                      statusCode: 100),
            ]
        }
    }
}
