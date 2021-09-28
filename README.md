# MockServiceSwift

[![CI Status](https://img.shields.io/travis/daflecardoso/MockServiceSwift.svg?style=flat)](https://travis-ci.org/daflecardoso/MockServiceSwift)
[![Version](https://img.shields.io/cocoapods/v/MockServiceSwift.svg?style=flat)](https://cocoapods.org/pods/MockServiceSwift)
[![License](https://img.shields.io/cocoapods/l/MockServiceSwift.svg?style=flat)](https://cocoapods.org/pods/MockServiceSwift)
[![Platform](https://img.shields.io/cocoapods/p/MockServiceSwift.svg?style=flat)](https://cocoapods.org/pods/MockServiceSwift)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

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

## Author

daflecardoso, daflesantos@gmail.com

## License

MockServiceSwift is available under the MIT license. See the LICENSE file for more info.
