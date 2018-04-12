//
//  SPCollectionView.swift
//  giaohanggiare
//
//  Created by Quan Tran on 12/6/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

enum SPCollectionViewType {
    case home
    case create
    case east
    case west
}

protocol SPCollectionViewDataSource: class {
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ collectionView: UICollectionView, section: Int) -> Int
    func cellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func sizeForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
    func viewForSupplementaryElementOfKind(_ collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    func referenceSizeForHeaderInSection(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize
    func referenceSizeForFooterInSection(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  section: Int) -> CGSize
}

protocol SPCollectionViewDelegate: class {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}



class SPCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var spCollectinViewType:SPCollectionViewType = .home
    
    let cellId = "CollectionId"
    weak var customDataSource: SPCollectionViewDataSource?
    weak var customDelegate: SPCollectionViewDelegate?
    
    convenience init(type: SPCollectionViewType, frame: CGRect, layout: UICollectionViewFlowLayout) {
        self.init(frame: frame, collectionViewLayout: layout)
        spCollectinViewType = type
        
        self.delegate = self
        self.dataSource = self;
    }
    
    
    public func setDelegateAndDataSource(_ delegate: SPCollectionViewDelegate, dataSource: SPCollectionViewDataSource) {
        customDataSource = dataSource
        customDelegate = delegate
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (customDataSource?.numberOfSections())!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (customDataSource!.numberOfItemsInSection(collectionView, section: section))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (customDataSource?.cellForItemAt(collectionView, indexPath: indexPath))!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        customDelegate?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    // 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (customDataSource?.sizeForItemAt(collectionView, indexPath: indexPath))!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return (customDataSource?.viewForSupplementaryElementOfKind(collectionView, kind:kind , at:indexPath))!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return (customDataSource?.referenceSizeForHeaderInSection(collectionView, layout: collectionViewLayout, section: section))!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return (customDataSource?.referenceSizeForFooterInSection(collectionView, layout: collectionViewLayout, section: section))!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 10, 0)
    }
}

class SPCollectionViewCell: UICollectionViewCell {
    
    // this gets called when a cell is dequeued
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
}
