//
//  SPMainTabBarViewController.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 4/12/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

class SPMainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        setupViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTabBarController() {
        view.backgroundColor = UIColor.mainColor
        
//        UITabBar.appearance().barTintColor = UIColor.clear
//        UITabBar.appearance().barTintColor = UIColor.white
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupViewController() {
        let newsNavigationController: UINavigationController = UINavigationController(rootViewController: UIViewController())
        newsNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_news"), selectedImage: UIImage(named: "icon_news_selected"))
        newsNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        let homeViewController = SPApplicationControl.shareInstance.getPackageListViewController()
        let packageNavigationController: UINavigationController = UINavigationController(rootViewController:homeViewController)
        packageNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_packages"), selectedImage: UIImage(named: "icon_packages_selected"))
        packageNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        let infoNavigationController: UINavigationController = UINavigationController(rootViewController: UIViewController())
        infoNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_profile"), selectedImage: UIImage(named: "icon_profile_selected"))
        infoNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        viewControllers = [newsNavigationController, packageNavigationController, infoNavigationController]
    }
}
