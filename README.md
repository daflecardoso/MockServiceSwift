# MockServiceSwift 0.5.0

[![CI Status](https://img.shields.io/travis/daflecardoso/MockServiceSwift.svg?style=flat)](https://travis-ci.org/daflecardoso/MockServiceSwift)
[![Version](https://img.shields.io/cocoapods/v/MockServiceSwift.svg?style=flat)](https://cocoapods.org/pods/MockServiceSwift)
[![License](https://img.shields.io/cocoapods/l/MockServiceSwift.svg?style=flat)](https://cocoapods.org/pods/MockServiceSwift)
[![Platform](https://img.shields.io/cocoapods/p/MockServiceSwift.svg?style=flat)](https://cocoapods.org/pods/MockServiceSwift)

Mock your apis without leaving your app. This simple library allows you to activate or change mocks api with ease, without having to mess with code, to facilitate your development and testing

## Example

<img src="../master/example.gif" alt="My cool logo" width="200px"/>

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
No requirements

## Installation

MockServiceSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MockServiceSwift'
```

## Usage

Implement ```MockTargetEndpoint``` in your api file

```swift
import MockServiceSwift

enum FooAPI {
    case someGet, somePost, somePut, someDelete
}

extension FooAPI: EndpointMock {
    
    static var apis: [EndpointMock] {
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
    
    var mocks: [ResponseMock] {
        switch self {
        case .someGet:
            return [
                .init(name: "Success",
                      description: "Success response two itens",
                      fileName: "some_json_file_data_success_response")
            ]
        case .somePost:
            return []
        case .somePut:
            return []
        case .someDelete:
            return []
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
```

Then prensent mocks controller

```swift
func showMocksArea() {
    let apis = [
        FooAPI.self
    ]

    let services = apis.map {
        ServiceMockApis(
            title: String(describing: $0),
            color: .systemBlue,
            icon: UIImage(named: "ic_bug")?.withRenderingMode(.alwaysTemplate),
            apis: $0.apis
        )
    }

    let viewController = MockServices.shared
        .setStyle(MockServices.Style(tintColor: .systemBlue))
        .services(services)
        .makeMocksViewController()

    let navigation = UINavigationController(rootViewController: viewController)
    present(navigation, animated: true, completion: nil)
}
```

```swift

//Helpers variables

public protocol EndPointMock {
    /**
        Stored key mock
     */
    var key: String { get }

    /**
        Mock is enabled
    */
    var isEnabled: Bool { get }

    /**
        Data from file
    */
    var mockData: Data { get }

    /**
        String json from file
    */
    var json: String { get }
}
```

## Using Moya Example
If you are using moya is pretty easier

```swift
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
```

## Create a service class, and Base Helper

```swift
import Moya
import MockServiceSwift

class BaseNetwork<Target: TargetType> {
    let provider = MoyaProvider<Target>()
    private let mockProvider = MoyaProvider<Target>(stubClosure: MoyaProvider.immediatelyStub(_:))
    
    internal func request(_ target: Target, completion: @escaping Moya.Completion) -> Cancellable {
        if let targetMock = target as? EndpointMock, targetMock.isEnabled {
            print("from mock...", targetMock.key)
            return mockProvider.request(target, completion: completion)
        }
        return provider.request(target, completion: completion)
    }
}

class MyMoyaExampleNetwork: BaseNetwork<GitHub> {
    
    func gitHubUserProfile(completion: @escaping Moya.Completion) -> Cancellable {
        return super.request(.userProfile("ashfurrow"), completion: completion)
    }
}


private func callAPI() {
        
    let service = MyMoyaExampleNetwork()

    service.gitHubUserProfile { event in
        switch event {
        case let .success(response):
            let data = response.data
            let statusCode = response.statusCode
            // do something with the response data or statusCode
        case let .failure(error):
            // this means there was a network failure - either the request
            // wasn't sent (connectivity), or no response was received (server
            // timed out).  If the server responds with a 4xx or 5xx error, that
            // will be sent as a ".success"-ful response.
        }
    }
}
```

## Author

daflecardoso, daflesantos@gmail.com

## License

MockServiceSwift is available under the MIT license. See the LICENSE file for more info.
