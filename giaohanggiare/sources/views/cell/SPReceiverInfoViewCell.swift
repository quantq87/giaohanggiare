//
//  SPReceiverInfoViewCell.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 3/13/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

//protocol SPReceiverInfoViewCellDelegate {
//    //func editButtonOnTouchInside(sender: UIButton)
//    func selectedAtIndexTextField(point: CGPoint, atSection: NSInteger)
//}
//
//class SPPersonalReceiverInfoCell: SPCollectionViewCell {
//    var indexSection: NSInteger = 0
//    var delegateCell: SPReceiverInfoViewCellDelegate!
//    
//    var editInfoButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.addTarget(self, action: #selector(editInfoButtonOnTouch), for: .touchUpInside)
//        button.setTitle("Edit", for: .normal)
//        button.backgroundColor = .gray
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
//        return button
//    }()
//    
//    
//    var nameReceiverTextField:UITextField = {
//        let tf = UITextField(frame: .zero)
//        tf.placeholder = "Ten nguoi nhan"
//        tf.setBottomBorder()
//        return tf
//    }()
//    
//    var phoneNumberReceiverTextField:UITextField = {
//        let tf = UITextField(frame: .zero)
//        tf.placeholder = "So dien thoai"
//        tf.setBottomBorder()
//        return tf
//    }()
//    
//    var addressReceiverTextField:UITextField = {
//        let tf = UITextField(frame: .zero)
//        tf.placeholder = "Dia chi"
//        tf.setBottomBorder()
//        return tf
//    }()
//    
//    var noteReceiverTextField:UITextField = {
//        let tf = UITextField(frame: .zero)
//        tf.placeholder = "Ghi chu"
//        tf.setBottomBorder()
//        return tf
//    }()
//    override func setupView() {
//        
//        addSubview(nameReceiverTextField)
//        addSubview(phoneNumberReceiverTextField)
//        addSubview(addressReceiverTextField)
//        addSubview(noteReceiverTextField)
//        
//        // Add Constraints
//        nameReceiverTextField.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
//        phoneNumberReceiverTextField.anchor(nameReceiverTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
//        addressReceiverTextField.anchor(phoneNumberReceiverTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
//        
//        addressReceiverTextField.setRightImageView(image: UIImage(named: "location-icon")!, size: CGSize(width: 15.0, height: 15.0))
//        
//        noteReceiverTextField.anchor(addressReceiverTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: -2, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
//        
//        nameReceiverTextField.delegate = self
//    }
//    
//    func editInfoButtonOnTouch(sender: UIButton)  {
//        print("editInfoButtonOnTouch onTouchInSide")
//        
//    }
//}
//
//extension SPPersonalReceiverInfoCell: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == self.nameReceiverTextField{
//            if let delegate = self.delegateCell {
//                delegate.selectedAtIndexTextField(point: CGPoint(x:0, y:0), atSection: indexSection)
//            }
//        }
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}

