//
//  MyNetwork.swift
//  MockServiceSwift_Example
//
//  Created by Dafle on 27/09/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import MockServiceSwift

class MyNetwork {
    
    func foo(success: @escaping  (String) -> Void, failure: @escaping (Error) -> Void) {
        
        let api = FooAPI.someGet
        
        if api.isEnabled {
            print("from mock...")
            success(api.json)
            return
        }
        
        print("from network...")
        let request = URLRequest(url: URL(string: api.baseUrl + api.mockPath)!)
        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    failure(error)
                } else {
                    let dataResponse = data ?? Data()
                    let json = String(data: dataResponse, encoding: .utf8) ?? ""
                    success(json)
                }
            }
        }.resume()
    }
}
