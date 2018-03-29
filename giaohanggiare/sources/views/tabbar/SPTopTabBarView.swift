//
//  TopTabBarView.swift
//  giaohanggiare
//
//  Created by Quan Tran on 10/11/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

enum SPTopTabBarType {
    case home
    case create
    case east
    case west
}

protocol SPTopTabBarDelegate: class {
    func OnPressTabBarButton(index: NSInteger)
}

class SPTopTabBarView: UIView {
    var currentTabBarType: SPTopTabBarType = .home
    var viewFrame: CGRect = .zero
    weak var delegate:SPTopTabBarDelegate?
    
    var shapeLayer: CAShapeLayer = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 10))
        path.addLine(to: CGPoint(x: 200, y: 30))
        path.addLine(to: CGPoint(x: 25, y: 30))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.path = path.cgPath
        shapeLayer.strokeStart = 0.8
        return shapeLayer
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView()  {
        viewFrame = self.frame
        self.backgroundColor = .red
    }
    
    public func setUpTabBarWithType(type: SPTopTabBarType) {
        // Save current type
        currentTabBarType = type
        
        // Config view
        switch type {
        case .home:
            createHomeTopTabBarView()
            break
            
        default:
            break
        }
        
    }
    
    func clearAllView() {
        for v in self.subviews {
            v .removeFromSuperview()
        }
    }
    
    func createHomeTopTabBarView(){
        
        // Clear old view
        clearAllView()
        
        var index: NSInteger = 1
        let width: CGFloat = (CGFloat(Float(viewFrame.width/3) * Float(index)))
        var x: CGFloat = (CGFloat(Float(viewFrame.width/3) * Float(index - 1)))
        let labeltitle1: UILabel = UILabel(frame: CGRect(x: x, y: 0, width: width, height: viewFrame.height))
        labeltitle1.backgroundColor = .clear
        labeltitle1.text = "Dang cho"
        labeltitle1.font = UIFont.boldSystemFont(ofSize: 13.0)
        labeltitle1.textColor = .white
        labeltitle1.textAlignment = .center;
        labeltitle1.tag = index;
        
        let button1:UIButton = UIButton(type: .custom)
        button1.backgroundColor = .clear
        button1.frame = CGRect(x: x, y: 0, width: width, height: viewFrame.height)
        button1.tag = index
        button1.addTarget(self, action: #selector(topTabBarButtonOnPress(sender:)), for: .touchUpInside)
        self.addSubview(button1)
        self.addSubview(labeltitle1)
        
        index = index + 1
        x = (CGFloat(Float(viewFrame.width/3) * Float(index - 1)))
        let labeltitle2: UILabel = UILabel(frame: CGRect(x: x, y: 0, width: width, height: viewFrame.height))
        labeltitle2.backgroundColor = .clear
        labeltitle2.text = "Dang giao"
        labeltitle2.font = UIFont.boldSystemFont(ofSize: 13.0)
        labeltitle2.textColor = .white
        labeltitle2.textAlignment = .center;
        labeltitle2.tag = index;
        
        let button2:UIButton = UIButton(type: .custom)
        button2.backgroundColor = .clear
        button2.frame = CGRect(x: x, y: 0, width: width, height: viewFrame.height)
        button2.tag = index
        button2.addTarget(self, action: #selector(topTabBarButtonOnPress(sender:)), for: .touchUpInside)
        self.addSubview(button2)
        self.addSubview(labeltitle2)
        
        index = index + 1
        x = (CGFloat(Float(viewFrame.width/3) * Float(index - 1)))
        
        let labeltitle3: UILabel = UILabel(frame: CGRect(x: x, y: 0, width: width, height: viewFrame.height))
        labeltitle3.backgroundColor = .clear
        labeltitle3.text = "Da giao"
        labeltitle3.font = UIFont.boldSystemFont(ofSize: 13.0)
        labeltitle3.textColor = .white
        labeltitle3.textAlignment = .center;
        labeltitle3.tag = index;
        
        let button3:UIButton = UIButton(type: .custom)
        button3.backgroundColor = .clear
        button3.frame = CGRect(x: x, y: 0, width: width, height: viewFrame.height)
        button3.tag = index
        button3.addTarget(self, action: #selector(topTabBarButtonOnPress(sender:)), for: .touchUpInside)
        self.addSubview(button3)
        self.addSubview(labeltitle3)
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func selectedItemIndex(index: NSInteger) {
        for v:UIView in self.subviews {
            if v.isKind(of: UILabel.self) {
                v.backgroundColor = .red
            }
        }
        switch index {
        case 1:
            let v = getTabbarWithIndex(index: index)
            if let v1 = v {
                v1.backgroundColor = .gray
                let path = UIBezierPath()
                path.move(to: CGPoint(x: 0, y: 10))
                path.addLine(to: CGPoint(x: 200, y: 30))
                path.addLine(to: CGPoint(x: 25, y: 30))
                shapeLayer.path = path.cgPath
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                shapeLayer.add(animation, forKey: "MyAnimation")
            }
            break
        case 2:
            let v = getTabbarWithIndex(index: index)
            if let v1 = v {
                v1.backgroundColor = .gray
                let path = UIBezierPath()
                path.move(to: CGPoint(x: 0, y: 10))
                path.addLine(to: CGPoint(x: 290, y: 30))
                path.addLine(to: CGPoint(x: 145, y: 30))
                shapeLayer.path = path.cgPath
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                shapeLayer.add(animation, forKey: "MyAnimation")
            }
            break
            
        case 3:
            let v = getTabbarWithIndex(index: index)
            if let v1 = v {
                v1.backgroundColor = .gray
                let path = UIBezierPath()
                path.move(to: CGPoint(x: 0, y: 10))
                path.addLine(to: CGPoint(x: 380, y: 30))
                path.addLine(to: CGPoint(x: 265, y: 30))
                shapeLayer.path = path.cgPath
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                shapeLayer.add(animation, forKey: "MyAnimation")
            }
            break
        default:
            
            break
        }
    }
    
    func getTabbarWithIndex(index: NSInteger) -> UIView! {
        for v in self.subviews {
            if v.tag == index && v.isKind(of: UILabel.self) {
                return v
            }
        }
        
        return nil
    }
    
    @objc func topTabBarButtonOnPress(sender: UIButton) {
        let button: UIButton = sender
        switch currentTabBarType {
        case .home:
            selectedItemIndex(index: button.tag)
            self.delegate?.OnPressTabBarButton(index: button.tag)
            break
        default:
            break
        }
    }
}
