//
//  ListSection.swift
//  TableKit
//
//  Created by Alexander Shoshiashvili on 23/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

/// Base list item component
public class TableListSection: ListSectionProtocol {
    public var header: TableItemViewModel?
    public var footer: TableItemViewModel?
    public var rows: [TableItemViewModel]
    
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
    required public init(header: TableItemViewModel? = nil, footer: TableItemViewModel? = nil, rows: [TableItemViewModel]) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }
    
    /**
     Helper method to initialize empty `ListSection`
     
     - Returns: empty `ListSection` without header and footer and with empty array of rows.
     
     */
    static public func empty() -> TableListSection {
        return TableListSection(header: nil, footer: nil, rows: [])
    }
    
    /// Helper function
    static func +(left: TableListSection, right: TableListSection) -> [TableListSection] {
        let result = [left, right]
        return result
    }
}

// MARK: - Array Extension

public extension Array where Element: ListSectionProtocol {
    mutating func appendSection(_ newSection: Element) {
        if !newSection.rows.isEmpty {
            append(newSection)
        }
    }
}
