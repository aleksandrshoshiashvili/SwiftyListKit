//
//  CollectionViewDelegate.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/04/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

open class CollectionViewDelegate<S: CollectionListSection>: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    unowned var dataSource: CollectionViewDataSource<S>
    
    public typealias ModelAtIndex = ((UICollectionView, IndexPath, S.ItemModel?) -> Void)
    public typealias DisplayCellAtIndex = ((UICollectionView, UICollectionViewCell, IndexPath, S.ItemModel?) -> Void)
    public typealias DisplaySupplementaryViewAtIndex = ((UICollectionView, UICollectionReusableView, IndexPath, S.ItemModel?) -> Void)
    
    public var didSelectItem: ModelAtIndex?
    public var didDeselectItem: ModelAtIndex?
    
    public var willDisplayCell: DisplayCellAtIndex?
    public var didEndDisplayingCell: DisplayCellAtIndex?
    
    public var willDisplaySupplementaryView: DisplaySupplementaryViewAtIndex?
    public var didEndDisplayingSupplementaryView: DisplaySupplementaryViewAtIndex?

    public init(dataSource: CollectionViewDataSource<S>) {
        self.dataSource = dataSource
        super.init()
    }

//    public init(dataSource: CollectionViewDataSource<S>,
//                didSelectItem: ModelAtIndex? = nil,
//                didDeselectItem: ModelAtIndex? = nil,
//                willDisplayCell: DisplayCellAtIndex? = nil,
//                didEndDisplayingCell: DisplayCellAtIndex? = nil,
//                willDisplaySupplementaryView: DisplaySupplementaryViewAtIndex? = nil,
//                didEndDisplayingSupplementaryView: DisplaySupplementaryViewAtIndex? = nil) {
//        self.dataSource = dataSource
//        super.init()
//        self.didSelectItem = didSelectItem
//        self.didDeselectItem = didDeselectItem
//        self.willDisplayCell = willDisplayCell
//        self.didEndDisplayingCell = didEndDisplayingCell
//        self.willDisplaySupplementaryView = willDisplaySupplementaryView
//        self.didEndDisplayingSupplementaryView = didEndDisplayingSupplementaryView
//    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sendCallBack(for: didSelectItem, collectionView: collectionView, indexPath: indexPath)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        sendCallBack(for: didDeselectItem, collectionView: collectionView, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        sendCallBack(for: willDisplayCell, collectionView: collectionView, cell: cell, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        sendCallBack(for: didEndDisplayingCell, collectionView: collectionView, cell: cell, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        sendCallBack(for: willDisplaySupplementaryView, collectionView: collectionView, supplementaryView: view, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        sendCallBack(for: didEndDisplayingSupplementaryView, collectionView: collectionView, supplementaryView: view, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let model = try? dataSource.model(at: indexPath) as? S.ItemModel else {
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                return layout.itemSize
            } else {
                return UICollectionViewFlowLayout.automaticSize
            }
        }
        let heightStyle = model.heightStyle
        switch heightStyle {
        case .static(let height, let width):
            return CGSize(width: width, height: height)
        }
    }
    
    // MARK: Private
    
    private func sendCallBack(for closure: ModelAtIndex?, collectionView: UICollectionView, indexPath: IndexPath) {
        do {
            let model = try dataSource.model(at: indexPath) as? S.ItemModel
            closure?(collectionView, indexPath, model)
        } catch {
            closure?(collectionView, indexPath, nil)
        }
    }
    
    private func sendCallBack(for closure: DisplayCellAtIndex?, collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        do {
            let model = try dataSource.model(at: indexPath) as? S.ItemModel
            closure?(collectionView, cell, indexPath, model)
        } catch {
            closure?(collectionView, cell, indexPath, nil)
        }
    }
    
    private func sendCallBack(for closure: DisplaySupplementaryViewAtIndex?, collectionView: UICollectionView, supplementaryView: UICollectionReusableView, indexPath: IndexPath) {
        do {
            let model = try dataSource.model(at: indexPath) as? S.ItemModel
            closure?(collectionView, supplementaryView, indexPath, model)
        } catch {
            closure?(collectionView, supplementaryView, indexPath, nil)
        }
    }
    
}
