//
//  DiffableListSection.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 21/02/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import Foundation
import DifferenceKit

internal class DiffableListSection<T: ListSectionProtocol>: Differentiable {
    var differenceIdentifier: String = ""
    
    let section: T
    
    var id: Int { return section.id }
    var header: T.ItemModel? { return section.header }
    var footer: T.ItemModel? { return section.footer }
    var rows: [T.ItemModel] { return section.rows }
    
    init(section: T) {
        self.section = section
        self.differenceIdentifier = (header?.hashString ?? "") + (footer?.hashString ?? "")
    }
}

extension DiffableListSection: Equatable {
    public static func == (lhs: DiffableListSection, rhs: DiffableListSection) -> Bool {
        return lhs.id == rhs.id
    }
}

extension DiffableListSection: Collection {
    public func index(after i: Int) -> Int {
        return rows.index(after: i)
    }
    
    public typealias Element = T.ItemModel
    public typealias Index = Int
    
    public var startIndex: Int {
        return rows.startIndex
    }
    
    public var endIndex: Int {
        return rows.endIndex
    }
    
    public subscript(i: Int) -> T.ItemModel {
        return rows[i]
    }
}

internal extension Array where Element: ListSectionProtocol {
    func convertToDiffable() -> [DiffableListSection<Element>] {
        return self.map({ DiffableListSection(section: $0) })
    }
}
