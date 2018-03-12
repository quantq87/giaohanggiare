//
//  SPNewPackageViewController.swift
//  giaohanggiare
//
//  Created by Quan Tran on 12/6/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit
import DropDown

protocol SPPackageInfoDelegate {
    func editButtonOnTouchInside(sender: UIButton)
}

class SPNewPackageViewController: BaseViewController {
    
    //
    var currentNewPackage:SPPackageItem!
    
    
    var packageTableView:SPCollectionView!
    
    let cellId = "CollectionId"
    let personalCellId = "PersonalCollectionId"
    let personalReceiverCellId = "personalReceiverCellId"
    let packageInfoCellId = "packageInfoCellId"
    
    let personalHeaderId = "PersonalHeaderId"
    let packageInfoHeaderId = "packageInfoHeaderId"
    let personalFooterId = "PersonalFooterId"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        setupData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.removeObserver(self)
    }
    
    func initView() {
        self.navigationItem.title = "Tao Don Hang"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .undo, target: self, action: #selector(backBarButtonOnTouch))
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        packageTableView = SPCollectionView(type:.create, frame:.zero, layout: flowLayout)
        
        // Cells
        packageTableView.register(SPCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        packageTableView.register(SPPersonalInfoCell.self, forCellWithReuseIdentifier: personalCellId)
        packageTableView.register(SPPersonalReceiverInfoCell.self, forCellWithReuseIdentifier: personalReceiverCellId)
        packageTableView.register(SPPackageInfoViewCell.self, forCellWithReuseIdentifier: packageInfoCellId)
        
        // Show scrolls
        packageTableView.showsVerticalScrollIndicator = false
        packageTableView.showsHorizontalScrollIndicator = false
        
        // Headers
        packageTableView.register(SPPersonalHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: personalHeaderId)
        packageTableView.register(SPPackageHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: packageInfoHeaderId)
        packageTableView.register(SPPersonalHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: personalFooterId)
        
        packageTableView.backgroundColor = .clear
        
        // Delegate
        packageTableView.setDelegateAndDataSource(self, dataSource: self)
        
        // Add tableView and setConstraints
        view.addSubview(packageTableView);
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: packageTableView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: packageTableView)
    }
    
    func setupData() {
        if currentNewPackage == nil {
            currentNewPackage = SPPackageItem(userInfo: SPUserManager.shareInstance.currentUserInfo)
        } else {
            
        }
    }
    
    func backBarButtonOnTouch(sender: UIBarButtonItem)  {
        print("backBarButtonOnTouch onclick")
        self.navigationController?.popViewController(animated: true)
    }
    
   @objc func keyboardWillAppear(_ notification: Notification) {
        //Do something here
        adjustTableViewWhenKeyboardShow(true, notification: notification)
    }
    
    @objc func keyboardWillDisappear(_ notification: Notification) {
        //Do something here
        adjustTableViewWhenKeyboardShow(false, notification: notification)
    }
    
    func adjustTableViewWhenKeyboardShow(_ open: Bool, notification: Notification) {
        if open {
            let userInfo = notification.userInfo ?? [:]
            let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            let height = (keyboardFrame.height + 20) * (open ? 1 : -1)
            packageTableView.contentInset.bottom += height
            packageTableView.scrollIndicatorInsets.bottom += height
        } else {
            packageTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
}

extension SPNewPackageViewController: SPEditSenderDelegate {
    func didCancelEditInfo() {
        dismiss(animated: true, completion: nil)
    }
    
    func didDoneEditInfo(_ changeInfo: Bool) {
        dismiss(animated: true) { 
            self.packageTableView.reloadData()
        }
    }
}

extension SPNewPackageViewController: SPCollectionViewDataSource, SPCollectionViewDelegate, SPPackageInfoDelegate {
    
    func numberOfSections() -> Int {
        return 3
    }
    
    func numberOfItemsInSection(_ collectionView: UICollectionView, section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 1
        }
        return 1
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personalCellId, for: indexPath) as! SPPersonalInfoCell
            cell.backgroundColor = .white
            cell.delegateInfo = self
            cell.setDataForCell(currentNewPackage.senderCustomer)
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personalReceiverCellId, for: indexPath)
            cell.backgroundColor = .white
            return cell
        }
        else if (indexPath.section == 2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: packageInfoCellId, for: indexPath)
            cell.backgroundColor = .white
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .green
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func sizeForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 5*2, height: 160.0)
    }
    
    func viewForSupplementaryElementOfKind(_ collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            
            if indexPath.section == 0 {
                let header:SPPersonalHeaderCell = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: personalHeaderId, for: indexPath) as! SPPersonalHeaderCell)
                header.backgroundColor = .green
                header.setHeaderTitleWithString(string: "Thong tin khach hang")
                return header;
            } else if (indexPath.section == 1) {
                let header:SPPersonalHeaderCell = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: personalHeaderId, for: indexPath) as! SPPersonalHeaderCell)
                header.backgroundColor = .green
                header.setHeaderTitleWithString(string: "Thong tin don hang")
                return header;
            } else {
                let header:SPPackageHeaderCell = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: packageInfoHeaderId, for: indexPath) as! SPPackageHeaderCell)
                header.backgroundColor = .yellow
                header.setHeaderTitleWithString(string: "Thong tin goi hang")
                return header;
            }
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: personalFooterId, for: indexPath)
            footer.backgroundColor = .green
            return footer
        }
    }
    
    func referenceSizeForHeaderInSection(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 5*2, height: 35.0)
    }
    func referenceSizeForFooterInSection(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  section: Int) -> CGSize{
        return CGSize(width: collectionView.frame.width - 5*2, height: 0.0)
    }
    
    func editButtonOnTouchInside(sender: UIButton) {
        print("editInfoButtonOnTouch onTouchInSide AAAAA")
        
        let editViewController = self.storyboard?.instantiateViewController(withIdentifier: "SPEditSenderViewController") as! SPEditSenderViewController
        editViewController.delegate = self
        
        let navigationController1 = UINavigationController(rootViewController: editViewController)
        navigationController1.modalPresentationStyle = .overCurrentContext
        navigationController1.modalTransitionStyle = .crossDissolve
        navigationController1.providesPresentationContextTransitionStyle = true;
        navigationController1.definesPresentationContext = true;
        present(navigationController1, animated: true, completion: {
            print("Present Edit Sender View Controller is completed!")
        })
        navigationController1.popoverPresentationController?.sourceView = view
        let frameView:CGRect = view.frame;
        navigationController1.popoverPresentationController?.sourceRect = frameView
    }
}

