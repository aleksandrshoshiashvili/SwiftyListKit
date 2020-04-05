//
//  SetupTableProtocol.swift
//  TableKit
//
//  Created by Alexander Shoshiashvili on 25/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

/// This helper protocol with default implementation used by BaseTableViewControllers
public protocol SetupTableProtocol: class {
    var tableView: UITableView! { get set }
    func setupTableView()
}

extension SetupTableProtocol where Self: BaseAnimatedTableViewController {
    public func setupTableView() {
        setDefaultDataSource()
    }
}
