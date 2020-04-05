//
//  TableViewDDM.swift
//  TableKit
//
//  Created by Alexander Shoshiashvili on 23/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

// MARK: - TableViewDataSource

/// Data Source that support animated update, works with ListSection
open class TableViewDataSourceAnimated<S: TableListSection>: TableViewDataSource<S> {
    public typealias Section = S
    public typealias ItemModel = S.ItemModel
    
    public var sections: [Section] = []
    
    public var updateAnimation: TableListUpdateAnimation
    
    public init(
        configureCell: @escaping ConfigureCell = { (dataSource, tableView, indexPath, viewModel) -> UITableViewCell in
        
        dataSource.registerListItem(withIdentifier: viewModel.reuseIdentifier,
                                    type: .cell,
                                    tableView: tableView)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier)
        let listItem = cell as! ListItem
        
        if let map = viewModel.map {
            map(viewModel.data, listItem)
        } else if let defaultDataMap = type(of: listItem).defaultDataMap {
            defaultDataMap(viewModel.data, listItem)
        }
        
        if let mapStyle = viewModel.style {
            mapStyle(listItem)
        } else if let mapDefaultStyle = type(of: listItem).defaultStyle {
            mapDefaultStyle(listItem)
        }

        if let delegatableItem = listItem as? ListItemDelegatable, let delegate = dataSource.delegate {
            delegatableItem.set(delegate: delegate)
        }
        
        return listItem as! UITableViewCell
        },
        titleForHeaderInSection: @escaping  TitleForHeaderInSection = { _, _ in nil },
        titleForFooterInSection: @escaping TitleForFooterInSection = { _, _ in nil },
        canEditRowAtIndexPath: @escaping CanEditRowAtIndexPath = { _, _ in false },
        canMoveRowAtIndexPath: @escaping CanMoveRowAtIndexPath = { _, _ in false },
        sectionIndexTitles: @escaping SectionIndexTitles = { _ in nil },
        sectionForSectionIndexTitle: @escaping SectionForSectionIndexTitle = { _, _, index in index },
        updateAnimation: TableListUpdateAnimation = .default
        ) {
        
        self.updateAnimation = updateAnimation
        super.init(
            configureCell: configureCell,
            titleForHeaderInSection: titleForHeaderInSection,
            titleForFooterInSection: titleForFooterInSection,
            canEditRowAtIndexPath: canEditRowAtIndexPath,
            canMoveRowAtIndexPath: canMoveRowAtIndexPath,
            sectionIndexTitles: sectionIndexTitles,
            sectionForSectionIndexTitle: sectionForSectionIndexTitle
        )
    }
    
    public func getSections() -> [Section] {
        return sections
    }
    
    public func update(with sections: [Section]) {
        self.sections = sections
    }
    
    public func getViewModel(for indexPath: IndexPath) -> ItemModel? {
        guard let section = sections[safe: indexPath.section],
            let viewModel = section.rows[safe: indexPath.row] else {
                return nil
        }
        return viewModel
    }
    
}
