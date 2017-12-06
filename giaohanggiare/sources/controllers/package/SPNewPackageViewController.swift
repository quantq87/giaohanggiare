//
//  SPNewPackageViewController.swift
//  giaohanggiare
//
//  Created by Quan Tran on 12/6/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

class SPNewPackageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.navigationItem.title = "Tao Don Hang"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .undo, target: self, action: #selector(backBarButtonOnTouch))
        
        
    }
    
    
    func backBarButtonOnTouch(sender: UIBarButtonItem)  {
        print("backBarButtonOnTouch onclick")
        self.navigationController?.popViewController(animated: true)
    }
}
