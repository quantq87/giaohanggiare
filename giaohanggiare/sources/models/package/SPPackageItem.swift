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
    var senderCustomer: SPCustomerInfoItem!
    var receiverCustomer: SPCustomerInfoItem!
    
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
        self.senderCustomer = SPCustomerInfoItem(personInfo: SPSenderDefauldPersonInfo())
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
        self.senderCustomer = SPCustomerInfoItem(personInfo: SPSenderDefauldPersonInfo())
        self.senderCustomer.customerType = .sender
//        self.senderCustomer.fullName = userInfo.fullName
//        self.senderCustomer.firtName = userInfo.firtName
//        self.senderCustomer.lastName = userInfo.lastName
//        self.senderCustomer.phoneNumberString = userInfo.phoneNumberString
//        self.senderCustomer.addressString = userInfo.addressString
//        self.senderCustomer.shopName = userInfo.shopName
    }
}

