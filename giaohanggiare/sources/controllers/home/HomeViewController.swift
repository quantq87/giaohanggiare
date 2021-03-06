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
    
    var currentPackages: NSMutableArray!
    var currentSelectTagIndex: NSInteger! = 0
    
    
    var createPackageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Tạo đơn hàng", for: .normal)
        button.backgroundColor = UIColor.rgb(r: 28, g: 157, b: 97)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.addTarget(self, action: #selector(addPackage), for: .touchUpInside)
        return button
    }()
    
    var createPackageStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        return stackView
    }()
    
    lazy var packageListTableView:SPTableView  = {
        let table = SPTableView(frame: .zero)
        table.backgroundColor = .clear
        table.currentItemType = .home
        table.separatorStyle = .none
        return table
    }()
    
    var tablePackageStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        return stackView
    }()
    
//    var addFloatingButton: SPFloatingButton = {
//        let button = SPFloatingButton(type: .custom)
//        button.backgroundColor = .mainColor
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35.0)
//        button.setTitle("+", for: .normal)
//        button.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
//        button.addTarget(self, action: #selector(addNewPackageOnTouchInside), for: UIControlEvents.touchUpInside)
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        SPLoadingView.shareInstance.startLoadingAnimation(self.view)
        self.perform(#selector(completedRunLoading), with: nil, afterDelay: 2.0)
    }

    @objc private func completedRunLoading() {
        SPLoadingView.shareInstance.stopLoadingAnimation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        self.navigationItem.title = StringAppTitle.LIST_PACKAGE_TITLE
        
        view.addSubview(createPackageStackView)
        createPackageStackView.addArrangedSubview(createPackageButton)
        if #available(iOS 11.0, *) {
            createPackageStackView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: nil, topConstant: 66.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
        } else {
            // Fallback on earlier versions
            createPackageStackView.anchor(view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 66.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
        }
        
        
//        if topTabBarView == nil {
//            topTabBarView = SPTopTabBarView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 35))
//        }
//        topTabBarView.removeFromSuperview()
//        topTabBarView.setUpTabBarWithType(type: .home)
//        topTabBarView.delegate = self
//        view.addSubview(topTabBarView)
//        topTabBarView.selectedItemIndex(index: 1)

//        if packageTableView == nil {
//            packageTableView = SPTableView(type: .home, frame:
//                CGRect(x: 0, y: 64 + 35, width: self.view.bounds.width, height: self.view.bounds.height - (64 + 35)))
//        }
//        packageTableView.backgroundColor = .clear
//        packageTableView.currentItemType = .home
//        packageTableView.customDataSource = self
//        packageTableView.customDataDelegate = self
//        packageTableView.separatorStyle = .none
//        view.addSubview(packageTableView)
        view.addSubview(tablePackageStackView)
        
        if #available(iOS 11.0, *) {
            tablePackageStackView.anchor(createPackageStackView.bottomAnchor, left: createPackageStackView.leftAnchor, right: createPackageStackView.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, topConstant: 2.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 0.0)
        } else {
            // Fallback on earlier versions
            tablePackageStackView.anchor(createPackageStackView.bottomAnchor, left: createPackageStackView.leftAnchor, right: createPackageStackView.rightAnchor, bottom: view.bottomAnchor, topConstant: 2.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 0.0)
        }
        
        tablePackageStackView.addArrangedSubview(packageListTableView)
        packageListTableView.customDataSource = self
        packageListTableView.customDataDelegate = self
        
        currentPackages = SPPackageViewModel.shareInstance.getPackageList()
        packageListTableView.register(SPHomePackageCell.self, forCellReuseIdentifier: cellId)
        packageListTableView.reloadDataTable()

