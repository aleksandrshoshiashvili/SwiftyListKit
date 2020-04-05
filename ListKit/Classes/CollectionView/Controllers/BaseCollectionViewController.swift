//
//  BaseCollectionViewController.swift
//
//  Created by Alexander Shoshiashvili on 04/06/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

open class BaseCollectionViewController<S: ListRowsProtocol>: UIViewController, Delegatable {
    
    public var collectionView: UICollectionView!
    public var dataSource: CollectionViewDataSource<S>!
    public var syncDelegate: CollectionViewDelegate<CollectionListSection>!
    
    open override func viewDidLoad() {
        viewDidLoad(withLayout: UICollectionViewFlowLayout())
    }
    
    public func viewDidLoad(withLayout layout: UICollectionViewLayout) {
        super.viewDidLoad()
        createAndSetupCollectionView(with: layout)
        view.backgroundColor = collectionView.backgroundColor
        
        assert(dataSource == nil, "You should set Data source via calling `setDataSource(_ dataSource: TableViewDataSourceWithListSections<S>)` method")
    }
    
    public func createAndSetupCollectionView(with layout: UICollectionViewLayout) {
        collectionView = CollectionView(frame: view.frame, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        view.sendSubviewToBack(collectionView)
    }
    
    public func setDataSource(_ dataSource: CollectionViewDataSource<S>) {
        self.dataSource = dataSource
        collectionView.dataSource = dataSource
        dataSource.delegate = self
    }
    
    public func setDelegate(_ delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }
}
