//
//  TableViewRegistrar.swift
//  TableKit
//
//  Created by Alexander Shoshiashvili on 23/02/2018.
//  Copyright © 2018 HIQ. All rights reserved.
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
        
        if let namespace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String,
            let listItemClass: AnyClass = NSClassFromString("\(namespace).\(reuseIdentifier)") {
            bundle = Bundle(for: listItemClass)
        } else {
            bundle = Bundle(for: TableViewRegistrator.self)
        }
        
        guard let _ = bundle?.path(forResource: reuseIdentifier, ofType: "nib") else {
            // if in code
            if let namespace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String,
                let listItemClass: AnyClass = NSClassFromString("\(namespace).\(reuseIdentifier)") {
                switch type {
                case .cell:
                    tableView?.register(listItemClass, forCellReuseIdentifier: reuseIdentifier)
                case .headerFooter:
                    tableView?.register(listItemClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
                }
                registeredIds.insert(reuseIdentifier)
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
    
}
