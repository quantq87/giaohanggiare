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
    var type: SPUserType {get set}
    var firstName: String {get set}
    var lastName: String {get set}
    var email: String {get set}
    var phone: String {get set}
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
    var cusomterType: SPCustomerType = .sender
}

class SPShipInfoItem: SPUserInfoItem {

}
