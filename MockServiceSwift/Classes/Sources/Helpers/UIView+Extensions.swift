//
//  UIView+Extensions.swift
//  MockServiceSwift
//
//  Created by Dafle on 29/09/21.
//

import Foundation
import UIKit

extension UIView {
    
    func removeLayer(layerName: String) {
        for item in self.layer.sublayers ?? [] where item.name == layerName {
            item.removeFromSuperlayer()
        }
    }
    
    func setupShadowBorder(borderColor: UIColor = UIColor.white,
                           shadowColor: UIColor = .gray, radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor.cgColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.4
    }
    
    func removeShadow() {
        self.layer.cornerRadius = 0
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
    }
    
    func setupShadowNoCorner() {
        self.setupShadowBorder(borderColor: .clear)
        self.layer.cornerRadius = 0
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(cornersMask: CACornerMask, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = cornersMask
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    enum AnimationKeyPath: String {
        case opacity
    }
    
    func flash(animation: AnimationKeyPath, withDuration duration: TimeInterval = 0.5, repeatCount: Float = 5) {
        let flash = CABasicAnimation(keyPath: animation.rawValue)
        flash.duration = duration
        flash.fromValue = 1 // alpha
        flash.toValue = 0 // alpha
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = repeatCount
        
        layer.add(flash, forKey: nil)
    }
}