class SPPersonalInfoCell: SPCollectionViewCell {
    var delegateInfo: SPPackageInfoDelegate!
    
    var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = ""
        return label
    }()
    
    var shopNameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = ""
        return label
    }()
    
    var addressLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 2
        label.text = ""
        return label
    }()
    
    var phoneNumberLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 2
        label.text = ""
        return label
    }()
    
    var editInfoButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Edit", for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        return button
    }()
    
    override func setupView() {
        addSubview(nameLabel)
        addSubview(shopNameLabel)
        addSubview(phoneNumberLabel)
        addSubview(addressLabel)
        addSubview(editInfoButton)
        
        // Add Constraints
        nameLabel.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        shopNameLabel.anchor(nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        phoneNumberLabel.anchor(shopNameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        addressLabel.anchor(phoneNumberLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 60.0)
        
        editInfoButton.anchor(topAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 0.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 35.0, heightConstant: 25.0)
        editInfoButton.addTarget(self, action: #selector(editInfoButtonOnTouch), for: .touchUpInside)
    }
    
    func setDataForCell(_ customerInfo: SPCustomerInfo) {
        nameLabel.attributedText = formatCustomerName("Ten Khach Hang: ", firstName: customerInfo.firtName, lastName: customerInfo.lastName)
        shopNameLabel.attributedText = formatTitleBoldAndValueNormal("Ten Shop: ", value: customerInfo.shopName)
        
        phoneNumberLabel.attributedText = formatTitleBoldAndValueNormal("So dien thoai: ", value: customerInfo.phoneNumberString)
        
        addressLabel.attributedText = formatTitleBoldAndValueNormal("Dia chi: ", value: customerInfo.addressString)
    }
    
    func formatCustomerName(_ refix: String, firstName: String, lastName: String) -> NSMutableAttributedString {
        // Name Label
        let fullName = lastName + " " + firstName
        let finalAttString = formatTitleBoldAndValueNormal(refix, value: fullName)
        return finalAttString
    }
    
    func formatTitleBoldAndValueNormal(_ title: String, value: String) -> NSMutableAttributedString {
        // Name Label
        var attributes = [String: Any]()
        attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 14.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString1 = NSAttributedString(string: title, attributes: attributes)
        
        attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 13.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString2 = NSAttributedString(string: value, attributes: attributes)
        
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        finalAttString.append(attString2)
        
        return finalAttString
        
    }
    
    func editInfoButtonOnTouch(sender: UIButton)  {
        print("editInfoButtonOnTouch onTouchInSide")
        if let delegate = self.delegateInfo {
            delegate.editButtonOnTouchInside(sender: sender)
        }
    }
}

class SPPersonalReceiverInfoCell: SPCollectionViewCell {
    var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        // Name Label
        var attributes = [String: Any]()
        attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 14.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString1 = NSAttributedString(string: "Ten Khach Hang: ", attributes: attributes)
        
        attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 13.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString2 = NSAttributedString(string: "Tran Quoc Quan", attributes: attributes)
        
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        finalAttString.append(attString2)
        
        label.attributedText = finalAttString
        return label
    }()
    
    var shopNameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        // Name Label
        var attributes = [String: Any]()
        attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 14.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString1 = NSAttributedString(string: "Ten Shop: ", attributes: attributes)
        
        attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 13.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString2 = NSAttributedString(string: "U-Store", attributes: attributes)
        
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        finalAttString.append(attString2)
        
        label.attributedText = finalAttString
        return label
    }()
    
    var addressLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 2
        
        // Name Label
        var attributes = [String: Any]()
        attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 14.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString1 = NSAttributedString(string: "Dia chi: ", attributes: attributes)
        
        attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 13.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString2 = NSAttributedString(string: "473 Le Van Sy, phuong 13, Quan Phu Nhuan, TP Ho Chi Minh", attributes: attributes)
        
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        finalAttString.append(attString2)
        label.attributedText = finalAttString
        return label
    }()
    
    var phoneNumberLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 2
        
        // Name Label
        var attributes = [String: Any]()
        attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 14.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString1 = NSAttributedString(string: "So dien thoai: ", attributes: attributes)
        
        attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 13.0)
        attributes[NSForegroundColorAttributeName] = UIColor.black
        let attString2 = NSAttributedString(string: "0982789809", attributes: attributes)
        
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        finalAttString.append(attString2)
        
        label.attributedText = finalAttString
        return label
    }()
    
    var editInfoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(editInfoButtonOnTouch), for: .touchUpInside)
        button.setTitle("Edit", for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        return button
    }()
    
    
    var nameReceiverTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Ten nguoi nhan"
        tf.setBottomBorder()
        return tf
    }()
    
    var phoneNumberReceiverTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "So dien thoai"
        tf.setBottomBorder()
        return tf
    }()
    
    var addressReceiverTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Dia chi"
        tf.setBottomBorder()
        return tf
    }()
    
    var noteReceiverTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Ghi chu"
        tf.setBottomBorder()
        return tf
    }()
    override func setupView() {
        
        addSubview(nameReceiverTextField)
        addSubview(phoneNumberReceiverTextField)
        addSubview(addressReceiverTextField)
        addSubview(noteReceiverTextField)
        
        // Add Constraints
        nameReceiverTextField.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        phoneNumberReceiverTextField.anchor(nameReceiverTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        addressReceiverTextField.anchor(phoneNumberReceiverTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        
        addressReceiverTextField.setRightImageView(image: UIImage(named: "location-icon")!, size: CGSize(width: 15.0, height: 15.0))
        
        noteReceiverTextField.anchor(addressReceiverTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
    }
    
    func editInfoButtonOnTouch(sender: UIButton)  {
        print("editInfoButtonOnTouch onTouchInSide")
    }
}

class SPPackageInfoViewCell: SPCollectionViewCell {
    
    
    var packageSizeTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Kich thuoc"
        tf.setBottomBorder()
        return tf
    }()
    
    var packageSizeLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "cm"
        return label
    }()
    
    var packageWeightTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Khoi luong"
        tf.setBottomBorder()
        return tf
    }()
    
    var packageWeightLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "kg"
        return label
    }()
    
    var packageNoteTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Ghi chu"
        tf.setBottomBorder()
        return tf
    }()
    
    var packageCODButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.backgroundColor = .green
        return button
    }()
    
    var packageCODLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "Thu ho"
        return label
    }()
    
    var packageCODTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Thu ho"
        tf.setBottomBorder()
        return tf
    }()
    
    var packageSenderPayButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.backgroundColor = .green
        return button
    }()
    
    var packageSenderPayLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "Nguoi gui tra"
        return label
    }()
    
    var packageReceiverPayButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.backgroundColor = .green
        return button
    }()
    
    var packageReceiverPayLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "Nguoi nhan tra"
        return label
    }()

    override func setupView() {
        
        addSubview(packageSizeTextField)
        addSubview(packageSizeLabel)
        addSubview(packageWeightLabel)
        addSubview(packageWeightTextField)
        addSubview(packageNoteTextField)
        
        addSubview(packageCODButton)
        addSubview(packageCODLabel)
        addSubview(packageCODTextField)
        
        addSubview(packageSenderPayButton)
        addSubview(packageSenderPayLabel)
        
        addSubview(packageReceiverPayButton)
        addSubview(packageReceiverPayLabel)
        
        // Add Constraints
        packageSizeTextField.anchor(topAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: contentView.frame.width/2 - 25 - 4.0, heightConstant: 30.0)
        
        packageSizeLabel.anchor(topAnchor, left: packageSizeTextField.rightAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 30.0)
        
        
        packageWeightLabel.anchor(topAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 0.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 30.0)
        
        packageWeightTextField.anchor(topAnchor, left: nil, right: packageWeightLabel.leftAnchor, bottom: nil, topConstant: 2, leftConstant: 0.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: contentView.frame.width/2 - 25 - 4.0, heightConstant: 30.0)
        
        packageNoteTextField.anchor(packageSizeTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        
        
        packageCODButton.anchor(packageNoteTextField.bottomAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 30.0, heightConstant: 30.0)
        
        packageCODLabel.anchor(packageNoteTextField.bottomAnchor, left: packageCODButton.rightAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 80.0, heightConstant: 30.0)
        
        packageCODTextField.anchor(packageNoteTextField.bottomAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 150.0, heightConstant: 30.0)
        
        
        packageSenderPayButton.anchor(packageCODButton.bottomAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 30.0, heightConstant: 30.0)
        
        packageSenderPayLabel.anchor(packageCODButton.bottomAnchor, left: packageSenderPayButton.rightAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 30.0)
        
        packageReceiverPayLabel.anchor(packageCODButton.bottomAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 30.0)
        
        packageReceiverPayButton.anchor(packageCODButton.bottomAnchor, left: nil, right: packageReceiverPayLabel.leftAnchor, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 30.0, heightConstant: 30.0)
    }
    
    func editInfoButtonOnTouch(sender: UIButton)  {
        print("editInfoButtonOnTouch onTouchInSide")
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func setRightImageView(image: UIImage, size:CGSize)  {
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = .clear
        imageView.frame = CGRect(x: 0, y: 0.0, width: size.width, height: size.height)
        
        self.rightView = imageView
        self.rightViewMode = .always
    }
}

class SPPersonalHeaderCell: UICollectionReusableView {
    
    var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        addSubview(nameLabel)
        
        nameLabel.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, topConstant: 2, leftConstant: 2, rightConstant: -2.0, bottomConstant: -2.0, widthConstant: 0.0, heightConstant: 0.0)
    }
    
    public func setHeaderTitleWithString(string: String) {
        // Name Label
        var attributes = [String: Any]()
        attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 15.0)
        attributes[NSForegroundColorAttributeName] = UIColor.blue
        let attString1 = NSAttributedString(string: string, attributes: attributes)
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        nameLabel.attributedText = finalAttString
    }
}

