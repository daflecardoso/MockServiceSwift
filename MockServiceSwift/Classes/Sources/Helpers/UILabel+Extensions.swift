//
//  UILabel+Extensions.swift
//  _idx_uNetworkAnalyzer_ABAE1E99_ios_min11.0
//
//  Created by Dafle on 24/09/21.
//

import Foundation
import UIKit

extension UILabel {
    
    class func title(_ title: String) -> UILabel {
        return UILabel().apply { label in
            label.text = title
            label.font = .bold(18)
        }
    }
}
