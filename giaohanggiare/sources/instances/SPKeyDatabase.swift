//
//  SPKeyDatabase.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 1/9/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

struct KeyDatabase {
    static let userNameKey = "UserName"
    static let passwordKey = "PasswordKey"
}

class SPKeyDatabase: NSObject {
    
    static let getString = SPKeyDatabase()
    
    public func getUserNameKey() -> String {
        return KeyDatabase.userNameKey
    }
    
    public func getPasswordKey() -> String {
        return KeyDatabase.passwordKey
    }
}
