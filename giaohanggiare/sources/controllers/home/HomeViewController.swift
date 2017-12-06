//
//  HomeViewController.swift
//  giaohanggiare
//
//  Created by Quan Tran on 9/24/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    let cellId = "cellHomeID"

    var topTabBarView: SPTopTabBarView!
    var packageTableView:SPTableView!
    var packageItems: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        self.navigationItem.title = StringAppTitle.home_title
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addPackage))
        
        if topTabBarView == nil {
            topTabBarView = SPTopTabBarView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 35))
        }
        topTabBarView.removeFromSuperview()
        topTabBarView.setUpTabBarWithType(type: .home)
        topTabBarView.delegate = self
        view.addSubview(topTabBarView)
        topTabBarView.selectedItemIndex(index: 0)
        
        if packageTableView == nil {
            packageTableView = SPTableView(type: .home, frame:
                CGRect(x: 0, y: 64 + 35, width: self.view.bounds.width, height: self.view.bounds.height - (64 + 35)))
        }
        packageTableView.backgroundColor = .gray
        packageTableView.currentItemType = .home
        packageTableView.customDataSource = self
        packageTableView.customDataDelegate = self
        view.addSubview(packageTableView)
        
        
        // Create Data
        packageItems = NSMutableArray()
        let item1: PackageItem = PackageItem()
        item1.titleString = "Item 1"
        item1.detailString = "Item 1"
        item1.iconString = "default_icon.png"
        item1.money = 21.000
        item1.time = Date()
        packageItems.add(item1)
        
        let item2: PackageItem = PackageItem()
        item2.titleString = "Item 2"
        item2.detailString = "Item 2"
        item2.iconString = "default_icon.png"
        item2.money = 22.000
        item2.time = Date()
        packageItems.add(item2)
        
        
        let item3: PackageItem = PackageItem()
        item3.titleString = "Item 3"
        item3.detailString = "Item 3"
        item3.iconString = "default_icon.png"
        item3.money = 23.000
        item3.time = Date()
        packageItems.add(item3)
        
        
        let item4: PackageItem = PackageItem()
        item4.titleString = "Item 4"
        item4.detailString = "Item 4"
        item4.iconString = "default_icon.png"
        item4.money = 24.000
        item4.time = Date()
        packageItems.add(item4)
        
        let item5: PackageItem = PackageItem()
        item5.titleString = "Item 5"
        item5.detailString = "Item 5"
        item5.iconString = "default_icon.png"
        item5.money = 25.000
        item5.time = Date()
        packageItems.add(item5)
        
        let item6: PackageItem = PackageItem()
        item6.titleString = "Item 6"
        item6.detailString = "Item 6"
        item6.iconString = "default_icon.png"
        item6.money = 26.000
        item6.time = Date()
        packageItems.add(item6)
        
        
        packageTableView.register(SPHomePackageCell.self, forCellReuseIdentifier: cellId)
        packageTableView.reloadDataTable()
    }
    
    
    func addPackage(sender: UIBarButtonItem)  {
        print("addPackage onclick")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SPNewPackageViewController") as! SPNewPackageViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension HomeViewController: SPTopTabBarDelegate {
    func OnPressTabBarButton(index: NSInteger) {
        print("Select item index\(index)")
    }
}

extension HomeViewController: SPTableViewDataSource, SPTableViewDataDelegate {
    
    // Source
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if packageItems.count > 0 {
            return packageItems.count
        }
        return 0
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = SPHomePackageCell.init(style: .default, reuseIdentifier: cellId)
        }
        if let item:PackageItem = packageItems.object(at: indexPath.row) as? PackageItem {
            cell?.textLabel?.text = item.titleString
        }
        return cell!
    }
    
    // Delegate
    func didSelectRowAt(indexPath: IndexPath) {
        
    }
}

class SPHomePackageCell: SPCustomTableCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
