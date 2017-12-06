//
//  GGTableView.swift
//  giaohanggiare
//
//  Created by Quan Tran on 9/24/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

enum ItemTableViewType {
    case home
    case create
    case east
    case west
}

protocol SPTableViewDataSource: class {
    // func register() -> Int
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol SPTableViewDataDelegate: class {
    func didSelectRowAt(indexPath: IndexPath)
}

class SPTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var currentItemType:ItemTableViewType = .home
    
    weak var customDataSource: SPTableViewDataSource?
    weak var customDataDelegate: SPTableViewDataDelegate?
    var customTablevView:UITableView!
    
    let cellId = "cellID"
    
    func reloadDataTable() {
        if let v = customTablevView {
            v.reloadData()
        }
    }
    
    convenience init(type: ItemTableViewType, frame: CGRect) {
        self.init(frame: frame)
        self.currentItemType = type
        setUpView()
    }
    
    func setUpView() {
        if customTablevView == nil {
            customTablevView = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), style: .plain)
        }
        customTablevView.backgroundColor = .clear
        customTablevView.delegate = self
        customTablevView.dataSource = self
        self.addSubview(customTablevView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (customDataSource?.numberOfSections())!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (customDataSource?.numberOfRowsInSection(section: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (customDataSource?.cellForRowAt(tableView, indexPath:indexPath))!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customDataDelegate?.didSelectRowAt(indexPath: indexPath)
    }
}

class SPCustomTableCell: UITableViewCell {
    
}


