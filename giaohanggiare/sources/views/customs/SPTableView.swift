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
    func heightForRowAt(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

protocol SPTableViewDataDelegate: class {
    func didSelectRowAt(indexPath: IndexPath)
}

class SPTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var currentItemType:ItemTableViewType = .home
    
    weak var customDataSource: SPTableViewDataSource?
    weak var customDataDelegate: SPTableViewDataDelegate?
    
    let cellId = "cellID"
    
    func reloadDataTable() {
        self.reloadData()
    }
    
    convenience init(type: ItemTableViewType, frame: CGRect) {
        self.init(frame: frame)
        self.currentItemType = type
        setUpView()
    }
    
    func setUpView() {
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (customDataSource?.heightForRowAt(tableView, heightForRowAt:indexPath))!
    }
}

class SPCustomTableCell: UITableViewCell {
    
}


