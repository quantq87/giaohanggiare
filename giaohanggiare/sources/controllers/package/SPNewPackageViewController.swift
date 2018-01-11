//
//  SPNewPackageViewController.swift
//  giaohanggiare
//
//  Created by Quan Tran on 12/6/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

class SPNewPackageViewController: BaseViewController {
    
    var packageTableView:SPCollectionView!
    
    let cellId = "CollectionId"
    let personalCellId = "PersonalCollectionId"
    let personalReceiverCellId = "personalReceiverCellId"
    let personalHeaderId = "PersonalHeaderId"
    let personalFooterId = "PersonalFooterId"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func initView() {
        self.navigationItem.title = "Tao Don Hang"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .undo, target: self, action: #selector(backBarButtonOnTouch))
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        packageTableView = SPCollectionView(type:.create, frame:.zero, layout: flowLayout)
        packageTableView.register(SPCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        packageTableView.register(SPPersonalInfoCell.self, forCellWithReuseIdentifier: personalCellId)
        packageTableView.register(SPPersonalReceiverInfoCell.self, forCellWithReuseIdentifier: personalReceiverCellId)
        
        packageTableView.bounces = false
        packageTableView.alwaysBounceVertical = false
        
        packageTableView.register(SPPersonalHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: personalHeaderId)
        packageTableView.register(SPPersonalHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: personalFooterId)
        
        packageTableView.backgroundColor = .clear
        packageTableView.setDelegateAndDataSource(self, dataSource: self)
        view.addSubview(packageTableView);
        
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: packageTableView)
        view.addConstraintsWithFormat(format: "V:|-64-[v0]|", views: packageTableView)
    }
    
    
    func backBarButtonOnTouch(sender: UIBarButtonItem)  {
        print("backBarButtonOnTouch onclick")
        self.navigationController?.popViewController(animated: true)
    }
}

extension SPNewPackageViewController: SPCollectionViewDataSource, SPCollectionViewDelegate {
    
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
        return 4
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personalCellId, for: indexPath)
            cell.backgroundColor = .white
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personalReceiverCellId, for: indexPath)
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
            let header:SPPersonalHeaderCell = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: personalHeaderId, for: indexPath) as! SPPersonalHeaderCell)
            header.backgroundColor = .green
            if indexPath.section == 0 {
                header.setHeaderTitleWithString(string: "Thong tin khach hang")
            } else if (indexPath.section == 1) {
                header.setHeaderTitleWithString(string: "Thong tin don hang")
            } else {
                header.setHeaderTitleWithString(string: "")
            }
            return header
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
}

class SPPersonalInfoCell: SPCollectionViewCell {
    
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
        
        
        // Set Text Center
//        let paragraph = NSMutableParagraphStyle()
//        paragraph.alignment = .center
//        
//        let attributesAlign: [String : Any] = [NSParagraphStyleAttributeName: paragraph]
//        finalAttString.setAttributes(attributesAlign, range: NSRange(location: 0, length: finalAttString.string.characters.count))
        
        
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
    }
    
    func editInfoButtonOnTouch(sender: UIButton)  {
        print("editInfoButtonOnTouch onTouchInSide")
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
        
        
        // Set Text Center
        //        let paragraph = NSMutableParagraphStyle()
        //        paragraph.alignment = .center
        //
        //        let attributesAlign: [String : Any] = [NSParagraphStyleAttributeName: paragraph]
        //        finalAttString.setAttributes(attributesAlign, range: NSRange(location: 0, length: finalAttString.string.characters.count))
        
        
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
        let textField = UITextField(frame: .zero)
        
        return textField
    }()
    
    
    override func setupView() {
        
        addSubview(nameReceiverTextField)
        
        /*addSubview(nameLabel)
        addSubview(shopNameLabel)
        addSubview(phoneNumberLabel)
        addSubview(addressLabel)
        addSubview(editInfoButton)
        
        // Add Constraints
        nameLabel.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        shopNameLabel.anchor(nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        phoneNumberLabel.anchor(shopNameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        addressLabel.anchor(phoneNumberLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 60.0)
        
        editInfoButton.anchor(topAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 0.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 35.0, heightConstant: 25.0)*/
    }
    
    func editInfoButtonOnTouch(sender: UIButton)  {
        print("editInfoButtonOnTouch onTouchInSide")
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
