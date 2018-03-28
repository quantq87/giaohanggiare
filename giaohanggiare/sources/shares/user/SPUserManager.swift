//
//  SPUserManager.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 3/12/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import Foundation

class SPUserManager: NSObject {
    static let shareInstance = SPUserManager()
    var currentUserInfo: SPUserInfo!
    var currentUserId: String = ""
    var currentAccessToken: String = ""
}

class SPUserInfo: NSObject {
    var firtName:String = ""
    var lastName:String = ""
    var fullName:String = ""
    var shopName:String = ""
    var addressString:String = ""
    var phoneNumberString:String = ""
    
    
    override init() {
        super.init()
    }
    
    init(_ firtName: String, _ lastName: String) {
        self.firtName = firtName
        self.lastName = lastName
        self.fullName = lastName + " " + firtName
        super.init()
    }
}
