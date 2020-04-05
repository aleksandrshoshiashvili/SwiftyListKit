//
//  TableViewController.swift
//  TableKit
//
//  Created by Alexander Shoshiashvili on 25/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

open class BaseTableViewController<S: ListRowsProtocol>: UIViewController, Delegatable {
    
    public var tableView: UITableView!
    public var dataSource: TableViewDataSource<S>!
    public var syncDelegate: SyncDelegate<TableListSection>!
    
    open override func viewDidLoad() {
        viewDidLoad(withTableStyle: .plain)
    }
    
    public func viewDidLoad(withTableStyle style: UITableView.Style) {
        super.viewDidLoad()
        createAndSetupTableView(with: style)
        setupDefaultTableRepresentation()
        view.backgroundColor = tableView.backgroundColor
        
        assert(dataSource == nil, "You should set Data source via calling `setDataSource(_ dataSource: TableViewDataSourceWithListSections<S>)` method")
    }
    
    public func createAndSetupTableView(with style: UITableView.Style) {
        tableView = TableView(frame: view.frame, style: style)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        view.sendSubviewToBack(tableView)
    }
    
    public func setDataSource(_ dataSource: TableViewDataSource<S>) {
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        dataSource.delegate = self
    }
    
    public func setDelegate(_ delegate: UITableViewDelegate) {
        tableView.delegate = delegate
    }
    
    open func setupDefaultTableRepresentation() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.estimatedSectionHeaderHeight = 200.0
        tableView.estimatedSectionFooterHeight = 200.0
    }
}
