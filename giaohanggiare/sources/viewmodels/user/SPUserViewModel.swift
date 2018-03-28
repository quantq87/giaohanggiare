//
//  SPUserViewModel.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 3/28/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import Foundation

class SPUserViewModel: SPBaseViewModel {
    static let shareInstance = SPUserViewModel()
    
    public func signInWithInfo(_ username: String, password: String) -> (success: Bool, error: String) {
        if username.isEmpty {
            return (false, "FullName can't blank")
        }
        if password.isEmpty {
            return (false, "Phone number can't blank")
        }
        return (true, "")
    }
    
    public func signUpWithInfo(_ info: SPCustomerInfoItem, completedHandle:@escaping (_ success: Bool, _ errorString: String) -> ()) {
        SPAPIServer.shareInstance.doSignUpToServer(userInfo: info) { (success, error) in
            
        }
    }
    
    public func signOutWithInfo(_ username: String, password: String) -> (success: Bool, error: String) {
        if username.isEmpty {
            return (false, "FullName can't blank")
        }
        if password.isEmpty {
            return (false, "Phone number can't blank")
        }
        return (true, "")
    }
    
}
