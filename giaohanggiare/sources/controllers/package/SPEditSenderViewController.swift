//
//  SPEditSenderViewController.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 1/22/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

class SPEditSenderViewController: BaseViewController {
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Thong tin nguoi gui"
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
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
    
    var emailTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Email"
        tf.setBottomBorder()
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupView() {
        
        view.addSubview(titleLabel)
        
        view.addSubview(nameIconImageView)
        view.addSubview(phoneIconImageView)
        view.addSubview(emailIconImageView)
        view.addSubview(addressIconImageView)
        
        view.addSubview(nameTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(emailTextField)
        view.addSubview(addressTextField)
        
        
        titleLabel.anchor(view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 45.0)
        
        // Column 1
        nameIconImageView.anchor(titleLabel.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, topConstant: 20.0, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 25.0)
        phoneIconImageView.anchor(nameIconImageView.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, topConstant: 2.0, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 25.0)
        emailIconImageView.anchor(phoneIconImageView.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, topConstant: 2.0, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 25.0)
        addressIconImageView.anchor(emailIconImageView.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, topConstant: 2.0, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 25.0)
        
        
        // Column 2
        nameTextField.anchor(nameIconImageView.topAnchor, left: nameIconImageView.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        phoneNumberTextField.anchor(phoneIconImageView.topAnchor, left: phoneIconImageView.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        emailTextField.anchor(emailIconImageView.topAnchor, left: emailIconImageView.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        addressTextField.anchor(addressIconImageView.topAnchor, left: addressIconImageView.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
    }
}
