//
//  SPUserInfoItem.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 3/19/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

enum SPUserType {
    case customer
    case ship
    case manager
}

protocol SPPersonInfo {
    var type: SPUserType {get}
    var firstName: String {get}
    var lastName: String {get}
    var email: String {get}
    var phone: String {get}
}

struct SPSenderDefauldPersonInfo: SPPersonInfo {
    let type: SPUserType  = .customer
    let firstName: String = ""
    let lastName: String = ""
    let email: String = ""
    let phone: String = ""
}

class SPUserInfoItem: NSObject {
    var type: SPUserType = .customer
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phone: String = ""
    
    override init() {
        super.init()
    }
    
    init(personInfo: SPPersonInfo) {
        self.firstName = personInfo.firstName
        self.lastName = personInfo.lastName
        self.email = personInfo.email
        self.phone = personInfo.phone
        self.type = personInfo.type
        super.init()
    }
}

class SPCustomerInfoItem: SPUserInfoItem {
    var customerType: SPCustomerType = .sender
    
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

class SPShipInfoItem: SPUserInfoItem {

}
