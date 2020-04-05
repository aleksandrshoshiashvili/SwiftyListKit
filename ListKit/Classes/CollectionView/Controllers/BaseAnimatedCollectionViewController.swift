//
//  BaseAnimatedCollectionViewController.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 04/04/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

open class BaseAnimatedCollectionViewController: UIViewController, CreateCollectionProtocol, UpdateCollectionProtocol, Delegatable {
    
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
    
    public func setDefaultDataSource() {
        let dataSource = CollectionViewDataSourceAnimated<CollectionListSection>()
        setDataSource(dataSource)
    }
    
    public func setDataSource(_ dataSource: CollectionViewDataSourceAnimated<CollectionListSection>) {
        self.dataSource = dataSource
        self.syncDelegate = CollectionViewDelegate(dataSource: dataSource)
        collectionView.dataSource = dataSource
        collectionView.delegate = syncDelegate
        dataSource.delegate = self
    }
    
    public func clearData() {
        dataSource.setSections([])
        update(with: [])
    }
    
    public func update(with sections: [CollectionListSection]) {
        ListUpdater.updateCollectionViewView(collectionView,
                                             with: dataSource,
                                             newSections: sections,
                                             updateAnimation: .default)
    }
    
    public func setupCollectionViewRepresentation() {
        collectionView.backgroundColor = .white
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.estimatedItemSize = CGSize(width: 50, height: 50)
        }
    }
    
    public func showLoader() {
        collectionView.showLoader(loaderType: .solid(config: .default))
    }
    
    public func showLoader(with sections: [CollectionListSection]) {
        collectionView.isHidden = true
        update(with: sections)
        
        let delay = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.collectionView.showLoader(loaderType: .solid(config: .default))
        }
    }
    
    public func hideLoader() {
        collectionView.hideLoader()
    }
    
    public func hideLoader(with replacingSections: [CollectionListSection]) {
        update(with: replacingSections)
        collectionView.hideLoader()
    }
}
