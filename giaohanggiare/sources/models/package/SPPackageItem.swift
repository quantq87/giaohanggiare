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

enum SPTransportType {
    case fly
    case flyAndCar
    case car
    case moto
}

enum SPPlaceType {
    case internalType
    case externalType
}

class SPPackageItem: NSObject {
    var senderCustomer: SPCustomerInfoItem!
    var receiverCustomer: SPCustomerInfoItem!
    
    // Replace to SPUser
    var senderUser:SPUserObj = SPUserObj()
    var receiverUser:SPUserObj = SPUserObj()
    
    var idPackage: String!
    var titleString: String!
    var detailString: String!
    var iconString: String!
    
    var money: CGFloat = 0.0
    
    var time: Date!
    
    var placeTypte: SPPlaceType = .internalType
    var transportType: SPTransportType = .moto
    
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
    
    init(userInfo: SPUserInfo?) {
        super.init()
        setUpDefault()
        
        self.senderCustomer = SPCustomerInfoItem(personInfo: SPSenderDefauldPersonInfo())
        self.senderCustomer.customerType = .sender
    }
    
    init(loginUser: SPUserObj?){
        guard let user = loginUser else {
            return
        }
        self.senderUser = user
    }
}


class ExampleAddress: NSObject {
    var district: String = ""
    var ward: String = ""
    var street: String = ""
    var addressString: String = ""
    
    override init() {
        super.init()
    }
}

class ExampleUser: NSObject {
    
    var phoneNumberString: String = ""
    var nameUser: String = ""
    var addressInfo: ExampleAddress = ExampleAddress()
    
    override init() {
        super.init()
    }
}

class ExamplePackageInfo: NSObject {
    
    var namePackage: String = ""
    var weight: CGFloat = 0.0
    var amount: Int = 0
    
    
    override init() {
        super.init()
    }
}

class ExamplePackageItem: NSObject {
    // ***Thong tin giao hang
    // SDT giao hang
    // Ten khach hang
    // Quan/Huyen/Phuong/Duong
    // Dia chi nha
    
    // *** Thong tin lay hang
    // SDT lay hang
    // Ten khach hang de lay hang
    // Quan/Huyen/Phuong/Duong
    // Dia chi nha
    
    // *** Estimate
    // Thoi gian lay hang
    // Thoi gian giao
    
    
    // *** Detail Package
    // Ten san pham
    // KL(kg)
    // SL
    
    // Phi ship
    // Noi tra
    // Tien Thu Ho
    // Tong tien
    // Ghi chu
    
    
    override init() {
        super.init()
    }
    
}