class SPPackageHeaderCell: UICollectionReusableView {
    
    var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = ""
        return label
    }()
    
    var modePackageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "ABC 123"
        return label
    }()
    
    var modePackageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(showDropDownOnTouchInside), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    var isDropDownShow: Bool = false
    
    
    var modePackageView: DropDown = {
        let dropDown = DropDown()
        
        // The view to which the drop down will appear on
        //dropDown.anchorView = view // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        
        return dropDown
    }()
    
    func showDropDownOnTouchInside(sender: UIButton) {
        if !isDropDownShow {
            isDropDownShow = true
            modePackageView.show()
        } else {
            isDropDownShow = false
            modePackageView.hide()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        addSubview(nameLabel)
        addSubview(modePackageLabel)
        addSubview(modePackageButton)
        nameLabel.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, topConstant: 2, leftConstant: 2, rightConstant: -2.0, bottomConstant: -2.0, widthConstant: 0.0, heightConstant: 0.0)
        modePackageLabel.anchor(topAnchor, left: nil, right: rightAnchor, bottom: bottomAnchor, topConstant: 2, leftConstant: 2, rightConstant: -2.0, bottomConstant: -2.0, widthConstant: 120.0, heightConstant: 0.0)
        modePackageButton.anchor(topAnchor, left: nil, right: rightAnchor, bottom: bottomAnchor, topConstant: 2, leftConstant: 2, rightConstant: -2.0, bottomConstant: -2.0, widthConstant: 120.0, heightConstant: 0.0)
        modePackageView.anchorView = modePackageLabel
        modePackageView.direction = .bottom
        isDropDownShow = false
    }
    
    public func setHeaderTitleWithString(string: String) {
        // Name Label
        var attributes = [String: Any]()
        attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 15.0)
        attributes[NSForegroundColorAttributeName] = UIColor.blue
        let attString1 = NSAttributedString(string: string, attributes: attributes)
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        nameLabel.attributedText = finalAttString
        
    }
}
