//
//  SetupCollectionProtocol.swift
//
//  Created by Alexander Shoshiashvili on 25/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

public protocol SetupCollectionProtocol: class {
  var collectionView: UICollectionView! { get set }
  func setupCollectionView()
}

extension SetupCollectionProtocol where Self: BaseAnimatedCollectionViewController {
    public func setupCollectionView() {
        setDefaultDataSource()
    }
}
