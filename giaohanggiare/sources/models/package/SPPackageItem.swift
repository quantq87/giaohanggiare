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

enum ExampleEstimateTime {
    case morning
    case atfernoon
    case evening
}

enum ExamplePayOfUser {
    case sender
    case receiver
}

class ExampleAddress: NSObject {
    var district: String = ""
    var ward: String = ""
    var street: String = ""
    var city: String = ""
    
    var addressString: String = ""
    var latitude: CGFloat = 0.0
    var longitude:CGFloat = 0.0
    
    override init() {
        super.init()
    }
    
    func getFullAddress() -> String {
        return addressString + " " + ward + " " + district + " " + city
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
    
    var infoReceiverUser: ExampleUser = ExampleUser()
    
    
    // *** Thong tin lay hang
    // SDT lay hang
    // Ten khach hang de lay hang
    // Quan/Huyen/Phuong/Duong
    // Dia chi nha
    
    var infoSenderUser: ExampleUser = ExampleUser()
    
    // *** Estimate
    // Thoi gian lay hang
    // Thoi gian giao
    var receiverEstimateTime: ExampleEstimateTime = .morning
    var senderEstimateTime: ExampleEstimateTime = .morning
    
    
    // *** Detail Package
    // Ten san pham
    // KL(kg)
    // SL
    var packageList:NSMutableArray = NSMutableArray()
    
    
    // Phi ship
    // Noi tra
    // Tien Thu Ho
    // Tong tien
    // Ghi chu
    
    var shipFee: CGFloat = 0.0
    var payOfUser:ExamplePayOfUser = .sender
    var collectionMoney: CGFloat = 0.0
    var totalMoney: CGFloat = 0.0
    var note: String = ""
    
    override init() {
        super.init()
    }
    
    public static func getExamplePackage() -> ExamplePackageItem {
        let package = ExamplePackageItem()
        
        package.infoReceiverUser.nameUser = "Quan"
        package.infoReceiverUser.phoneNumberString = "0982789809"
        package.infoReceiverUser.addressInfo.addressString = "234 Le Van Sy"
        package.infoReceiverUser.addressInfo.district = "Quan 3"
        package.infoReceiverUser.addressInfo.ward = "Phuong 4"
        package.infoReceiverUser.addressInfo.city = "TP HCM"
        
        package.infoSenderUser.nameUser = "Suong"
        package.infoSenderUser.phoneNumberString = "0982789809"
        package.infoSenderUser.addressInfo.addressString = "56 Le Van Sy"
        package.infoSenderUser.addressInfo.district = "Quan 4"
        package.infoSenderUser.addressInfo.ward = "Phuong 5"
        package.infoSenderUser.addressInfo.city = "TP HCM"
        
        let packageItem : ExamplePackageInfo = ExamplePackageInfo()
        packageItem.amount = 1
        packageItem.namePackage = "Kinh chieu hau"
        packageItem.weight = 0.5
        
        package.packageList.add(packageItem)
        
        package.shipFee = 50.0
        package.collectionMoney = 5000000.0
        package.note = "Hang de vo"
        
        return package
    }
}
