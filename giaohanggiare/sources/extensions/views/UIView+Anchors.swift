//
//  UIView+Anchors.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 12/7/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

extension UIView {
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
                       topConstant: CGFloat = 0.0, leftConstant: CGFloat = 0.0, rightConstant: CGFloat = 0.0, bottomConstant: CGFloat = 0.0,
                       widthConstant: CGFloat = 0.0, heightConstant: CGFloat = 0.0)  {
        translatesAutoresizingMaskIntoConstraints = false
        _ = anchorWithReturnAnchors(top, left: left, right: right, bottom: bottom, topConstant: topConstant, leftConstant: leftConstant, rightConstant: rightConstant, bottomConstant:bottomConstant,  widthConstant: widthConstant, heightConstant:heightConstant)
        
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
                                        topConstant: CGFloat = 0.0, leftConstant: CGFloat = 0.0, rightConstant: CGFloat = 0.0, bottomConstant: CGFloat = 0.0,
                                        widthConstant: CGFloat = 0.0, heightConstant: CGFloat = 0.0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: rightConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
        
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
}
