//
//  SPRegisterViewController.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 12/12/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

class SPRegisterViewController: BaseViewController {
    
    var topView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .mainColor
        return v
    }()
    
    var logoImageView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.backgroundColor = .gray
        return imgView
    }()
    
    
    var shopNameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Nhap ten cua hang"
        tf.text = ""
        return tf
    }()
    
    var addressTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Nhap dia chi"
        tf.text = ""
        return tf
    }()
    
    var userNameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Ten tai khoan"
        tf.text = ""
        return tf
    }()
    
    
    
    var passwordTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Nhap mat khau"
        tf.text = ""
        tf.isSecureTextEntry = true
        return tf
    }()
    
    var rePasswordTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Nhap lai mat khau"
        tf.isSecureTextEntry = true
        tf.text = ""
        return tf
    }()
    
    var emailTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Nhap email"
        tf.text = ""
        return tf
    }()
    
    var registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        button.setTitle("Dang ky", for: .normal)
        button.addTarget(self, action: #selector(registerButtonOnTouch), for: .touchUpInside)
        return button
    }()
    
    var backAndCancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        button.setTitle("Quay lai", for: .normal)
        button.addTarget(self, action: #selector(backAndCancelButtonOnTouch), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        
        
        view.addSubview(topView)
        view.addSubview(logoImageView)
        view.addSubview(shopNameTextField)
        view.addSubview(addressTextField)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(rePasswordTextField)
        view.addSubview(emailTextField)
        
        view.addSubview(registerButton)
        view.addSubview(backAndCancelButton)
        
        logoImageView.backgroundColor = .red
        
        topView.anchor(view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 100)
        topView.dropShadow(scale: true, rect: CGRect(x: 0, y: 0, width: view.frame.width, height: 100.0))
        
        logoImageView.anchor(topView.bottomAnchor, left: view.centerXAnchor, right:nil, bottom: nil, topConstant: -60.0, leftConstant: -60.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 120.0)
        
        shopNameTextField.anchor(topView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 65.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
        
        addressTextField.anchor(shopNameTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
        
        userNameTextField.anchor(addressTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
        
        passwordTextField.anchor(userNameTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
        
        rePasswordTextField.anchor(passwordTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
        
        emailTextField.anchor(rePasswordTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
        
        registerButton.anchor(emailTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 25.0, rightConstant: -25.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 45.0)
        
        backAndCancelButton.anchor(registerButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 25.0, rightConstant: -25.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 45.0)
        
    }
    
    func registerButtonOnTouch(sender: UIButton) {
        
    }
    
    func backAndCancelButtonOnTouch(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true, rect: CGRect) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        print("Size:\(rect)")
        self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
