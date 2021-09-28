//
//  MyMoyaExampleNetwork.swift
//  MockServiceSwift_Example
//
//  Created by Dafle on 28/09/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
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
