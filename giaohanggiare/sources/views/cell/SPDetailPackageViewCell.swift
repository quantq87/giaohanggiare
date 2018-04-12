//
//  SPDetailPackageViewCell.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 4/12/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

class SPDetailPackageViewCell: SPCollectionViewCell {
    var delegateInfo: SPPackageInfoDelegate!
    var indexSection: NSInteger = 0
    
    var receiverSubTitleLabel: UILabel =  {
        let label = UILabel(frame: .zero)
        label.text = "info_send_package_header".localized(withComment: "")
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor.rgb(r: 28, g: 157, b: 97)
        return label
    }()
    
    var phoneImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_phone"))
        return imageView
    }()
    
    var phoneTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "input_phone_placeholder".localized(withComment: "")
        tf.font = UIFont.systemFont(ofSize: 13.0)
        return tf
    }()
    
    var nameImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_user"))
        return imageView
    }()
    
    var phoneLineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gray
        return view
    }()
    
    var nameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "input_name_kh_placeholder".localized(withComment: "")
        tf.font = UIFont.systemFont(ofSize: 13.0)
        return tf
    }()
    
    var locationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_location"))
        return imageView
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "input_location_kh_placeholder".localized(withComment: "")
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    var locationButtonView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 2.0
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = .clear
        return view
    }()
    
    
    var addressImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_home"))
        return imageView
    }()
    
    var addressLineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gray
        return view
    }()
    
    var addressTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "input_addess_detail_placeholder".localized(withComment: "")
        tf.font = UIFont.systemFont(ofSize: 13.0)
        return tf
    }()
    
    
    var senderSubTitleLabel: UILabel =  {
        let label = UILabel(frame: .zero)
        label.text = "info_get_package_header".localized(withComment: "")
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor.rgb(r: 28, g: 157, b: 97)
        return label
    }()
    
    var addressSenderImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_location"))
        return imageView
    }()
    
    var addressSenderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "input_location_kh_placeholder".localized(withComment: "")
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    var addressSenderButtonView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 2.0
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = .clear
        return view
    }()
    
    
    var senderEstimateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "send_estimate_label".localized(withComment: "")
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    var senderEstimateDropDownButton: SPDropDownButton = {
        let dropDown = SPDropDownButton(frame: .zero)
        dropDown.setSelectedValueForCheckBox("ABC Selected")
        dropDown.setListItemsWithArray(NSArray(arrayLiteral: "Test abc 1", "Test abc 2", "Test abc 3", "Test abc 4", "Test abc 5", "Test abc 6"))
        dropDown.defaultIndexSelected = 5;
        dropDown.addTarget(self, action: #selector(senderEstimateDropDownOnTouch), for: .touchUpInside)
        return dropDown
    } ()
    
    var receiverEstimateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "get_estimate_label".localized(withComment: "")
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    var receiverEstimateDropDownButton: SPDropDownButton = {
        let dropDown = SPDropDownButton(frame: .zero)
        dropDown.setSelectedValueForCheckBox("ABC Selected")
        dropDown.setListItemsWithArray(NSArray(arrayLiteral: "Test abc 1", "Test abc 2", "Test abc 3", "Test abc 4", "Test abc 5", "Test abc 6"))
        dropDown.defaultIndexSelected = 5;
        dropDown.addTarget(self, action: #selector(receiverEstimateDropDownOnTouch), for: .touchUpInside)
        return dropDown
    } ()
    
    //    var nameLabel: UILabel = {
    //        var label = UILabel(frame: .zero)
    //        label.backgroundColor = .clear
    //        label.font = UIFont.systemFont(ofSize: 14.0)
    //        label.text = ""
    //        return label
    //    }()
    
    var nameLineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gray
        return view
    }()
    //
    //    var shopNameLabel: UILabel = {
    //        var label = UILabel(frame: .zero)
    //        label.backgroundColor = .clear
    //        label.font = UIFont.systemFont(ofSize: 14.0)
    //        label.text = ""
    //        return label
    //    }()
    //
    //    var addressLabel: UILabel = {
    //        var label = UILabel(frame: .zero)
    //        label.backgroundColor = .clear
    //        label.font = UIFont.systemFont(ofSize: 14.0)
    //        label.numberOfLines = 2
    //        label.text = ""
    //        return label
    //    }()
    //
    //    var phoneNumberLabel: UILabel = {
    //        var label = UILabel(frame: .zero)
    //        label.backgroundColor = .clear
    //        label.font = UIFont.systemFont(ofSize: 14.0)
    //        label.numberOfLines = 2
    //        label.text = ""
    //        return label
    //    }()
    //
    //    var editInfoButton: UIButton = {
    //        let button = UIButton(type: .custom)
    //
    //        button.setTitle("Edit", for: .normal)
    //        button.backgroundColor = .gray
    //        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
    //        return button
    //    }()
    
    override func setupView() {
        contentView.backgroundColor = UIColor.clear
        
        addSubview(receiverSubTitleLabel)
        
        addSubview(phoneImageView)
        addSubview(phoneTextField)
        addSubview(phoneLineView)
        
        addSubview(nameImageView)
        addSubview(nameTextField)
        addSubview(nameLineView)
        
        addSubview(locationButtonView)
        
        
        addSubview(addressImageView)
        addSubview(addressTextField)
        addSubview(addressLineView)
        
        addSubview(senderSubTitleLabel)
        addSubview(addressSenderButtonView)
        
        
        addSubview(senderEstimateLabel)
        addSubview(senderEstimateDropDownButton)
        
        addSubview(receiverEstimateLabel)
        addSubview(receiverEstimateDropDownButton)
        
        //        addSubview(nameLabel)
        //        addSubview(shopNameLabel)
        //        addSubview(phoneNumberLabel)
        //        addSubview(addressLabel)
        //        addSubview(editInfoButton)
        
        receiverSubTitleLabel.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 3.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 20.0)
        
        phoneImageView.anchor(receiverSubTitleLabel.bottomAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: 3.5, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        
        phoneTextField.anchor(receiverSubTitleLabel.bottomAnchor, left: phoneImageView.rightAnchor , right: rightAnchor, bottom: nil, topConstant: 1.0, leftConstant: 1.0, rightConstant: -3.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        phoneLineView.anchor(phoneTextField.bottomAnchor, left: phoneImageView.rightAnchor , right: phoneTextField.rightAnchor, bottom: nil, topConstant: -1.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 1.0)
        
        nameImageView.anchor(phoneTextField.bottomAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: 3.5 + 5.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        
        nameTextField.anchor(phoneTextField.bottomAnchor, left: nameImageView.rightAnchor , right: rightAnchor, bottom: nil, topConstant: 1.0 + 5.0, leftConstant: 1.0, rightConstant: -3.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        nameLineView.anchor(nameTextField.bottomAnchor, left: nameImageView.rightAnchor , right: nameTextField.rightAnchor, bottom: nil, topConstant: -1.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 1.0)
        
        locationButtonView.anchor(nameTextField.bottomAnchor, left: leftAnchor , right: rightAnchor, bottom: nil, topConstant: 1.0 + 5.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        locationButtonView.addSubview(locationImageView)
        locationButtonView.addSubview(locationLabel)
        
        locationImageView.anchor(locationButtonView.centerYAnchor, left: locationButtonView.leftAnchor, right: nil, bottom: nil, topConstant: -10.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        locationLabel.anchor(locationImageView.topAnchor, left: locationImageView.rightAnchor, right: locationButtonView.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 20.0)
        
        
        addressImageView.anchor(locationImageView.bottomAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: 3.5 + 5.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        
        addressTextField.anchor(locationImageView.bottomAnchor, left: addressImageView.rightAnchor , right: rightAnchor, bottom: nil, topConstant: 1.0 + 5.0, leftConstant: 1.0, rightConstant: -3.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        addressLineView.anchor(addressTextField.bottomAnchor, left: addressImageView.rightAnchor , right: addressTextField.rightAnchor, bottom: nil, topConstant: -1.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 1.0)
        
        senderSubTitleLabel.anchor(addressTextField.bottomAnchor, left: leftAnchor , right: rightAnchor, bottom: nil, topConstant: 1.0 + 5.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        addressSenderButtonView.anchor(senderSubTitleLabel.bottomAnchor, left: leftAnchor , right: rightAnchor, bottom: nil, topConstant: 1.0 + 5.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        addressSenderButtonView.addSubview(addressSenderLabel)
        addressSenderButtonView.addSubview(addressSenderImageView)
        
        addressSenderImageView.anchor(addressSenderButtonView.centerYAnchor, left: addressSenderButtonView.leftAnchor, right: nil, bottom: nil, topConstant: -10.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        addressSenderLabel.anchor(addressSenderButtonView.topAnchor, left: addressSenderImageView.rightAnchor, right: addressSenderButtonView.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 20.0)
        
        senderEstimateDropDownButton.anchor(addressSenderButtonView.bottomAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 25.0)
        senderEstimateLabel.anchor(addressSenderButtonView.bottomAnchor, left: nil, right: senderEstimateDropDownButton.leftAnchor, bottom: nil, topConstant: 5.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 20.0)
        
        
        receiverEstimateDropDownButton.anchor(senderEstimateDropDownButton.bottomAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 25.0)
        receiverEstimateLabel.anchor(senderEstimateDropDownButton.bottomAnchor, left: nil, right: receiverEstimateDropDownButton.leftAnchor, bottom: nil, topConstant: 5.0, leftConstant: 1.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 20.0)
        
        // Add Constraints
        //        nameLabel.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        //        shopNameLabel.anchor(nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        //        phoneNumberLabel.anchor(shopNameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
        //        addressLabel.anchor(phoneNumberLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 60.0)
        //
        //        editInfoButton.anchor(topAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 0.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 35.0, heightConstant: 25.0)
        //        editInfoButton.addTarget(self, action: #selector(editInfoButtonOnTouch), for: .touchUpInside)
    }
    
    @objc func senderEstimateDropDownOnTouch() {
        
    }
    @objc func receiverEstimateDropDownOnTouch() {
        
    }
    
    
    func setDataForCell(_ customerInfo: SPCustomerInfoItem?) {
        //        if let info = customerInfo {
        //            nameLabel.attributedText = formatTitleBoldAndValueNormal(info.getRefixNameCustomerInfo(), value: info.fullName)
        //            shopNameLabel.attributedText = formatTitleBoldAndValueNormal("name_customer_subtitle".localized(withComment: "with !!!"), value: info.shopName)
        //
        //            phoneNumberLabel.attributedText = formatTitleBoldAndValueNormal("So dien thoai: ", value: info.phone)
        //
        //            addressLabel.attributedText = formatTitleBoldAndValueNormal("Dia chi: ", value: info.address)
        //        }
    }
    
    func formatCustomerName(_ refix: String, firstName: String, lastName: String) -> NSMutableAttributedString {
        // Name Label
        let fullName = lastName + " " + firstName
        let finalAttString = formatTitleBoldAndValueNormal(refix, value: fullName)
        return finalAttString
    }
    
    func formatTitleBoldAndValueNormal(_ title: String, value: String) -> NSMutableAttributedString {
        // Name Label
        var attributes = [NSAttributedStringKey: Any]()
        attributes[NSAttributedStringKey.font] = UIFont.boldSystemFont(ofSize: 14.0)
        attributes[NSAttributedStringKey.foregroundColor] = UIColor.black
        let attString1 = NSAttributedString(string: title, attributes: attributes)
        
        attributes[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 13.0)
        attributes[NSAttributedStringKey.foregroundColor] = UIColor.black
        let attString2 = NSAttributedString(string: value, attributes: attributes)
        
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        finalAttString.append(attString2)
        
        return finalAttString
        
    }
    
    @objc func editInfoButtonOnTouch(sender: UIButton)  {
        print("editInfoButtonOnTouch onTouchInSide")
        if let delegate = self.delegateInfo {
            delegate.editButtonOnTouchInside(sender: sender, atSection: self.indexSection)
        }
    }
}
