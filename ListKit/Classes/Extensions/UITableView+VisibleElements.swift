//
//  UITableView+VisibleElements.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 14/02/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

public extension UITableView {
    
    private struct AssociatedKeys {
        static var visibleHeadersDict: [Int: UIView] = [:]
        static var visibleFootersDict: [Int: UIView] = [:]
    }
    
    var visibleHeadersDict: [Int: UIView] {
        get {
            guard let headers = (objc_getAssociatedObject(self, &AssociatedKeys.visibleHeadersDict) as? [Int: UIView]) else {
                return [:]
            }
            return headers
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.visibleHeadersDict,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    var visibleFootersDict: [Int: UIView] {
        get {
            guard let headers = (objc_getAssociatedObject(self, &AssociatedKeys.visibleFootersDict) as? [Int: UIView]) else {
                return [:]
            }
            return headers
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.visibleFootersDict,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    var visibleHeaders: [UIView] {
        let headers = visibleHeadersDict.sorted(by: { $0.0 < $1.0 }).map({ $0.value })
        return headers
    }
    
    var visibleFooters: [UIView] {
        let footers = visibleFootersDict.sorted(by: { $0.0 < $1.0 }).map({ $0.value })
        return footers
    }
    
    var visibleItems: [UIView] {
        let cells = visibleCells
        let headers = visibleHeadersDict
        let footers = visibleFootersDict
        
        var views: [UIView] = []
        
        guard let lastVisibleCell = visibleCells.last,
            let lastVisibleCellIndexPath = indexPath(for: lastVisibleCell) else {
                return []
        }
        
        let maxSectionCount = lastVisibleCellIndexPath.section
        
        for section in 0...maxSectionCount {
            if let header = headers[section] {
                views.append(header)
            }
            let cellsForSection = cells.filter({ indexPath(for: $0)?.section == section })
            views.append(contentsOf: cellsForSection)
            if let footer = footers[section] {
                views.append(footer)
            }
        }
        
        return views
    }
    
}
