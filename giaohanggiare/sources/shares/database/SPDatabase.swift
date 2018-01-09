//
//  SPDatabase.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 1/9/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

class SPDatabase: NSObject {
    
    static let shareInstance = SPDatabase()
    var a:String!
    
    public func saveStringBase64ToDB(string: String, key: String) {
        a = key
        let db:UserDefaults = UserDefaults.standard
        db.set(string, forKey: key)
        db.synchronize()
    }
    
    public func getStringValueFromDB(key: String) -> String! {
        let db:UserDefaults = UserDefaults.standard
        let string = db.string(forKey: key)
        return string
    }
    
    public func testFunction() {
        print("Value of a:\(a)")
    }
}
