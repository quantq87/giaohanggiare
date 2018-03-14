//
//  PackageItem.swift
//  giaohanggiare
//
//  Created by Quan Tran on 10/11/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

enum SPCustomerType {
    case sender
    case receiver
}

class SPPackageItem: NSObject {
    var senderCustomer: SPCustomerInfo!
    var receiverCustomer: SPCustomerInfo!
    
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
        // Sender
        self.senderCustomer = SPCustomerInfo("", "")
        self.senderCustomer.customerType = .sender
        
        titleString = ""
        detailString = ""
        iconString = "default_icon.png"
        
        money = 0.0
        
        time = Date()
    }
    
    init(userInfo: SPUserInfo) {
        super.init()
        setUpDefault()
        self.senderCustomer = SPCustomerInfo(userInfo.firtName, userInfo.lastName)
        self.senderCustomer.customerType = .sender
        self.senderCustomer.fullName = userInfo.fullName
        self.senderCustomer.firtName = userInfo.firtName
        self.senderCustomer.lastName = userInfo.lastName
        self.senderCustomer.phoneNumberString = userInfo.phoneNumberString
        self.senderCustomer.addressString = userInfo.addressString
        self.senderCustomer.shopName = userInfo.shopName
    }
}

class SPCustomerInfo: NSObject {
    var firtName:String = ""
    var lastName:String = ""
    var fullName:String = ""
    var shopName:String = ""
    var addressString:String = ""
    var phoneNumberString:String = ""
    var emailString:String = ""
    var customerType: SPCustomerType = .sender
    
    override init() {
        super.init()
    }
    
    init(_ firtName: String, _ lastName: String) {
        self.firtName = firtName
        self.lastName = lastName
        self.fullName = lastName + " " + firtName
        super.init()
    }
    
    init(_ type: SPCustomerType) {
        self.customerType = type
        super.init()
    }
    
    public func getRefixNameCustomerInfo() -> String {
        var result: String = ""
        
        switch self.customerType {
        case .sender:
            result = "Ten khach hang: "
            break
        default:
            result = "Ten nguoi nhan: "
            break
        }
        return result
    }
}
