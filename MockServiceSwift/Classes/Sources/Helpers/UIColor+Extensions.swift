//
//  UIColor+Extensions.swift
//  _idx_uNetworkAnalyzer_ABAE1E99_ios_min11.0
//
//  Created by Dafle on 24/09/21.
//

import Foundation
import UIKit

extension UIColor {
    
    public static var backgroundContainerViews: UIColor = {
        let dark = UIColor(red: 17/255, green: 18/255, blue: 19/255, alpha: 1.0)
        
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return .white
                }
            }
        } else {
            return .white
        }
    }()
    
    public static var headerNavigationTint: UIColor = {
    
        let light = UIColor(red: 249/255, green: 250/255, blue: 251/255, alpha: 1.0)
        
        let dark = UIColor(red: 25/255, green: 26/255, blue: 27/255, alpha: 1.0)
        
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return light
                }
            }
        } else {
            return light
        }
    }()
    
    public static var arrowBackgroundColor: UIColor = {
    
        let light = UIColor(red: 249/255, green: 250/255, blue: 251/255, alpha: 1.0)
        
        let dark = UIColor(red: 33/255, green: 34/255, blue: 35/255, alpha: 1.0)
        
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return light
                }
            }
        } else {
            return light
        }
    }()
    
    public static var cardColor: UIColor = {
    
        let light: UIColor = .white
        
        let dark = UIColor(red: 25/255, green: 26/255, blue: 27/255, alpha: 1.0)
        
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return light
                }
            }
        } else {
            return light
        }
    }()
    
    public static var whiteBlackNavigationTint: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return .white
                } else {
                    /// Return the color for Light Mode
                    return .black
                }
            }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return .black
        }
    }()
    
    static let warmGrey: UIColor = .lightGray
}
