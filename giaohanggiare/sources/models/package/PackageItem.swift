//
//  PackageItem.swift
//  giaohanggiare
//
//  Created by Quan Tran on 10/11/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

class PackageItem: NSObject {
    var titleString: String!
    var detailString: String!
    var iconString: String!
    
    var money: CGFloat = 0.0
    
    var time: Date!
    
    override init() {
        super.init()
        setUpDefault()
    }
    
    func setUpDefault() {
        titleString = ""
        detailString = ""
        iconString = "default_icon.png"
        
        money = 0.0
        
        time = Date()
    }
    
}
