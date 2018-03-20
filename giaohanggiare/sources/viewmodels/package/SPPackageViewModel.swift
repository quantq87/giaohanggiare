//
//  SPPackageViewModel.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 3/20/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import Foundation

protocol SPBaseViewModel {
    
}

class SPPackageViewModel: SPBaseViewModel {
    static let shareInstance = SPPackageViewModel()
    
    var currentPackageList: NSMutableArray = NSMutableArray()
    
    public func getPackageList() -> NSMutableArray {
        currentPackageList = SPListManager.shareInstance.getPackageItemList()
        return currentPackageList
    }
    
    private func validateSenderCustomer(_ senderCustomer: SPCustomerInfoItem) -> (success: Bool, error: String) {
        if senderCustomer.fullName.isEmpty {
            return (false, "FullName can't blank")
        }
        if senderCustomer.phone.isEmpty {
            return (false, "Phone number can't blank")
        }
        if senderCustomer.email.isEmpty {
            return (false, "Email can't blank")
        }
        if senderCustomer.address.isEmpty {
            return (false, "Address can't blank")
        }
        return (true, "")
    }
    
    public func addPackage(_ package: SPPackageItem) -> (success: Bool, error: String) {
        let result = validateSenderCustomer(package.senderCustomer)
        if !result.success {
            return result
        }
        
        return (true, "") // Add completed
    }
    
    public func updatePackage(_ package: SPPackageItem) -> Bool {
        
        return true // Update completed
    }
    
    public func deletePackage(_ idPackage: String) -> Bool {
        
        return true // Delete completed
    }
}
