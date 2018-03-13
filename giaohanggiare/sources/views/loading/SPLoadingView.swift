//
//  SPLoadingView.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 1/9/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

class SPLoadingView: UIView {
    
//    var typeIndicator: NVActivityIndicatorType = .ballSpinFadeLoader
//    var activityIndicatorView: NVActivityIndicatorView!
    var grayView:UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, type: Int) {
        self.init(frame: frame)
//        typeIndicator = NVActivityIndicatorType(rawValue: type)!
        setupView()
    }
    
    func setupView() {
        if grayView == nil {
            grayView = UIView(frame: .zero)
            grayView.backgroundColor = .gray
            grayView.alpha = 0.45
            self.addSubview(grayView)
            
            grayView.anchor(self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: self.bottomAnchor,
                            topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0,
                            widthConstant: 0.0, heightConstant: 0.0)
        }
        
//        if (activityIndicatorView == nil) {
//            activityIndicatorView = NVActivityIndicatorView(frame: .zero, type: typeIndicator)
//
//            activityIndicatorView.padding = 20
//            self.addSubview(activityIndicatorView)
//            activityIndicatorView.anchor(self.centerYAnchor, left: self.centerXAnchor, right: nil, bottom: nil,
//                                         topConstant: -50.0, leftConstant: -50.0, rightConstant: 0.0, bottomConstant: 0.0,
//                                         widthConstant: 100.0, heightConstant: 100.0)
//        }
    }
    
    func startLoadingAnimation() {
//        if activityIndicatorView != nil {
//            activityIndicatorView.startAnimating()
//        }
    }
    
    func stopLoadingAnimation() {
//        if activityIndicatorView != nil {
//            activityIndicatorView.stopAnimating()
//        }
    }

}
