//
//  CollectionViewRegistrator.swift
//
//  Created by Alexander Shoshiashvili on 04/06/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

public class CollectionViewRegistrator {
    
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
            bundle = Bundle(for: CollectionViewRegistrator.self)
        }
        
        guard let _ = bundle?.path(forResource: reuseIdentifier, ofType: "nib") else {
            // if in code

            if let namespace = normalizedNamespace(),
               let listItemClass = itemClass(for: namespace, with: reuseIdentifier) {
                registerCell(for: namespace,
                             with: reuseIdentifier,
                             itemType: type,
                             listItemClass: listItemClass)
            } else if let namespace = localNamespace(),
                      let listItemClass = itemClass(for: namespace, with: reuseIdentifier){
                registerCell(for: namespace,
                             with: reuseIdentifier,
                             itemType: type,
                             listItemClass: listItemClass)
            }
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
        guard let namespace = namespace(for: .main) else {
            return nil
        }
        return namespace.replacingOccurrences(of: " ", with: "_")
    }

    private func localNamespace() -> String? {
        return namespace(for: Bundle(for: CollectionViewRegistrator.self))
    }

    private func namespace(for bundle: Bundle) -> String? {
        guard let namespace = bundle.infoDictionary?["CFBundleExecutable"] as? String else {
            return nil
        }
        return namespace
    }

    private func itemClass(for namespace: String,
                           with reuseIdentifier: String) -> AnyClass? {
        guard let listItemClass: AnyClass = NSClassFromString("\(namespace).\(reuseIdentifier)") else {
            return nil
        }
        return listItemClass
    }

    private func registerCell(for namespace: String,
                              with reuseIdentifier: String,
                              itemType: CollectionObjectType,
                              listItemClass: AnyClass) {
        switch itemType {
        case .cell:
            collectionView?.register(listItemClass, forCellWithReuseIdentifier: reuseIdentifier)
        case .supplementaryView:
            break
        }
        registeredIds.insert(reuseIdentifier)
    }
    
}
