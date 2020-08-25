//
//  AnimatedTableListProtocol.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 07.04.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

public protocol AnimatedTableListProtocol: CreateTableProtocol, UpdateTableProtocol, ListLoaderProtocol, Delegatable {
    
    var tableView: UITableView! { get set }
    var dataSource: TableViewDataSourceAnimated<TableListSection>! { get set }
    var syncDelegate: SyncDelegate<TableListSection>! { get set }
    
    func setup(withTableStyle style: UITableView.Style)
    func setupTableRepresentation()
    func update(with sections: [TableListSection])

    func getTag<T>(for cell: UITableViewCell) -> T?
}

public extension AnimatedTableListProtocol {
    func setup(withTableStyle style: UITableView.Style) {
        createAndSetupTableView(with: style)
        setupTableRepresentation()
    }
    
    func setupTableRepresentation() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.estimatedSectionHeaderHeight = 200.0
        tableView.estimatedSectionFooterHeight = 200.0
    }
    
    func clearData() {
        dataSource.setSections([])
        update(with: [])
    }

    func update(with sections: [TableListSection]) {
        update(with: sections, updateAnimation: .default)
    }

    func update(with sections: [TableListSection], updateAnimation: TableListUpdateAnimation) {
        dataSource.updateAnimation = updateAnimation
        ListUpdater.updateTableView(tableView,
                                    with: dataSource,
                                    newSections: sections,
                                    updateAnimation: updateAnimation)
    }
    
    func showLoader() {
        tableView.showLoader(loaderType: .solid(config: .default))
    }
    
    func showLoader(with sections: [TableListSection]) {
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
    
    func hideLoader() {
        tableView.hideLoader()
    }
    
    func hideLoader(with replacingSections: [TableListSection]) {
        update(with: replacingSections, updateAnimation: .noAnimations)
        tableView.hideLoader()
    }
    
    func setDefaultDataSource() {
        let dataSource = TableViewDataSourceAnimated<TableListSection>()
        setDataSource(dataSource)
    }
    
    func setDataSource(_ dataSource: TableViewDataSourceAnimated<TableListSection>) {
        self.dataSource = dataSource
        self.syncDelegate = SyncDelegate(dataSource: dataSource)
        tableView.dataSource = dataSource
        tableView.delegate = syncDelegate
        dataSource.delegate = self
    }

    func getTag<T>(for cell: UITableViewCell) -> T? {
        guard let indexPath = tableView.indexPath(for: cell),
            let viewModel = dataSource.getViewModel(for: indexPath),
            let tag = viewModel.data.tag as? T else {
                return nil
        }
        return tag
    }
}
