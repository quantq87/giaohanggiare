//
//  SPLoginViewController.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 12/12/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit



class SPLoginViewController: BaseViewController {
    
    var loadingView: SPLoadingView!
    
    var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        
        return imageView
    }()
    
    var containerTextFieldStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        return stackView
    }()
    
    var containerButtonStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        return stackView
    }()
    
    var containerButton2StackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        return stackView
    }()
    
    var bottomStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        return stackView
    }()
    
    
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
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.placeholder = "Ten tai khoan"
        tf.text = ""
        return tf
    }()
    
    var passwordTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.placeholder = "Mat khau"
        tf.text = ""
        tf.isSecureTextEntry = true
        return tf
    }()
    
    var signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor.activeButtonBackgroundColor
        button.setTitle("Dang nhap", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(signInButtonOnTouch), for: .touchUpInside)
        return button
    }()
    
    var registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = .clear
        button.setTitle("Tao tai khoan", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.addTarget(self, action: #selector(registerButtonOnTouch), for: .touchUpInside)
        button.titleLabel?.textColor = .white
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    var quickRegisterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(red: 0.0, green: 0.50, blue: 1.0, alpha: 0.7)
        button.setTitle("Dang ky nhanh", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(quickRegisterButtonOnTouch), for: .touchUpInside)
        return button
    }()
    
    var forgetPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = .clear
        button.setTitle("Quen mat khau", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.contentHorizontalAlignment = .left
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
        setupView()
        initData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopLoadingView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .mainColor
        
        view.addSubview(logoImageView)
        view.addSubview(containerTextFieldStackView)
        view.addSubview(bottomStackView)
        view.addSubview(containerButtonStackView)
        
        if #available(iOS 11.0, *) {
            logoImageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.centerXAnchor, right: nil, bottom: nil, topConstant: 10.0, leftConstant: -(230.0/2), rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 230.0, heightConstant: 74.0)
            
            bottomStackView.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: -5.0, widthConstant: 0.0, heightConstant: 55.0)
            containerTextFieldStackView.anchor(logoImageView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: nil, topConstant: 25.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 75.0)
            
        } else {
            // Fallback on earlier versions
            let paddingTop:CGFloat = 64
            logoImageView.anchor(view.topAnchor, left: view.centerXAnchor, right: nil, bottom: nil, topConstant: paddingTop, leftConstant: -(230.0/2), rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 230.0, heightConstant: 74.0)
            bottomStackView.anchor(nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: -5.0, widthConstant: 0.0, heightConstant: 55.0)
            containerTextFieldStackView.anchor(logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 25.0, leftConstant: 10.0, rightConstant: -10.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 75.0)
        }
        
        containerTextFieldStackView.addArrangedSubview(userNameTextField)
        containerTextFieldStackView.addArrangedSubview(passwordTextField)
        
        containerButtonStackView.anchor(containerTextFieldStackView.bottomAnchor, left: containerTextFieldStackView.leftAnchor, right: containerTextFieldStackView.rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 75.0)
        
        containerButtonStackView.addArrangedSubview(signInButton)
        containerButtonStackView.addArrangedSubview(containerButton2StackView)
        
        containerButton2StackView.addArrangedSubview(forgetPasswordButton)
        containerButton2StackView.addArrangedSubview(registerButton)
        
        bottomStackView.addArrangedSubview(versionLabel)
        bottomStackView.addArrangedSubview(companyLabel)
        
//        view.addSubview(formLoginView)
//        view.addSubview(versionLabel)
//        view.addSubview(companyLabel)
//
//
//        let height:CGFloat = 300.0
//        let top:CGFloat = (view.frame.size.height - height)/2
//        let paddingLeftRight:CGFloat = 45.0
//        formLoginView.anchor(view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil,
//                             topConstant: top, leftConstant: paddingLeftRight, rightConstant: -paddingLeftRight, bottomConstant: 0.0,
//                             widthConstant: 0.0, heightConstant: height)
//        versionLabel.anchor(nil, left: view.leftAnchor, right: view.rightAnchor, bottom: companyLabel.topAnchor,
//                            topConstant: 0.0, leftConstant: paddingLeftRight, rightConstant: -paddingLeftRight, bottomConstant: -3.0,
//                            widthConstant: 0.0, heightConstant: 35.0)
//        companyLabel.anchor(nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor,
//                            topConstant: 0.0, leftConstant: paddingLeftRight, rightConstant: -paddingLeftRight, bottomConstant: -45.0,
//                            widthConstant: 0.0, heightConstant: 35.0)
//
//
//        formLoginView.addSubview(titleFormLoginLabel)
//        formLoginView.addSubview(userNameTextField)
//        formLoginView.addSubview(passwordTextField)
//        formLoginView.addSubview(signInButton)
//        formLoginView.addSubview(registerButton)
//        formLoginView.addSubview(quickRegisterButton)
//
//
//        titleFormLoginLabel.anchor(formLoginView.topAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
//                                   topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
//                                   widthConstant: 0.0, heightConstant: 35.0)
//
//        userNameTextField.anchor(titleFormLoginLabel.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
//                             topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
//                             widthConstant: 0.0, heightConstant: 35.0)
//
//        passwordTextField.anchor(userNameTextField.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
//                                 topConstant: 5.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
//                                 widthConstant: 0.0, heightConstant: 35.0)
//
//        signInButton.anchor(passwordTextField.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
//                                           topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
//                                           widthConstant: 0.0, heightConstant: 40.0)
//
//        registerButton.anchor(signInButton.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
//                          topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
//                          widthConstant: 0.0, heightConstant: 40.0)
//
//        quickRegisterButton.anchor(registerButton.bottomAnchor, left: formLoginView.leftAnchor, right: formLoginView.rightAnchor, bottom: nil,
//                                   topConstant: 10.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0,
//                                   widthConstant: 0.0, heightConstant: 40.0)
    }
    
    func initData()  {
        autoCheckAutoLogin()
    }
    
    func autoCheckAutoLogin() {
        startLoadingView()
        SPLoadingView.shareInstance.startLoadingAnimation(self.view)
        var emailString = "Quantq@gmail.com"
        emailString = emailString.lowercased()
        
        SPUserViewModel.shareInstance.signInWithInfo(emailString, password: "1234") { (success, message) in
            print("LOGIN: \(message)")
            if success {
                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "showSPHomeIdentifier", sender: nil)
                    SPApplicationControl.shareInstance.showLoginVCToMainTabBar(animation: true)
                }
            }
            SPLoadingView.shareInstance.stopLoadingAnimation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func startLoadingView() {
//        if loadingView == nil {
//            loadingView = SPLoadingView(frame: .zero, type: 2)
//        }
//        view.addSubview(loadingView)
//        loadingView.anchor(view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor,
//                           topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0,
//                           widthConstant: 0.0, heightConstant: 0.0)
//        loadingView.startLoadingAnimation()
    }
    
    func stopLoadingView() {
//        DispatchQueue.main.async {
//        if self.loadingView != nil {
//            self.loadingView.stopLoadingAnimation()
//        }
//        self.loadingView.removeFromSuperview()
//        }
    }
    
    @objc func quickRegisterButtonOnTouch(sender: UIButton) {
        
    }
    
    @objc func signInButtonOnTouch() {
//        performSegue(withIdentifier: "showSPHomeIdentifier", sender: nil)
        SPApplicationControl.shareInstance.showLoginVCToMainTabBar(animation: true)
    }
    
    @objc func registerButtonOnTouch() {
        performSegue(withIdentifier: "showRegisterIdentifier", sender: nil)
    }
}
