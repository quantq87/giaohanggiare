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
    
    public func signInWithInfo(_ username: String, password: String, completedHandle:@escaping (_ success: Bool, _ errorString: String) -> ()) {
        if username.isEmpty {
            completedHandle(false, "username is blank!!!")
            return
        }
        if password.isEmpty {
            completedHandle(false, "password is blank!!!")
            return
        }
        SPAPIServer.shareInstance.doLoginToServer(user: username, pass: password) { (success, response, message) in
            if success && response != nil {
                let userInfo = self.parserUserInfoWithDataResponse(response?.object(forKey: "userInfo") as! NSDictionary)
                guard !userInfo.email.isEmpty else {
                    completedHandle(false, "Login is failed!!!")
                    return
                }
                SPUserManager.shareInstance.currentUserId = response?.object(forKey: "userId") as! String
                SPUserManager.shareInstance.currentAccessToken = response?.object(forKey: "accessToken") as! String
                SPUserManager.shareInstance.currentUserInfo = SPUserInfo()
                completedHandle(true, "Login is completed!!!")
            } else {
                completedHandle(false, "Login is failed!!!")
            }
        }
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
    
    
    private func parserUserInfoWithDataResponse(_ response: NSDictionary) -> SPCustomerInfoItem {
        let result = SPCustomerInfoItem(.sender)
        
        result.email = response.object(forKey: "email") as! String
        result.password = response.object(forKey: "password") as! String
        result.phone = response.object(forKey: "phone") as! String
//        userInfo =         {
//            "__v" = 0;
//            "_id" = 5abbab8e0c043324422c741a;
//            email = "Quan@gmail.com";
//            id = "4493d670-3297-11e8-a1df-5d046656e0b9";
//            name = Quan;
//            password = "gdyb21LQTcIANtvYMT7QVQ==";
//            phone = 0987654321;
//        };
        
        return result
    }
}
