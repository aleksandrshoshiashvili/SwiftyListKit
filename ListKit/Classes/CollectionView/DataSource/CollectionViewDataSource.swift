//
//  CollectionViewDataSource.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/04/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

/// Base Data Source, works with ListRowsProtocol
open class CollectionViewDataSource<S: ListRowsProtocol>
    : NSObject
, UICollectionViewDataSource {
    
    public typealias I = S.ItemModel
    public typealias Section = S
    
    public typealias ConfigureCell = (CollectionViewDataSource<S>, UICollectionView, IndexPath, I) -> UICollectionViewCell
    public typealias CanMoveRowAtIndexPath = (CollectionViewDataSource<S>, IndexPath) -> Bool
    public typealias ViewForSupplementaryElement = (CollectionViewDataSource<S>, UICollectionView, String, IndexPath) -> UICollectionReusableView
    public typealias IndexTitles = (CollectionViewDataSource<S>) -> [String]?
    public typealias IndexPathForIndexTitle = (CollectionViewDataSource<S>, _ title: String, _ index: Int) -> IndexPath
    
    public init(
        configureCell: @escaping ConfigureCell,
        canMoveRowAtIndexPath: @escaping CanMoveRowAtIndexPath = { _, _ in false },
        viewForSupplementaryElement: @escaping ViewForSupplementaryElement = { _, _, _, _ in UICollectionReusableView() },
        indexTitles: @escaping IndexTitles = { _ in nil },
        indexPathForIndexTitle: @escaping IndexPathForIndexTitle = { _, _, _ in IndexPath() }
        ) {
        self.configureCell = configureCell
        self.canMoveRowAtIndexPath = canMoveRowAtIndexPath
        self.viewForSupplementaryElement = viewForSupplementaryElement
        self.indexTitles = indexTitles
        self.indexPathForIndexTitle = indexPathForIndexTitle
    }
    
    weak public var delegate: Delegatable?
    
    // This structure exists because model can be mutable
    // In that case current state value should be preserved.
    // The state that needs to be preserved is ordering of items in section
    // and their relationship with section.
    // If particular item is mutable, that is irrelevant for this logic to function
    // properly.
    
    open var sectionModels: [S] = []
    
    open subscript(section: Int) -> S {
        return sectionModels[section]
    }
    
    open subscript(indexPath: IndexPath) -> I {
        get {
            return self.sectionModels[indexPath.section].rows[indexPath.row]
        }
        set(item) {
            var section = sectionModels[indexPath.section]
            section.rows[indexPath.item] = item
            sectionModels[indexPath.section] = section
        }
    }
    
    open func model(at indexPath: IndexPath) throws -> Any {
        return self[indexPath]
    }
    
    open func setSections(_ sections: [S]) {
        sectionModels = sections
    }
    
    open var configureCell: ConfigureCell {
        didSet {
        }
    }
    
    open var canMoveRowAtIndexPath: CanMoveRowAtIndexPath {
        didSet {
        }
    }
    
    open var viewForSupplementaryElement: ViewForSupplementaryElement {
        didSet {
        }
    }
    
    open var indexTitles: IndexTitles {
        didSet {
        }
    }
    open var indexPathForIndexTitle: IndexPathForIndexTitle {
        didSet {
        }
    }
    
    // UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionModels.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard sectionModels.count > section else { return 0 }
        return sectionModels[section].rows.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        precondition(indexPath.item < sectionModels[indexPath.section].rows.count)
        return configureCell(self, collectionView, indexPath, self[indexPath])
    }
    
    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return canMoveRowAtIndexPath(self, indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        sectionModels.moveFromSourceIndexPath(sourceIndexPath, destinationIndexPath: destinationIndexPath)
    }

    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return viewForSupplementaryElement(self, collectionView, kind, indexPath)
    }

    open func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return indexTitles(self)
    }
    
    open func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        return indexPathForIndexTitle(self, title, index)
    }
    
    public func registerListItem(withIdentifier identifier: String,
                                 type: CollectionViewRegistrator.CollectionObjectType,
                                 collectionView: UICollectionView) {
        if let collectionView = collectionView as? CollectionView {
            collectionView.registrator.register(withReuseIdentifier: identifier,
                                                forType: type)
        }
    }
}
