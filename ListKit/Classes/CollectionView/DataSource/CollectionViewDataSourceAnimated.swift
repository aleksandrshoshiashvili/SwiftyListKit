//
//  CollectionViewDataSourceAnimated.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/04/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

// MARK: - CollectionViewDataSource

/// Data Source that support animated update, works with ListSection
open class CollectionViewDataSourceAnimated<S: CollectionListSection>: CollectionViewDataSource<S> {
    public typealias Section = S
    public typealias ItemModel = S.ItemModel
    
    public override init(configureCell: @escaping ConfigureCell = { (dataSource, collectionView, indexPath, viewModel) -> UICollectionViewCell in
        dataSource.registerListItem(withIdentifier: viewModel.reuseIdentifier,
                                    type: .cell,
                                    collectionView: collectionView)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseIdentifier, for: indexPath)
        let listItem = cell as! ListItem
        
        if let map = viewModel.map {
            map(viewModel.data, listItem)
        } else if let defaultDataMap = type(of: listItem).defaultDataMap {
            defaultDataMap(viewModel.data, listItem)
        }
        
        if let mapStyle = viewModel.style {
            mapStyle(listItem)
        } else if let mapDefaultStyle = type(of: listItem).defaultStyle {
            mapDefaultStyle(listItem)
        }
        
        if let delegatableItem = listItem as? ListItemDelegatable, let delegate = dataSource.delegate {
            delegatableItem.set(delegate: delegate)
        }
        
        return listItem as! UICollectionViewCell
        },
                         canMoveRowAtIndexPath: @escaping CanMoveRowAtIndexPath = { _, _ in false },
                         viewForSupplementaryElement: @escaping ViewForSupplementaryElement = { _, _, _, _ in UICollectionReusableView() },
                         indexTitles: @escaping IndexTitles = { _ in nil },
                         indexPathForIndexTitle: @escaping IndexPathForIndexTitle = { _, _, _ in IndexPath() }) {
        super.init(configureCell: configureCell,
                   canMoveRowAtIndexPath: canMoveRowAtIndexPath,
                   viewForSupplementaryElement: viewForSupplementaryElement,
                   indexTitles: indexTitles,
                   indexPathForIndexTitle: indexPathForIndexTitle)
    }
    
    public func getSections() -> [Section] {
        return sectionModels
    }
    
    public func update(with sections: [Section]) {
        self.sectionModels = sections
    }
    
    public func getViewModel(for indexPath: IndexPath) -> ItemModel? {
        guard let section = sectionModels[safe: indexPath.section],
            let viewModel = section.rows[safe: indexPath.row] else {
                return nil
        }
        return viewModel
    }
}
