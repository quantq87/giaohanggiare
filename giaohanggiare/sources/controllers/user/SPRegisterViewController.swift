//
//  SPRegisterViewController.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 12/12/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

enum SPStepRegister {
    case one
    case two
    case done
}

let heightForContainerStepOne:CGFloat = 200.0
let heightForContainerStepTwo:CGFloat = 120.0

class SPRegisterViewController: BaseViewController, UITextFieldDelegate {
    
    var currentStepRegister: SPStepRegister = .one
    
    var contentSizeWidth: CGFloat = 0.0
    
    var keyboardOnShow:Bool = false
    var activeField: UITextField!
    var currentUserInfo = SPCustomerInfoItem(.sender)
    var currentErrorMessage: String = ""
    
    
    
    var topView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .mainColor
        return v
    }()
    
    var logoImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "logo_icon"))
        imgView.backgroundColor = .white
        return imgView
    }()
    
    var mainContainerView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    
    var containerTextFieldStepOneStackView:UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        stackView.isHidden = true
        return stackView
    }()
    
    var containerTextFieldStepTwoStackView:UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        stackView.isHidden = true
        return stackView
    }()
    
    var shopNameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Nhap ten cua hang"
        tf.text = ""
        tf.spellCheckingType = .no
        tf.autocorrectionType = .no
        return tf
    }()
    
    var phoneTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Số điện thoại"
        tf.text = ""
        tf.spellCheckingType = .no
        tf.autocorrectionType = .no
        return tf
    }()
    
    var emailTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Nhap email"
        tf.text = ""
        tf.spellCheckingType = .no
        tf.autocorrectionType = .no
        tf.keyboardType = UIKeyboardType.emailAddress
        return tf
    }()
    
    var addressTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Số nhà, hẻm, ngõ, ngách, toà nhà"
        tf.text = ""
        tf.spellCheckingType = .no
        tf.autocorrectionType = .no
        return tf
    }()
    
    var cityTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Chọn tỉnh/thành phố, quận/huyện, phường/xã"
        tf.text = ""
        tf.spellCheckingType = .no
        tf.autocorrectionType = .no
        return tf
    }()
    
    var userNameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Ten tai khoan"
        tf.text = ""
        tf.spellCheckingType = .no
        tf.autocorrectionType = .no
        return tf
    }()
    
    var passwordTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Nhap mat khau"
        tf.text = ""
        tf.isSecureTextEntry = true
        tf.spellCheckingType = .no
        tf.autocorrectionType = .no
        return tf
    }()
    
    var rePasswordTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Nhap lai mat khau"
        tf.isSecureTextEntry = true
        tf.text = ""
        tf.spellCheckingType = .no
        tf.autocorrectionType = .no
        return tf
    }()
    
    var registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.activeButtonBackgroundColor
        button.setTitle("Dang ky", for: .normal)
        button.addTarget(self, action: #selector(registerButtonOnTouch), for: .touchUpInside)
        return button
    }()
    
    var backLogoImage:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "button_back"))
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    
    var backAndCancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.cancelButtonBackgroundColor
        button.setTitle("Quay lai", for: .normal)
        button.addTarget(self, action: #selector(backAndCancelButtonOnTouch), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SPEditSenderViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SPEditSenderViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        addGestureForViewEdit()
        setupView()
        progressSetupViewWithStep()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
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
        
        view.addSubview(topView)
        view.addSubview(logoImageView)
        view.addSubview(mainContainerView)
        
        mainContainerView.addSubview(containerTextFieldStepOneStackView)
        mainContainerView.addSubview(containerTextFieldStepTwoStackView)
        view.addSubview(registerButton)
        view.addSubview(backAndCancelButton)
        view.addSubview(backLogoImage)
//        view.addSubview(shopNameTextField)
//        view.addSubview(addressTextField)
//        view.addSubview(userNameTextField)
//        view.addSubview(passwordTextField)
//        view.addSubview(rePasswordTextField)
//        view.addSubview(emailTextField)
//
//        view.addSubview(registerButton)
//        view.addSubview(backAndCancelButton)
        
        if #available(iOS 11.0, *) {
            topView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 90.0)
        } else {
            // Fallback on earlier versions
            topView.anchor(view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 90.0)
        }
        topView.dropShadow(scale: true, rect: CGRect(x: 0, y: 0, width: view.frame.width, height: 95.0))
        
        logoImageView.anchor(topView.bottomAnchor, left: view.centerXAnchor, right:nil, bottom: nil, topConstant: -70.0, leftConstant: -60.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 120.0)
        logoImageView.layer.cornerRadius = 150.0/2.5;
        logoImageView.dropShadow(color: .gray, opacity: 1.0, offSet: CGSize(width: 125.0, height: 125.0), radius: 150.0/2.5, scale: true)
        
        if #available(iOS 11.0, *) {
            mainContainerView.anchor(logoImageView.bottomAnchor, left: topView.leftAnchor, right: topView.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, topConstant: 10.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: -95.0, widthConstant: 0.0, heightConstant: 0.0)
            
            registerButton.anchor(view.safeAreaLayoutGuide.bottomAnchor, left: view.centerXAnchor, right: nil, bottom: nil, topConstant: -95.0, leftConstant: -(200.0/2.0), rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 200.0, heightConstant: 35.0)
        } else {
            // Fallback on earlier versions
            mainContainerView.anchor(logoImageView.bottomAnchor, left: topView.leftAnchor, right: topView.rightAnchor, bottom: view.bottomAnchor, topConstant: 15.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: -95.0, widthConstant: 0.0, heightConstant: 0.0)
            
            registerButton.anchor(view.bottomAnchor, left: view.centerXAnchor, right: nil, bottom: nil, topConstant: -95.0, leftConstant: -(200.0/2.0), rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 200.0, heightConstant: 35.0)
        }
        mainContainerView.layoutIfNeeded()
        
        containerTextFieldStepOneStackView.anchor(mainContainerView.topAnchor, left: topView.leftAnchor, right: topView.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 20.0, rightConstant: -20.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: heightForContainerStepOne)
        
        containerTextFieldStepOneStackView.addArrangedSubview(shopNameTextField)
        containerTextFieldStepOneStackView.addArrangedSubview(phoneTextField)
        containerTextFieldStepOneStackView.addArrangedSubview(emailTextField)
        containerTextFieldStepOneStackView.addArrangedSubview(addressTextField)
        containerTextFieldStepOneStackView.addArrangedSubview(cityTextField)
        
        containerTextFieldStepTwoStackView.addArrangedSubview(userNameTextField)
        containerTextFieldStepTwoStackView.addArrangedSubview(passwordTextField)
        containerTextFieldStepTwoStackView.addArrangedSubview(rePasswordTextField)
        
        containerTextFieldStepTwoStackView.anchor(mainContainerView.topAnchor, left: topView.leftAnchor, right: topView.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 20.0, rightConstant: -20.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: heightForContainerStepTwo)
        
        //containerTextFieldStepOneStackView.addArrangedSubview(userNameTextField)
        //containerTextFieldStepOneStackView.addArrangedSubview(passwordTextField)
        //containerTextFieldStepOneStackView.addArrangedSubview(rePasswordTextField)
        
        backAndCancelButton.anchor(registerButton.bottomAnchor, left: view.centerXAnchor, right: nil, bottom: nil, topConstant: 15.0, leftConstant: -(100.0/2.0), rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 100.0, heightConstant: 25.0)
        backLogoImage.anchor(backAndCancelButton.topAnchor, left:nil, right: backAndCancelButton.leftAnchor, bottom: nil, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 28.0, heightConstant: 25.0)
        
        contentSizeWidth = view.frame.width - 60;
        mainContainerView.contentSize = CGSize(width: contentSizeWidth, height: heightForContainerStepOne)
        
