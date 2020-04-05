//
//  BaseAnimatedTableViewController.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 07/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

open class BaseAnimatedTableViewController: UIViewController, CreateTableProtocol, UpdateTableProtocol, ListLoaderProtocol, Delegatable {

    public var tableView: UITableView!
    public var dataSource: TableViewDataSourceAnimated<TableListSection>!
    public var syncDelegate: SyncDelegate<TableListSection>!
    
    open override func viewDidLoad() {
        viewDidLoad(withTableStyle: .plain)
    }
    
    public func viewDidLoad(withTableStyle style: UITableView.Style) {
        super.viewDidLoad()
        createAndSetupTableView(with: style)
        setupTableRepresentation()
        view.backgroundColor = tableView.backgroundColor
    }
    
    public func setDefaultDataSource() {
        let dataSource = TableViewDataSourceAnimated<TableListSection>()
        setDataSource(dataSource)
    }
    
    public func setDataSource(_ dataSource: TableViewDataSourceAnimated<TableListSection>) {
        self.dataSource = dataSource
        self.syncDelegate = SyncDelegate(dataSource: dataSource)
        tableView.dataSource = dataSource
        tableView.delegate = syncDelegate
        dataSource.delegate = self
    }
    
    open func setupTableRepresentation() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.estimatedSectionHeaderHeight = 200.0
        tableView.estimatedSectionFooterHeight = 200.0
    }
    
    public func clearData() {
        dataSource.setSections([])
        update(with: [])
    }

    public func update(with sections: [TableListSection]) {
        update(with: sections, updateAnimation: .default)
    }

    public func update(with sections: [TableListSection], updateAnimation: TableListUpdateAnimation) {
        dataSource.updateAnimation = updateAnimation
        ListUpdater.updateTableView(tableView,
                                    with: dataSource,
                                    newSections: sections,
                                    updateAnimation: updateAnimation)
    }
    
    public func showLoader() {
        tableView.showLoader(loaderType: .solid(config: .default))
    }
    
    public func showLoader(with sections: [TableListSection]) {
        tableView.isHidden = true
        update(with: sections, updateAnimation: .noAnimations)
        
        let delay = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.tableView.showLoader(loaderType: .solid(config: .default))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay * 2) {
            self.tableView.isHidden = false
        }
    }
    
    public func hideLoader() {
        tableView.hideLoader()
    }
    
    public func hideLoader(with replacingSections: [TableListSection]) {
        update(with: replacingSections, updateAnimation: .noAnimations)
        tableView.hideLoader()
    }
}
