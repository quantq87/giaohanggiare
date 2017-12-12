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
    
    
    var userNameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.placeholder = "Ten tai khoan"
        tf.text = ""
        return tf
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
        
        topView.anchor(view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 100)
        topView.dropShadow(scale: true, rect: CGRect(x: 0, y: 0, width: view.frame.width, height: 100.0))
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