//        shopNameTextField.anchor(topView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 65.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
//
//        addressTextField.anchor(shopNameTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
//
//        userNameTextField.anchor(addressTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
//
//        passwordTextField.anchor(userNameTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
//
//        rePasswordTextField.anchor(passwordTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
//
//        emailTextField.anchor(rePasswordTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 2.0, leftConstant: 15.0, rightConstant: -15.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 35.0)
//
//        registerButton.anchor(emailTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 25.0, rightConstant: -25.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 45.0)
//
//        backAndCancelButton.anchor(registerButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 5.0, leftConstant: 25.0, rightConstant: -25.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 45.0)
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        keyboardOnShow = true
        
        self.mainContainerView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.mainContainerView.contentInset = contentInsets
        self.mainContainerView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.mainContainerView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardOnShow = false
        
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.mainContainerView.contentInset = contentInsets
        self.mainContainerView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.mainContainerView.isScrollEnabled = false
    }
    
    func addGestureForViewEdit() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnView)))
    }
    
    @objc func tapOnView() {
        if keyboardOnShow {
            keyboardOnShow = true
            view.endEditing(true)
        }
    }
    
    @objc func registerButtonOnTouch(sender: UIButton) {
        switch currentStepRegister {
        case .one:
            if isValidateStepOne() {
                currentStepRegister = .two
                progressSetupViewWithStep()
            } else {
                print("\(currentErrorMessage)")
            }
            break
        case .two:
            if isValidateStepTwo() {
                currentStepRegister = .done
                progressSetupViewWithStep()
            } else {
                print("\(currentErrorMessage)")
            }
            break
        default:
            break
        }
        
        if currentStepRegister == .done {
            SPUserViewModel.shareInstance.signUpWithInfo(currentUserInfo) { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @objc func backAndCancelButtonOnTouch(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func progressSetupViewWithStep() {
        self.loadViewIfNeeded()
        switch currentStepRegister {
        case .one:
            UIView.animate(withDuration: 0.5, animations: {
                self.containerTextFieldStepOneStackView.isHidden = false
                self.containerTextFieldStepTwoStackView.isHidden = true
            })
            registerButton.setTitle("Tiếp tục", for: .normal)
            print("Current content size : \(mainContainerView.frame.width)")
            mainContainerView.contentSize = CGSize(width: contentSizeWidth, height: heightForContainerStepOne)
            break
        case .two:
            UIView.animate(withDuration: 0.5, animations: {
                self.containerTextFieldStepOneStackView.isHidden = true
                self.containerTextFieldStepTwoStackView.isHidden = false
            })
            registerButton.setTitle("Đăng ký", for: .normal)
            mainContainerView.contentSize = CGSize(width: contentSizeWidth, height: heightForContainerStepTwo)
            break
        default:
            break
        }
    }
    
    private func isValidateStepOne() -> Bool {
        guard let email = emailTextField.text, !email.isEmpty else {
            currentErrorMessage = "Email không thể để trống!"
            return false
        }
        // Save email
        currentUserInfo.email = email
        
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            currentErrorMessage = "Số điện thoại không thể để trống!"
            return false
        }
        currentUserInfo.phone = phone
        
        guard let address = addressTextField.text, !address.isEmpty else {
            currentErrorMessage = "Địa chỉ không thể để trống!"
            return false
        }
        
        currentUserInfo.address = address
        
        guard let city = addressTextField.text, !city.isEmpty else {
            currentErrorMessage = "Tỉnh/Thành phố không thể để trống!"
            return false
        }
        currentUserInfo.city = city
        
        return true
    }
    
    private func isValidateStepTwo() -> Bool {
        guard let username = userNameTextField.text, !username.isEmpty else {
            currentErrorMessage = "Tên tài khoản không thể để trống!"
            return false
        }
        currentUserInfo.username = username
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            currentErrorMessage = "Mật khẩu không thể để trống!"
            return false
        }
        
        guard let rePassword = rePasswordTextField.text, !rePassword.isEmpty else {
            currentErrorMessage = "Nhập lại mật khẩu không thể để trống!"
            return false
        }
        
        if password != rePassword {
            currentErrorMessage = "Mật khẩu và nhập lại mật khẩu không trùng khớp!"
            return false
        }
        currentUserInfo.password = password
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
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
