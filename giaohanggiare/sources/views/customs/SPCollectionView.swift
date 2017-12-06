//
//  SPCollectionView.swift
//  giaohanggiare
//
//  Created by Quan Tran on 12/6/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

protocol SPCollectionViewDataSource: class {
    var numberOfSections: Int { get }
    func numberOfItems(inSection section: Int) -> Int
    func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell?
}

protocol SPCollectionViewDataDelegate: class {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class SPCollectionView: UICollectionView {
    convenience init(type: ItemTableViewType, frame: CGRect) {
        self.init(frame: frame)
        self.currentItemType = type
        setUpView()
    }

}
