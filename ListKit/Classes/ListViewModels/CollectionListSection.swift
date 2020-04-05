//
//  CollectionListSection.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 07.01.20.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

/// Base list item component
public class CollectionListSection: ListSectionProtocol {
    public var header: CollectionItemViewModel?
    public var footer: CollectionItemViewModel?
    public var rows: [CollectionItemViewModel]

    /// User to distinguish one section from another
    public var id: Int {
        let headerId = header?.data.hashString ?? ""
        let footerId = footer?.data.hashString ?? ""
        let calculatedId = headerId + footerId
        return calculatedId.hashValue
    }

    /**
     Initializes a new ListSection object. Each parameter has type: `ListItemViewModel`

     - Parameters:
       - header: used to display the header of the list (optional)
       - footer: used to display the footer of the list (optional)
       - rows: used to display the rows of the list

     */
    required public init(header: CollectionItemViewModel? = nil,
                         footer: CollectionItemViewModel? = nil,
                         rows: [CollectionItemViewModel]) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }

    /**
     Helper method to initialize empty `ListSection`

     - Returns: empty `ListSection` without header and footer and with empty array of rows.

     */
    static public func empty() -> CollectionListSection {
        return CollectionListSection(header: nil, footer: nil, rows: [])
    }

    /// Helper function
    static func +(left: CollectionListSection,
                  right: CollectionListSection) -> [CollectionListSection] {
        let result = [left, right]
        return result
    }
}
