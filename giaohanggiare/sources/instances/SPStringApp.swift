//
//  SPStringApp.swift
//  giaohanggiare
//
//  Created by Quan Tran on 9/30/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

struct StringAppTitle {
    static let LIST_PACKAGE_TITLE = "list_package_title".localized(withComment: "with!!!")
    static let CREATE_PACKAGE_TITLE = "list_package_title".localized(withComment: "with!!!")
//    static let testStrLength = countElements(testStr)
//    
//    static let arrayOfTests: [String] = ["foo", "bar", testStr]
}

class SPStringApp: NSObject {
    
    func getHomeTitle() -> String {
        return StringAppTitle.LIST_PACKAGE_TITLE
    }
    
}
