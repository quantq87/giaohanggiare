//
//  SPApplicationControl.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 4/12/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit
import Foundation

class SPApplicationControl: NSObject {
    static let shareInstance = SPApplicationControl()
    
    override init() {
        super.init()
    }
    
    public func showLoginVCToMainTabBar(animation: Bool) {
        let mainTabBarController: SPMainTabBarViewController = SPMainTabBarViewController()
        
        let application: UIApplication = UIApplication.shared
        application.keyWindow?.rootViewController = mainTabBarController
        application.keyWindow?.makeKeyAndVisible()
        
    }
    
    public func getPackageListViewController() -> UIViewController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let homeViewController: HomeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            return UIViewController()
        }
        return homeViewController
    }
}
