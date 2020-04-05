//
//  TableRowAnimationConfiguration.swift
//  ListKit
//
//  Created by Alexander Shoshiashvili on 18/12/2018.
//

import UIKit

/// Struct for setup animation update of UITableView
public struct TableAnimationConfiguration {
    public var rowDeletionAnimation: UITableView.RowAnimation
    public var rowInsertionAnimation: UITableView.RowAnimation
    public var rowReloadAnimation: UITableView.RowAnimation
    public var sectionDeletionAnimation: UITableView.RowAnimation
    public var sectionInsertionAnimation: UITableView.RowAnimation
    public var sectionReloadAnimation: UITableView.RowAnimation
    
    public init(rowDeletionAnimation: UITableView.RowAnimation = .fade,
                rowInsertionAnimation: UITableView.RowAnimation = .fade,
                rowReloadAnimation: UITableView.RowAnimation = .fade,
                sectionDeletionAnimation: UITableView.RowAnimation = .fade,
                sectionInsertionAnimation: UITableView.RowAnimation = .fade,
                sectionReloadAnimation: UITableView.RowAnimation = .fade) {
        self.rowDeletionAnimation = rowDeletionAnimation
        self.rowInsertionAnimation = rowInsertionAnimation
        self.rowReloadAnimation = rowReloadAnimation
        self.sectionDeletionAnimation = sectionDeletionAnimation
        self.sectionInsertionAnimation = sectionInsertionAnimation
        self.sectionReloadAnimation = sectionReloadAnimation
    }
}
