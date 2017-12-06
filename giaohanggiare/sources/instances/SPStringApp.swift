//
//  SPStringApp.swift
//  giaohanggiare
//
//  Created by Quan Tran on 9/30/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

struct StringAppTitle {
    static let home_title = "Home"
//    static let testStrLength = countElements(testStr)
//    
//    static let arrayOfTests: [String] = ["foo", "bar", testStr]
}

class SPStringApp: NSObject {
    let home_title = "Home"
    
    func getHomeTitle() -> String {
        return home_title
    }
    
}
