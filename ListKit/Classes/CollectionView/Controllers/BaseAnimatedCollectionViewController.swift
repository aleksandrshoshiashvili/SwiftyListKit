//
//  BaseAnimatedCollectionViewController.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/04/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

open class BaseAnimatedCollectionViewController: UIViewController, AnimatedCollectionListProtocol {
    
    public var collectionView: UICollectionView!
    public var dataSource: CollectionViewDataSourceAnimated<CollectionListSection>!
    public var syncDelegate: CollectionViewDelegate<CollectionListSection>!
    
    open override func viewDidLoad() {
        viewDidLoad(withLayout: UICollectionViewFlowLayout())
    }
    
    public func viewDidLoad(withLayout layout: UICollectionViewLayout) {
        super.viewDidLoad()
        createAndSetupCollectionView(with: layout)
        setupCollectionViewRepresentation()
        view.backgroundColor = collectionView.backgroundColor
    }
}
