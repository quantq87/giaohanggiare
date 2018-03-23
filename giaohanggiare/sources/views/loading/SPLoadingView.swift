//
//  SPLoadingView.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 1/9/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

class SPLoadingView: UIView {
    static let shareInstance = SPLoadingView()
    
    var grayView:UIView!
    
    var shapeLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .white
        return label
    }()
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc private func handleEnterForeground() {
        animatePulsatingLayer()
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 20
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.position = self.center
        return layer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, type: Int) {
        self.init(frame: frame)
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
        
        setupNotificationObservers()
        
        self.backgroundColor = UIColor.backgroundColor
        
        setupCircleLayers()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        setupPercentageLabel()
    }
    
    private func setupPercentageLabel() {
        self.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = self.center
    }
    
    private func setupCircleLayers() {
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: UIColor.pulsatingFillColor)
        self.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        let trackLayer = createCircleShapeLayer(strokeColor: .trackStrokeColor, fillColor: .backgroundColor)
        self.layer.addSublayer(trackLayer)
        
        shapeLayer = createCircleShapeLayer(strokeColor: .outlineStrokeColor, fillColor: .clear)
        
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        self.layer.addSublayer(shapeLayer)
    }
    
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
//    private func beginDownloadingFile() {
//        print("Attempting to download file")
//
//        shapeLayer.strokeEnd = 0
//
//        let configuration = URLSessionConfiguration.default
//        let operationQueue = OperationQueue()
//        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
//
//        guard let url = URL(string: urlString) else { return }
//        let downloadTask = urlSession.downloadTask(with: url)
//        downloadTask.resume()
//    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer.strokeEnd = percentage
        }
        
        print(percentage)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished downloading file")
    }
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc private func handleTap() {
        print("Attempting to animate stroke")
        
//        beginDownloadingFile()
        
        animateCircle()
    }
    
    func startLoadingAnimation(_ onView: UIView) {
        
        self.frame = CGRect(x: 0.0, y: 0.0, width: onView.frame.width, height: onView.frame.height)
        
        onView.addSubview(self)
        
        onView.bringSubview(toFront: self)
        
        self.anchor(onView.topAnchor, left: onView.leftAnchor, right: onView.rightAnchor, bottom: onView.bottomAnchor, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 0.0)
        
        setupView()
        animateCircle()
    }
    
    func stopLoadingAnimation() {
        self.removeFromSuperview()
    }

}
