//
//  SPEditSenderViewController.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 1/22/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

protocol SPEditSenderDelegate {
    func didCancelEditInfo()
    func didDoneEditInfo(_ changeInfo: Bool, customerIsChange: SPCustomerInfoItem)
}

class SPEditSenderViewController: BaseViewController {
    
    var customerInfo: SPCustomerInfoItem!
    var delegate:SPEditSenderDelegate!
    var name:String! = ""
    var phone:String! = ""
    var shopName:String! = ""
    var address:String! = ""
    
    var matterView: UIView = {
        let viewM = UIView(frame: .zero)
        viewM.backgroundColor = .white
        viewM.layer.cornerRadius = 3.0
        viewM.layer.borderWidth = 0.5
        viewM.layer.borderColor = UIColor.gray.cgColor
        viewM.clipsToBounds = true
        return viewM
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Thong tin nguoi gui"
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.textAlignment = .left
        return label
    }()
    
    var nameIconImageView:UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .green
        return imageView
    }()
    
    var phoneIconImageView:UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .green
        return imageView
    }()
    
    var emailIconImageView:UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .green
        return imageView
    }()
    
    var addressIconImageView:UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .green
        return imageView
    }()
    
    
    var nameTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Ten nguoi gui"
        tf.setBottomBorder()
        return tf
    }()
    
    var phoneNumberTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "So dien thoai"
        tf.setBottomBorder()
        return tf
    }()
    
    var addressTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Dia chi"
        tf.setBottomBorder()
        return tf
    }()
    
    var shopNameTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Ten shop"
        tf.setBottomBorder()
        return tf
    }()
    
    var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Hoan thanh", for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.addTarget(self, action: #selector(SPEditSenderViewController.doneDidTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    var cancalButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.addTarget(self, action: #selector(SPEditSenderViewController.cancelDidTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SPEditSenderViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SPEditSenderViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    
    func setupView() {
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        view.addSubview(matterView)
        
        matterView.addSubview(doneButton)
        matterView.addSubview(cancalButton)

        matterView.addSubview(titleLabel)

        matterView.addSubview(nameIconImageView)
        matterView.addSubview(phoneIconImageView)
        matterView.addSubview(emailIconImageView)
        matterView.addSubview(addressIconImageView)

        matterView.addSubview(nameTextField)
        matterView.addSubview(phoneNumberTextField)
        matterView.addSubview(shopNameTextField)
        matterView.addSubview(addressTextField)
        
        matterView.anchor(view.centerYAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.centerYAnchor, topConstant: -125.0, leftConstant: 10, rightConstant: -10, bottomConstant: 125.0, widthConstant: 0.0, heightConstant: 0.0)
        
        titleLabel.anchor(matterView.topAnchor, left: matterView.leftAnchor, right: matterView.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 5.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 45.0)

        // Column 1
        nameIconImageView.anchor(titleLabel.bottomAnchor, left: matterView.leftAnchor, right: nil, bottom: nil, topConstant: 20.0, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 25.0)
        phoneIconImageView.anchor(nameIconImageView.bottomAnchor, left: matterView.leftAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 25.0)
        emailIconImageView.anchor(phoneIconImageView.bottomAnchor, left: matterView.leftAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 25.0)
        addressIconImageView.anchor(emailIconImageView.bottomAnchor, left: matterView.leftAnchor, right: nil, bottom: nil, topConstant: 3.0, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 25.0)


        // Column 2
        nameTextField.anchor(nameIconImageView.topAnchor, left: nameIconImageView.rightAnchor, right: matterView.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)

        phoneNumberTextField.anchor(phoneIconImageView.topAnchor, left: phoneIconImageView.rightAnchor, right: matterView.rightAnchor, bottom: nil, topConstant: 2.5, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)

        shopNameTextField.anchor(emailIconImageView.topAnchor, left: emailIconImageView.rightAnchor, right: matterView.rightAnchor, bottom: nil, topConstant: 2.5, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)

        addressTextField.anchor(addressIconImageView.topAnchor, left: addressIconImageView.rightAnchor, right: matterView.rightAnchor, bottom: nil, topConstant: 2.5, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        cancalButton.anchor(matterView.topAnchor, left: nil, right: matterView.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 65.0, heightConstant: 45.0)
        
        doneButton.anchor(nil, left: matterView.leftAnchor, right: matterView.rightAnchor, bottom: matterView.bottomAnchor, topConstant: 2.0, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 45.0)
        
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        shopNameTextField.delegate = self
        addressTextField.delegate = self
    }
    
    func setupData() {
        if customerInfo != nil {
            nameTextField.text = customerInfo.fullName
            phoneNumberTextField.text = customerInfo.phone
            shopNameTextField.text = customerInfo.email
            addressTextField.text = customerInfo.address
        }
    }
    
    func addTapGestureRecognizer() {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height - 150
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
//        }
    }
    
    @objc func doneDidTouchUpInside() {
        nameTextField.resignFirstResponder()
        shopNameTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        
        if !name.isEmpty {
            self.customerInfo.firstName = name
        }
        if !phone.isEmpty {
            self.customerInfo.phone = phone
        }
        if !shopName.isEmpty {
            self.customerInfo.shopName = shopName
        }
        if !address.isEmpty {
            self.customerInfo.address = address
        }
        if let hasDelegate = self.delegate {
            hasDelegate.didDoneEditInfo(true, customerIsChange:self.customerInfo)
        }
    }
    
    @objc func cancelDidTouchUpInside() {
        if let hasDelegate = self.delegate {
            hasDelegate.didCancelEditInfo()
        }
    }
}

// UITextFieldDelegate
extension SPEditSenderViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            if let string = textField.text {
                name = string
            }
            break
        case phoneNumberTextField:
            if let string = textField.text {
                phone = string
            }
            break
        case addressTextField:
            if let string = textField.text {
                address = string
            }
            break
        case shopNameTextField:
            if let string = textField.text {
                shopName = string
            }
            break
        default:
            break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
