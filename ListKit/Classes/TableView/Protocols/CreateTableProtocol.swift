//
//  CreateTableProtocol.swift
//  TableKit
//
//  Created by Alexander Shoshiashvili on 25/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

/// This helper protocol with default implementation used by BaseTableViewControllers
public protocol CreateTableProtocol: SetupTableProtocol {
    func createAndSetupTableView(with style: UITableView.Style)
}

extension CreateTableProtocol where Self: BaseAnimatedTableViewController {
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
        setupTableView()
    }
}

extension CreateTableProtocol where Self: UIView {
    public func createAndSetupTableView(with style: UITableView.Style) {
        tableView = TableView(frame: self.frame, style: style)
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
        self.sendSubviewToBack(tableView)
        setupTableView()
    }
}
