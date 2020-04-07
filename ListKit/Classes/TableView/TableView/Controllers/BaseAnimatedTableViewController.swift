//
//  BaseAnimatedTableViewController.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 07/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

open class BaseAnimatedTableViewController: UIViewController, AnimatedTableListProtocol {
    public var tableView: UITableView!
    public var dataSource: TableViewDataSourceAnimated<TableListSection>!
    public var syncDelegate: SyncDelegate<TableListSection>!
    
    open override func viewDidLoad() {
        viewDidLoad(withTableStyle: .plain)
    }
    
    public func viewDidLoad(withTableStyle style: UITableView.Style) {
        super.viewDidLoad()
        setup(withTableStyle: style)
    }
}