//        view.addSubview(addFloatingButton)
//        addFloatingButton.layer.cornerRadius = 60/2
//        addFloatingButton.clipsToBounds = true
//        addFloatingButton.anchor(nil, left: nil, right: view.rightAnchor, bottom: view.bottomAnchor, topConstant: 0.0, leftConstant: 0.0, rightConstant: -10, bottomConstant: -10, widthConstant: 60, heightConstant: 60)
//        
//        view.addSubview(checkButton)
//        checkButton.anchor(view.centerYAnchor, left: view.centerXAnchor, right: nil, bottom: nil, topConstant: 0.0, leftConstant: -100, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 200, heightConstant: 35.0)
//
//        view.addSubview(dropDownButton)
//        dropDownButton.anchor(view.centerYAnchor, left: view.centerXAnchor, right: nil, bottom: nil, topConstant: -100.0, leftConstant: -100, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 200, heightConstant: 35.0)
    }
    
    var checkButton: SPCheckBoxButton = {
        let checkButton = SPCheckBoxButton(frame: .zero)
        checkButton.heightForCheckBox = 35.0
        checkButton.addTarget(self, action: #selector(testCheckBoxButton), for: .touchUpInside)
        checkButton.setTitleForCheckBox("Check box 1")
        return checkButton
    } ()
    
    var dropDownButton: SPDropDownButton = {
        let dropDown = SPDropDownButton(frame: .zero)
        dropDown.setSelectedValueForCheckBox("ABC Selected")
        dropDown.setListItemsWithArray(NSArray(arrayLiteral: "Test abc 1", "Test abc 2", "Test abc 3", "Test abc 4", "Test abc 5", "Test abc 6"))
        dropDown.defaultIndexSelected = 5;
        dropDown.addTarget(self, action: #selector(testdropDownButton), for: .touchUpInside)
        return dropDown
    } ()
    
    @objc func testdropDownButton(sender: UIButton)  {
        print("Update Check Box State")
        dropDownButton.showDropDownItemsView()
    }
    
     @objc func testCheckBoxButton(sender: UIButton)  {
        print("Update Check Box State")
        checkButton.updateCheckStateButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
        currentPackages = SPPackageViewModel.shareInstance.getPackageList()
        self.packageListTableView.reloadDataTable()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func addPackage(sender: UIBarButtonItem)  {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SPNewPackageViewController") as! SPNewPackageViewController
        
        if SPPackageManager.shareInstance.currentEditPackage == nil {
//            SPPackageManager.shareInstance.currentEditPackage = SPPackageItem(userInfo: SPUserManager.shareInstance.currentUserInfo)
//            secondViewController.currentNewPackage = SPPackageManager.shareInstance.currentEditPackage
        } else {
            // TODO: Save current package
            secondViewController.currentNewPackage = SPPackageManager.shareInstance.currentEditPackage
        }
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func addNewPackageOnTouchInside(sender: UIButton)  {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SPNewPackageViewController") as! SPNewPackageViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension HomeViewController: SPTopTabBarDelegate {
    func OnPressTabBarButton(index: NSInteger) {
        print("Select item index\(index)")
        
        currentSelectTagIndex = index
        currentPackages = getCurrentPackageArray(index: index)
        packageListTableView.reloadDataTable()
    }
    
    func getCurrentPackageArray(index: NSInteger) -> NSMutableArray {
        
        switch index {
        case 1, 2:
            return SPListManager.shareInstance.getPackageItemList()
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
        return 1
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SPHomePackageCell
        if currentPackages.count > 0, let item:SPPackageItem = currentPackages.object(at: indexPath.row) as? SPPackageItem {
            cell.setupDataForCell(item: item)
        }
        cell.selectionStyle = .none
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
    
    var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "123/23/123 Le Duan, Phuong Ben Nghe, Quan 1, TP HCM"
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        return label
    }()
    
    var paymentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        return label
    }()
    
    
    
//    var statusButton: UIButton = {
//        let button = UIButton(type: .custom, customType: .waiting)
//        button.setTitle("Cho duyet", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
//        return button
//    }()
//
//    var iconNameCustomer: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.image = UIImage(named: "icon_customer")
//        imageView.backgroundColor = .clear
//        return imageView
//    }()
//
//    var nameCustomerLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.backgroundColor = .clear
//        label.text = "Chi Dung"
//        label.font = UIFont.systemFont(ofSize: 13.0)
//        return label
//    }()
//
//    var iconAddress: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.image = UIImage(named: "icon_address")
//        imageView.backgroundColor = .clear
//        return imageView
//    }()
//
//    var addressLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.backgroundColor = .clear
//        label.text = "123/23/123 Le Duan, Phuong Ben Nghe, Quan 1, TP HCM"
//        label.font = UIFont.systemFont(ofSize: 13.0)
//        label.numberOfLines = 2
//        return label
//    }()
//
//    var iconDate: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.image = UIImage(named: "icon_date")
//        imageView.backgroundColor = .clear
//        return imageView
//    }()
//
//    var dateLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.backgroundColor = .clear
//        label.text = "20/12/2017"
//        label.font = UIFont.systemFont(ofSize: 13.0)
//        label.numberOfLines = 2
//        return label
//    }()
//
//    var iconPay: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.image = UIImage(named: "icon_pay")
//        imageView.backgroundColor = .clear
//        return imageView
//    }()
//    var totalPayLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.backgroundColor = .clear
//        label.text = "300.000 VND"
//        label.font = UIFont.systemFont(ofSize: 13.0)
//        label.numberOfLines = 2
//        return label
//    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Update UI
        self.setupViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewCell() {
        
        contentView.addSubview(namePackageLabel)
//        contentView.addSubview(statusButton)
//
//        contentView.addSubview(iconNameCustomer)
//        contentView.addSubview(nameCustomerLabel)
//
//        contentView.addSubview(iconAddress)
        contentView.addSubview(addressLabel)
//
//        contentView.addSubview(iconDate)
//        contentView.addSubview(dateLabel)
//
//        contentView.addSubview(iconPay)
//        contentView.addSubview(totalPayLabel)
        
        contentView.addSubview(paymentLabel)
        namePackageLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        addressLabel.anchor(namePackageLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, bottom: nil, topConstant: 1.5, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        paymentLabel.anchor(addressLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, bottom: nil, topConstant: 1.5, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        var nameAttributeString = self.getAttributeStringFrom(refix: "Ten: ", valueString: "Quoc Quan / ")
        nameAttributeString = self.addUnderLineStringToAttributeString(fromAttributeString: nameAttributeString, valueString: "0982789809")
        namePackageLabel.attributedText = nameAttributeString
        
        let addressAttributeString = self.getAttributeStringFrom(refix: "Dia chi: ", valueString: "123/23/123 Le Duan, Phuong Ben Nghe, Quan 1, TP HCM")
        addressLabel.attributedText = addressAttributeString
        
        let feeShipAttributeString = self.getAttributeStringFrom(refix: "Phi ship: ", valueString: "20.000 VND")
        let collectionShipAttributeString = self.getAttributeStringFrom(refix: " / Thu ho: ", valueString: "200.000 VND")
        feeShipAttributeString.append(collectionShipAttributeString)
        paymentLabel.attributedText = feeShipAttributeString
        
//
//        statusButton.anchor(contentView.topAnchor, left: nil, right: contentView.rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 0.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 100, heightConstant: 25.0)
//
//        // Next row
//        iconNameCustomer.anchor(namePackageLabel.bottomAnchor, left: contentView.leftAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
//
//        nameCustomerLabel.anchor(namePackageLabel.bottomAnchor, left: iconNameCustomer.rightAnchor, right: contentView.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
//
//        // Next row
//        iconAddress.anchor(nameCustomerLabel.bottomAnchor, left: contentView.leftAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
//        addressLabel.anchor(nameCustomerLabel.bottomAnchor, left: iconAddress.rightAnchor, right: contentView.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 40.0)
//
//        // Next row
//        iconDate.anchor(addressLabel.bottomAnchor, left: contentView.leftAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
//        dateLabel.anchor(addressLabel.bottomAnchor, left: iconDate.rightAnchor, right: nil, bottom: nil, topConstant: 0.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 25.0)
//
//        // ** Next Columm
//        iconPay.anchor(addressLabel.bottomAnchor, left: dateLabel.rightAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
//        totalPayLabel.anchor(addressLabel.bottomAnchor, left: iconPay.rightAnchor, right: nil, bottom: nil, topConstant: 0.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 25.0)
    }
    
    private func addUnderLineStringToAttributeString(fromAttributeString: NSMutableAttributedString, valueString: String) -> NSMutableAttributedString {
        var attributeString: NSMutableAttributedString = NSMutableAttributedString()
        
        let labelString = valueString
        let textColor: UIColor = .black
        let underLineColor: UIColor = .black
        let underLineStyle = NSUnderlineStyle.styleSingle.rawValue
        let font = UIFont.boldSystemFont(ofSize: 13.0)
        
        let labelAtributes:[NSAttributedStringKey : Any]  = [
            NSAttributedStringKey.foregroundColor: textColor,
            NSAttributedStringKey.underlineStyle: underLineStyle,
            NSAttributedStringKey.underlineColor: underLineColor,
            NSAttributedStringKey.font : font
        ]
        
        attributeString = NSMutableAttributedString(string: labelString, attributes: labelAtributes)
        
        fromAttributeString.append(attributeString)
        return fromAttributeString
        
    }
    
    private func getAttributeStringFrom(refix: String, valueString: String) -> NSMutableAttributedString {
        var attributeString: NSMutableAttributedString = NSMutableAttributedString()
        
        let labelString = refix + " " + valueString
        let textColor: UIColor = .black
        let font = UIFont.systemFont(ofSize: 13.0)
        
        let labelAtributes:[NSAttributedStringKey : Any]  = [
            NSAttributedStringKey.foregroundColor: textColor,
            NSAttributedStringKey.font : font
        ]
        
        attributeString = NSMutableAttributedString(string: labelString, attributes: labelAtributes)
        
        return attributeString
        
    }
    
    public func setupDataForCell(item: SPPackageItem) {
        DispatchQueue.main.async {
//        self.namePackageLabel.text = item.titleString
//        self.nameCustomerLabel.text = item.detailString
        }
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
        // Update UI
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = .blue
    }
}

class CustomNavigationBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .red
    }
}

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
}

