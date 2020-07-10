//
//  TableViewRegistrar.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 23/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

public class TableViewRegistrator {
    
    public enum TableObjectType {
        case cell
        case headerFooter
    }
    
    private weak var tableView: UITableView?
    private var registeredIds: Set<String> = []
    
    public init(tableView: UITableView?) {
        self.tableView = tableView
    }
    
    func register(withReuseIdentifier reuseIdentifier: String, forType type: TableObjectType) {
        if registeredIds.contains(reuseIdentifier) {
            return
        }
        
        var isImplementedInStoryboard = false
        
        switch type {
        case .cell:
            isImplementedInStoryboard = tableView?.dequeueReusableCell(withIdentifier: reuseIdentifier) != nil
        case .headerFooter:
            isImplementedInStoryboard = tableView?.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) != nil
        }
        
        if isImplementedInStoryboard {
            registeredIds.insert(reuseIdentifier)
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
        
        // if has nib
        let nib = UINib(nibName: reuseIdentifier, bundle: bundle)
        switch type {
        case .cell:
            tableView?.register(nib, forCellReuseIdentifier: reuseIdentifier)
        case .headerFooter:
            tableView?.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
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
        return namespace(for: Bundle(for: TableViewRegistrator.self))
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
                              itemType: TableObjectType,
                              listItemClass: AnyClass) {
        switch itemType {
        case .cell:
            tableView?.register(listItemClass, forCellReuseIdentifier: reuseIdentifier)
        case .headerFooter:
            tableView?.register(listItemClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        }
        registeredIds.insert(reuseIdentifier)
    }
}
