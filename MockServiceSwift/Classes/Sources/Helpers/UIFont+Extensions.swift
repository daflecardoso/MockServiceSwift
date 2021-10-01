//
//  UIFont+Extensions.swift
//  _idx_uNetworkAnalyzer_ABAE1E99_ios_min11.0
//
//  Created by Dafle on 24/09/21.
//

import Foundation
import UIKit

extension UIFont {
    
    class func fontBy(name: String, size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func regularMenlo(_ size: CGFloat) -> UIFont {
        return self.fontBy(name: "Menlo-Regular", size: size)
    }
    
    class func regular(_ size: CGFloat) -> UIFont {
        //return self.fontBy(name: "SFProRounded-Regular", size: size)
        return .systemFont(ofSize: size, weight: .regular)
    }
    
    class func medium(_ size: CGFloat) -> UIFont {
        //return self.fontBy(name: "SFProRounded-Medium", size: size)
        return .systemFont(ofSize: size, weight: .medium)
    }
    
    class func bold(_ size: CGFloat) -> UIFont {
        //return self.fontBy(name: "SFProRounded-Bold", size: size)
        return .systemFont(ofSize: size, weight: .bold)
    }
    
    class func light(_ size: CGFloat) -> UIFont {
        //return self.fontBy(name: "SFProRounded-Light", size: size)
        return .systemFont(ofSize: size, weight: .light)
    }

    class func thin(_ size: CGFloat) -> UIFont {
        //return self.fontBy(name: "SFProRounded-Thin", size: size)
        return .systemFont(ofSize: size, weight: .ultraLight)
    }
}
