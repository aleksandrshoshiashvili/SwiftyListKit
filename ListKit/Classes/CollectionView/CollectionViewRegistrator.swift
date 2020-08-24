//
//  CollectionViewRegistrator.swift
//
//  Created by Alexander Shoshiashvili on 04/06/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

public class CollectionViewRegistrator {
    
    public static var externalBundle: Bundle?
    
    public enum CollectionObjectType {
        case cell
        case supplementaryView
    }
    
    private weak var collectionView: UICollectionView?
    private var registeredIds: Set<String> = []
    
    public init(collectionView: UICollectionView?) {
        self.collectionView = collectionView
    }
    
    func register(withReuseIdentifier reuseIdentifier: String,
                  forType type: CollectionObjectType) {
        if registeredIds.contains(reuseIdentifier) {
            return
        }
        
        var bundle: Bundle?
        
        if let namespace = normalizedNamespace(),
            let listItemClass: AnyClass = NSClassFromString("\(namespace).\(reuseIdentifier)") {
            bundle = Bundle(for: listItemClass)
        } else {
            bundle = Bundle(for: TableViewRegistrator.self)
        }
        
        guard let _ = bundle?.path(forResource: reuseIdentifier, ofType: "nib") else {
            return
        }
        let nib = UINib(nibName: reuseIdentifier, bundle: bundle)
        switch type {
        case .cell:
            collectionView?.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        case .supplementaryView:
            break
        }
        registeredIds.insert(reuseIdentifier)
    }
    
    // MARK: - Helper
    
    private func normalizedNamespace() -> String? {
        let bundle: Bundle

        if let externalBundle = CollectionViewRegistrator.externalBundle {
            bundle = externalBundle
        } else {
            bundle = .main
        }

        guard let namespace = bundle.infoDictionary?["CFBundleExecutable"] as? String else {
            return nil
        }
        return namespace.replacingOccurrences(of: " ", with: "_")
    }
    
}
