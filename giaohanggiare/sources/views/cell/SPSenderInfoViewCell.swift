//
//  SPSenderInfoViewCell.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 3/13/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

protocol SPPackageInfoDelegate {
    func editButtonOnTouchInside(sender: UIButton, atSection: NSInteger)
}

class SPPersonalInfoCell: SPCollectionViewCell {
    var delegateInfo: SPPackageInfoDelegate!
    var indexSection: NSInteger = 0
    
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
    
    func setDataForCell(_ customerInfo: SPCustomerInfoItem!) {
        if let info = customerInfo {
            nameLabel.attributedText = formatTitleBoldAndValueNormal(info.getRefixNameCustomerInfo(), value: info.fullName)
            shopNameLabel.attributedText = formatTitleBoldAndValueNormal("Ten Shop: ", value: info.shopName)
        
            phoneNumberLabel.attributedText = formatTitleBoldAndValueNormal("So dien thoai: ", value: info.phone)
        
            addressLabel.attributedText = formatTitleBoldAndValueNormal("Dia chi: ", value: info.address)
        }
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
            delegate.editButtonOnTouchInside(sender: sender, atSection: self.indexSection)
        }
    }
}
