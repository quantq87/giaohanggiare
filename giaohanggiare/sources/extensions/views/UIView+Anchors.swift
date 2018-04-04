//
//  UIView+Anchors.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 12/7/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

extension UIView {
    
    public func topIdentifier() -> String {
        return "topIdentifier"
    }
    
    public func bottomIdentifier() -> String {
        return "bottomIdentifier"
    }
    
    public func widthIdentifier() -> String {
        return "widthIdentifier"
    }
    
    public func heightIdentifier() -> String {
        return "heightIdentifier"
    }
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
                       topConstant: CGFloat = 0.0, leftConstant: CGFloat = 0.0, rightConstant: CGFloat = 0.0, bottomConstant: CGFloat = 0.0,
                       widthConstant: CGFloat = 0.0, heightConstant: CGFloat = 0.0)  {
        _ = anchorWithReturnAnchors(top, left: left, right: right, bottom: bottom, topConstant: topConstant, leftConstant: leftConstant, rightConstant: rightConstant, bottomConstant:bottomConstant,  widthConstant: widthConstant, heightConstant:heightConstant)
        
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
                                        topConstant: CGFloat = 0.0, leftConstant: CGFloat = 0.0, rightConstant: CGFloat = 0.0, bottomConstant: CGFloat = 0.0,
                                        widthConstant: CGFloat = 0.0, heightConstant: CGFloat = 0.0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            let topAnchor: NSLayoutConstraint = self.topAnchor.constraint(equalTo: top, constant: topConstant)
            topAnchor.identifier = self.topIdentifier()
            anchors.append(topAnchor)
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: rightConstant))
        }
        
        if let bottom = bottom {
            let bottomAnchor: NSLayoutConstraint = self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant)
            bottomAnchor.identifier = self.bottomIdentifier()
            anchors.append(bottomAnchor)
        }
        
        if widthConstant > 0 {
            let widthAnchor: NSLayoutConstraint = self.widthAnchor.constraint(equalToConstant: widthConstant)
            widthAnchor.identifier = self.widthIdentifier()
            anchors.append(widthAnchor)
        }
        
        if heightConstant > 0 {
            let heightAnchor: NSLayoutConstraint = self.heightAnchor.constraint(equalToConstant: heightConstant)
            heightAnchor.identifier = self.heightIdentifier()
            anchors.append(heightAnchor)
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
        
    }
    
    public func moveUpViewToY(y: CGFloat = 0) {
        for anchor: NSLayoutConstraint in self.constraints {
            if anchor.identifier == self.topIdentifier() {
                anchor.constant = -y
                if !anchor.isActive {
                    anchor.isActive = true
                }
            }
        }
    }
    
    public func moveUpViewToHeight(height: CGFloat = 0) {
        for anchor: NSLayoutConstraint in self.constraints {
            if anchor.identifier == self.bottomIdentifier() {
                anchor.constant = -height
                if !anchor.isActive {
                    anchor.isActive = true
                }
            }
        }
    }
    
    public func moveDownViewToHeight(height: CGFloat = 0) {
        for anchor: NSLayoutConstraint in self.constraints {
            if anchor.identifier == self.bottomIdentifier() {
                anchor.constant = height
                if !anchor.isActive {
                    anchor.isActive = true
                }
            }
        }
    }
    
    public func updateBottomAnchorWithConstant(_ constant: CGFloat = 0) {
        for anchor: NSLayoutConstraint in self.constraints {
            if anchor.identifier == self.bottomIdentifier() {
                anchor.constant = constant
                if !anchor.isActive {
                    anchor.isActive = true
                }
            }
        }
    }
    
    public func updateWidthAnchorWithConstant(_ constant: CGFloat = 0) {
        for anchor: NSLayoutConstraint in self.constraints {
            if anchor.identifier == self.widthIdentifier() {
                anchor.constant = constant
                if !anchor.isActive {
                    anchor.isActive = true
                }
            }
        }
    }
    
    public func updateHeightAnchorWithConstant(_ constant: CGFloat = 0) {
        for anchor: NSLayoutConstraint in self.constraints {
            if anchor.identifier == self.heightIdentifier() {
                anchor.constant = constant
                if !anchor.isActive {
                    anchor.isActive = true
                }
            }
        }
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
