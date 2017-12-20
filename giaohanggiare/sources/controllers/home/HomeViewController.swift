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
    
    var currentPackages: NSMutableArray!
    var currentSelectTagIndex: NSInteger! = 0
    
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
        packageTableView.backgroundColor = .clear
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
        
        currentPackages = packageItems
        
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
        
        currentSelectTagIndex = index
        currentPackages = getCurrentPackageArray(index: index)
        packageTableView.reloadDataTable()
    }
    
    func getCurrentPackageArray(index: NSInteger) -> NSMutableArray {
        
        switch index {
        case 1:
            return packageItems
        default:
            return NSMutableArray()
        }
    }
}

extension HomeViewController: SPTableViewDataSource, SPTableViewDataDelegate {
    
    // Source
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if currentPackages.count > 0 {
            return currentPackages.count
        }
        return 0
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SPHomePackageCell
        //if cell == nil {
        //    cell = SPHomePackageCell.init(style: .default, reuseIdentifier: cellId)
        //}
        if let item:PackageItem = currentPackages.object(at: indexPath.row) as? PackageItem {
            cell.setupDataForCell(item: item)
        }
        return cell
    }
    
    // Delegate
    func didSelectRowAt(indexPath: IndexPath) {
        
    }
    
    func heightForRowAt(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
}

class SPHomePackageCell: SPCustomTableCell {
    
    var namePackageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "#ACB15C2"
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    var statusButton: UIButton = {
        let button = UIButton(type: .custom, customType: .waiting)
        button.setTitle("Cho duyet", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        return button
    }()
    
    
    var nameCustomerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "Chi Dung"
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "123/23/123 Le Duan, Phuong Ben Nghe, Quan 1, TP HCM"
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "20/12/2017"
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        return label
    }()
    
    var totalPayLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "300.000 VND"
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewCell() {
        
        contentView.addSubview(namePackageLabel)
        contentView.addSubview(statusButton)
        contentView.addSubview(nameCustomerLabel)
        contentView.addSubview(addressLabel)
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(totalPayLabel)
        
        namePackageLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, right: nil, bottom: nil, topConstant: 5.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 150, heightConstant: 25.0)
        
        statusButton.anchor(contentView.topAnchor, left: nil, right: contentView.rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 0.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 100, heightConstant: 25.0)
        
        // Next row
        nameCustomerLabel.anchor(namePackageLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        // Next row
        addressLabel.anchor(nameCustomerLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 40.0)
        
        // Next row
        dateLabel.anchor(addressLabel.bottomAnchor, left: contentView.leftAnchor, right: nil, bottom: nil, topConstant: 2.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 25.0)
        // ** Next Columm
        totalPayLabel.anchor(addressLabel.bottomAnchor, left: dateLabel.rightAnchor, right: nil, bottom: nil, topConstant: 2.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 25.0)
    }
    
    public func setupDataForCell(item: PackageItem) {
        namePackageLabel.text = item.titleString
        nameCustomerLabel.text = item.detailString
        
    }
    
}

enum CustomButtonType {
    case waiting
    case failed
    case success
    case cancel
}

extension UIButton {
    convenience init(type: UIButtonType, customType: CustomButtonType) {
        self.init(type: type)
        switch customType {
        case .waiting:
            drawWaitingCusom()
            break
        default:
            drawWaitingCusom()
        }
    }
    
    func drawWaitingCusom() {
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = .blue
    }
}
