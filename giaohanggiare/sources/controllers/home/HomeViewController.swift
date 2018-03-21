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
    
    var currentPackages: NSMutableArray!
    var currentSelectTagIndex: NSInteger! = 0
    
    var addFloatingButton: SPFloatingButton = {
        let button = SPFloatingButton(type: .custom)
        button.backgroundColor = .mainColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35.0)
        button.setTitle("+", for: .normal)
        button.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
        button.addTarget(self, action: #selector(addNewPackageOnTouchInside), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let shapeLayer = CAShapeLayer()
    func initUI() {
//        self.navigationItem.title = StringAppTitle.home_title
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addPackage))
//
//        if topTabBarView == nil {
//            topTabBarView = SPTopTabBarView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 35))
//        }
//        topTabBarView.removeFromSuperview()
//        topTabBarView.setUpTabBarWithType(type: .home)
//        topTabBarView.delegate = self
//        view.addSubview(topTabBarView)
//        topTabBarView.selectedItemIndex(index: 1)
//
//        if packageTableView == nil {
//            packageTableView = SPTableView(type: .home, frame:
//                CGRect(x: 0, y: 64 + 35, width: self.view.bounds.width, height: self.view.bounds.height - (64 + 35)))
//        }
//        packageTableView.backgroundColor = .clear
//        packageTableView.currentItemType = .home
//        packageTableView.customDataSource = self
//        packageTableView.customDataDelegate = self
//        view.addSubview(packageTableView)
//
//        currentPackages = SPPackageViewModel.shareInstance.getPackageList()
//        packageTableView.register(SPHomePackageCell.self, forCellReuseIdentifier: cellId)
//        packageTableView.reloadDataTable()
//
//        view.addSubview(addFloatingButton)
//        addFloatingButton.layer.cornerRadius = 60/2
//        addFloatingButton.clipsToBounds = true
//        addFloatingButton.anchor(nil, left: nil, right: view.rightAnchor, bottom: view.bottomAnchor, topConstant: 0.0, leftConstant: 0.0, rightConstant: -10, bottomConstant: -10, widthConstant: 60, heightConstant: 60)
        createAnimatedCircleProgessBar()
    }
    
    var pulsatingLayer: CAShapeLayer!
    
    let pecentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    func createAnimatedCircleProgessBar() {
        
        view.backgroundColor = UIColor.backgroundColor
        let center = view.center
        
         let circularpath  = UIBezierPath(arcCenter: .zero, radius: 100.0, startAngle: -(CGFloat.pi/2), endAngle: 2 * CGFloat.pi, clockwise: true)
        
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularpath.cgPath
        pulsatingLayer.strokeColor = UIColor.clear.cgColor
        pulsatingLayer.fillColor = UIColor.pulsingFillColor.cgColor
        pulsatingLayer.lineWidth = 10
        pulsatingLayer.strokeEnd = 0
        pulsatingLayer.lineCap = kCALineCapRound
        pulsatingLayer.position = center
        view.layer.addSublayer(pulsatingLayer)
        
        // create my track layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularpath.cgPath
        trackLayer.strokeColor = UIColor.trackStrokeColor.cgColor
        trackLayer.fillColor = UIColor.backgroundColor.cgColor
        trackLayer.lineWidth = 10
        trackLayer.strokeEnd = 0
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = center
        view.layer.addSublayer(trackLayer)
        
        animatePulsatingLayer()
        
        shapeLayer.path = circularpath.cgPath
        shapeLayer.strokeColor = UIColor.outlineStrokeColor.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.position = center
        shapeLayer.transform = CATransform3DMakeRotation(-(CGFloat.pi/2.0), 0, 0, 1)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        view.addSubview(pecentageLabel)
        pecentageLabel.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
        pecentageLabel.center = center
    }
    
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
        
    }
    
    @objc private func handleTap() {
        print("Attempting to animate stroke")
        
        let baseAnimation  = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.toValue = 1
        baseAnimation.duration = 2
        
        baseAnimation.fillMode = kCAFillModeForwards
        baseAnimation.isRemovedOnCompletion = false
        shapeLayer.add(baseAnimation, forKey: "urSoBaic")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func addPackage(sender: UIBarButtonItem)  {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SPNewPackageViewController") as! SPNewPackageViewController
        
        if SPPackageManager.shareInstance.currentEditPackage == nil {
            SPPackageManager.shareInstance.currentEditPackage = SPPackageItem(userInfo: SPUserManager.shareInstance.currentUserInfo)
            secondViewController.currentNewPackage = SPPackageManager.shareInstance.currentEditPackage
        } else {
            // TODO: Save current package
            secondViewController.currentNewPackage = SPPackageManager.shareInstance.currentEditPackage
        }
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func addNewPackageOnTouchInside(sender: UIButton)  {
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
        return 0
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SPHomePackageCell
        if let item:SPPackageItem = currentPackages.object(at: indexPath.row) as? SPPackageItem {
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
    
    var statusButton: UIButton = {
        let button = UIButton(type: .custom, customType: .waiting)
        button.setTitle("Cho duyet", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        return button
    }()
    
    var iconNameCustomer: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "icon_customer")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var nameCustomerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "Chi Dung"
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    var iconAddress: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "icon_address")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "123/23/123 Le Duan, Phuong Ben Nghe, Quan 1, TP HCM"
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        return label
    }()
    
    var iconDate: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "icon_date")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "20/12/2017"
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        return label
    }()
    
    var iconPay: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "icon_pay")
        imageView.backgroundColor = .clear
        return imageView
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
        // Update UI
        self.setupViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewCell() {
        
        contentView.addSubview(namePackageLabel)
        contentView.addSubview(statusButton)
        
        contentView.addSubview(iconNameCustomer)
        contentView.addSubview(nameCustomerLabel)
        
        contentView.addSubview(iconAddress)
        contentView.addSubview(addressLabel)
        
        contentView.addSubview(iconDate)
        contentView.addSubview(dateLabel)
        
        contentView.addSubview(iconPay)
        contentView.addSubview(totalPayLabel)
        
        namePackageLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, right: nil, bottom: nil, topConstant: 5.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 150, heightConstant: 25.0)
        
        statusButton.anchor(contentView.topAnchor, left: nil, right: contentView.rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 0.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 100, heightConstant: 25.0)
        
        // Next row
        iconNameCustomer.anchor(namePackageLabel.bottomAnchor, left: contentView.leftAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        
        nameCustomerLabel.anchor(namePackageLabel.bottomAnchor, left: iconNameCustomer.rightAnchor, right: contentView.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        // Next row
        iconAddress.anchor(nameCustomerLabel.bottomAnchor, left: contentView.leftAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        addressLabel.anchor(nameCustomerLabel.bottomAnchor, left: iconAddress.rightAnchor, right: contentView.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 40.0)
        
        // Next row
        iconDate.anchor(addressLabel.bottomAnchor, left: contentView.leftAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        dateLabel.anchor(addressLabel.bottomAnchor, left: iconDate.rightAnchor, right: nil, bottom: nil, topConstant: 0.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 25.0)
        
        // ** Next Columm
        iconPay.anchor(addressLabel.bottomAnchor, left: dateLabel.rightAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        totalPayLabel.anchor(addressLabel.bottomAnchor, left: iconPay.rightAnchor, right: nil, bottom: nil, topConstant: 0.0, leftConstant: 10.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 25.0)
    }
    
    public func setupDataForCell(item: SPPackageItem) {
        DispatchQueue.main.async {
        self.namePackageLabel.text = item.titleString
        self.nameCustomerLabel.text = item.detailString
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
    static func rgb(r: CGFloat , g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
}
