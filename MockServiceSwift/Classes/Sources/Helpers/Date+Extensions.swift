//
//  Date+Extensions.swift
//  _idx_uNetworkAnalyzer_ABAE1E99_ios_min11.0
//
//  Created by Dafle on 24/09/21.
//

import Foundation

extension Date {
    
    var yyyyMMddHHmmssii: String {
        return DateFormatter().run { df -> String in
            df.dateFormat = "yyyyMMddHHmmssii"
            return df.string(from: self)
        }
    }
}
