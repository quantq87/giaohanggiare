//
//  SPListManager.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 1/11/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

class SPListManager: NSObject {
    var packageItemList: NSMutableArray!
    static let shareInstance = SPListManager()
    
    public func getPackageItemList () -> NSMutableArray {
        
        if packageItemList == nil {
            packageItemList = NSMutableArray()
        }
        // Create Data
        let item1: PackageItem = PackageItem()
        item1.titleString = "Item 1"
        item1.detailString = "Item 1"
        item1.iconString = "default_icon.png"
        item1.money = 21.000
        item1.time = Date()
        packageItemList.add(item1)
        
        let item2: PackageItem = PackageItem()
        item2.titleString = "Item 2"
        item2.detailString = "Item 2"
        item2.iconString = "default_icon.png"
        item2.money = 22.000
        item2.time = Date()
        packageItemList.add(item2)
        
        
        let item3: PackageItem = PackageItem()
        item3.titleString = "Item 3"
        item3.detailString = "Item 3"
        item3.iconString = "default_icon.png"
        item3.money = 23.000
        item3.time = Date()
        packageItemList.add(item3)
        
        
        let item4: PackageItem = PackageItem()
        item4.titleString = "Item 4"
        item4.detailString = "Item 4"
        item4.iconString = "default_icon.png"
        item4.money = 24.000
        item4.time = Date()
        packageItemList.add(item4)
        
        let item5: PackageItem = PackageItem()
        item5.titleString = "Item 5"
        item5.detailString = "Item 5"
        item5.iconString = "default_icon.png"
        item5.money = 25.000
        item5.time = Date()
        packageItemList.add(item5)
        
        let item6: PackageItem = PackageItem()
        item6.titleString = "Item 6"
        item6.detailString = "Item 6"
        item6.iconString = "default_icon.png"
        item6.money = 26.000
        item6.time = Date()
        packageItemList.add(item6)
        
        return packageItemList
    }
}
