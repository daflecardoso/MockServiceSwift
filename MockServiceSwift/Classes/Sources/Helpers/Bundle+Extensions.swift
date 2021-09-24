//
//  Bundle+Extensions.swift
//  MockServiceSwift
//
//  Created by Dafle on 24/09/21.
//

import Foundation

extension Bundle {
    
    func dataFromJsonFile(name: String) -> Data {
        guard let path = self.path(forResource: name, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return Data()
        }
        return data
    }
}
