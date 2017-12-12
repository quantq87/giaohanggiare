//
//  SPLoginViewController.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 12/12/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit


class SPLoginViewController: BaseViewController {
    
    var titleFormLoginLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.text = "Dang nhap"
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        return label
    }()
    
    
    var formLoginView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 0.7)
        v.layer.borderWidth = 1;
        v.layer.cornerRadius = 5.0
        v.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.7).cgColor
        return v
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
        tf.placeholder = "Mat khau"
        tf.text = ""
        return tf
    }()
    
    var signButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(red: 0.0, green: 0.50, blue: 1.0, alpha: 0.7)
        button.setTitle("Dang nhap", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    var registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(red: 0.0, green: 0.50, blue: 1.0, alpha: 0.7)
        button.setTitle("Tao tai khoan", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    var quickRegisterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(red: 0.0, green: 0.50, blue: 1.0, alpha: 0.7)
        button.setTitle("Dang ky nhanh", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(quickRegisterButtonOnTouch), for: .touchUpInside)
        return button
    }()
    
    
    var versionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.text = "Version 0.0.1"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var companyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.text = "Cong ty co phan GiaoHangGiaRe"
        label.textAlignment = .center
        label.textColor = .white
        return label
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
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .mainColor
        
        
        view.addSubview(formLoginView)
        view.addSubview(versionLabel)
        view.addSubview(companyLabel)
        
        
        let height:CGFloat = 350.0
        let top:CGFloat = (view.frame.size.height - height)/2
        let paddingLeftRight:CGFloat = 45.0
        formLoginView.anchor(view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil,
                             topConstant: top, leftConstant: paddingLeftRight, rightConstant: -paddingLeftRight, bottomConstant: 0.0,
                             widthConstant: 0.0, heightConstant: height)
        versionLabel.anchor(nil, left: view.leftAnchor, right: view.rightAnchor, bottom: companyLabel.topAnchor,
                            topConstant: 0.0, leftConstant: paddingLeftRight, rightConstant: -paddingLeftRight, bottomConstant: -3.0,
                            widthConstant: 0.0, heightConstant: 35.0)
        companyLabel.anchor(nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor,
                            topConstant: 0.0, leftConstant: paddingLeftRight, rightConstant: -paddingLeftRight, bottomConstant: -45.0,
                            widthConstant: 0.0, heightConstant: 35.0)
        
        
        formLoginView.addSubview(titleFormLoginLabel)
        formLoginView.addSubview(userNameTextField)
        formLoginView.addSubview(passwordTextField)
        formLoginView.addSubview(signButton)
        formLoginView.addSubview(registerButton)
        formLoginView.addSubview(quickRegisterButton)
        
        
        titleFormLoginLabel.anchor(formLoginView.topAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
                                   topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
                                   widthConstant: 0.0, heightConstant: 35.0)
        
        userNameTextField.anchor(titleFormLoginLabel.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
                             topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
                             widthConstant: 0.0, heightConstant: 35.0)
        
        passwordTextField.anchor(userNameTextField.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
                                 topConstant: 5.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
                                 widthConstant: 0.0, heightConstant: 35.0)
        
        signButton.anchor(passwordTextField.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
                                           topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
                                           widthConstant: 0.0, heightConstant: 40.0)
        
        registerButton.anchor(signButton.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
                          topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
                          widthConstant: 0.0, heightConstant: 40.0)
        
        quickRegisterButton.anchor(registerButton.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
                                   topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
                                   widthConstant: 0.0, heightConstant: 40.0)
        
        
    }
    
    func quickRegisterButtonOnTouch(sender: UIButton) {
        performSegue(withIdentifier: "showRegisterIdentifier", sender: nil)
    }
}
