//
//  Data+Extensions.swift
//  _idx_uNetworkAnalyzer_ABAE1E99_ios_min11.0
//
//  Created by Dafle on 24/09/21.
//

import Foundation

extension Data {
    
    var isValidJson: Bool {
        do {
            _ = try JSONSerialization.jsonObject(with: self, options: [])
            return true
        } catch {
            return false
        }
    }
    
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString
                = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

