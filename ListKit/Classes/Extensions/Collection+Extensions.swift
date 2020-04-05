//
//  Collection+Extensions.swift
//  ListKit
//
//  Created by Alexander Shoshiashvili on 06/11/2018.
//

import Foundation

extension Collection {
    public subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: ListRowsProtocol {
    mutating func moveFromSourceIndexPath(_ sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        var sourceSection = self[sourceIndexPath.section]
        var sourceItems = sourceSection.rows
        
        let sourceItem = sourceItems.remove(at: sourceIndexPath.item)
        
        sourceSection.rows = sourceItems
        self[sourceIndexPath.section] = sourceSection
        
        var destinationSection = self[destinationIndexPath.section]
        var destinationItems = destinationSection.rows
        destinationItems.insert(sourceItem, at: destinationIndexPath.item)
        destinationSection.rows = destinationItems
        self[destinationIndexPath.section] = destinationSection
    }
}
