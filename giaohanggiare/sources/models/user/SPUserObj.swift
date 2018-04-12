//
//  SPUserObj.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 4/12/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

protocol SPLocationProtocol {
    var city: String {get set}
    var district: String {get set}
    var ward: String {get set}
    
    init(cityN: String, districtN: String, wardN: String)
}

class SPDefaulLocation: SPLocationProtocol {
    var city: String = ""
    var district: String = ""
    var ward: String = ""
    
    required init(cityN: String, districtN: String, wardN: String) {
        self.city = cityN
        self.district = districtN
        self.ward = wardN
    }
}

protocol SPUserProtocol {
    var phone: String {get} // key
    var email: String {get} // subkey
    var name: String {get}
    var firstName: String {get}
    var lastName: String {get}
    var address: String {get}
    var location: SPLocationProtocol {get set}
    var type: SPUserType {get}
}

class SPUserObj: NSObject {
    var phone:String = ""
    var email:String = ""
    var name:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var address:String = ""
    var location: SPLocationProtocol = SPDefaulLocation(cityN: "", districtN: "", wardN: "")
    var type: SPUserType = .customer
    
    override init() {
        super.init()
    }
    
    init(phone: String?, name: String?) {
        
    }
    
}
