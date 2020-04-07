//
//  TableViewAsPartViewController.swift
//  ListKit_Example
//
//  Created by Alexander Shoshiashvili on 07.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ListKit

class TableContainerView: UIView, AnimatedTableListProtocol {
    
    var tableView: UITableView!
    var dataSource: TableViewDataSourceAnimated<TableListSection>!
    var syncDelegate: SyncDelegate<TableListSection>!
    
}

final class TableViewAsPartViewController: UIViewController {
    
    var tableContainerView: TableContainerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tableContainerView = TableContainerView()
        tableContainerView.setup(withTableStyle: .plain)
        tableContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableContainerView)
        
        tableContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableContainerView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        tableContainerView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        self.tableContainerView = tableContainerView
        reloadViewModels()
    }
    
    private func reloadViewModels() {
        tableContainerView?.update(with: [getSectionWithRandomViewModels()])
    }
    
    // MARK: - Generate random rows/headers
    
    private func getSectionWithRandomViewModels() -> TableListSection {
        var rowViewModels: [TableItemViewModel] = []
        
        for _ in 0 ..< Int.random(in: 0...100) {
            let oneLineDataModel = TitleCellDataModel(title: .randomString())
            let cellViewModel = TableItemViewModel(data: oneLineDataModel,
                                                  map: OneTitleTableViewCell.map1,
                                                  style: .default)
            rowViewModels.append(cellViewModel)
        }
        
        let section = TableListSection(rows: rowViewModels)
        return section
    }

}
