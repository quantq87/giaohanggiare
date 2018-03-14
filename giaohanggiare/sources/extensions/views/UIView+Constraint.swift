//
//  UIView+Constraint.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 12/7/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

extension UIView {

    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
//        addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
    }
    
    func clearConstraints() {
        let superView = self.superview
        while superview != nil {
            if let constraints: NSArray = superview?.constraints {
                
            }
        }
        self.removeConstraints(self.constraints)
    }

}
