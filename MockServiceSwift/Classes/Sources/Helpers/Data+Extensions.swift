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
    
    var prettyPrintedJSONString: String? {
        let options: JSONSerialization.WritingOptions
        if #available(iOS 13.0, *) {
            options = [.prettyPrinted, .withoutEscapingSlashes]
        } else {
            options = [.prettyPrinted]
        }
        
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []) else {
            return nil
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: options) else {
            return nil
        }
        
        guard let prettyPrintedString = String(data: data, encoding: .utf8) else {
            return nil
        }

        return prettyPrintedString
    }
}

