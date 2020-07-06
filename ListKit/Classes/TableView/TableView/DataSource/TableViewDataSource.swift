//
//  TableViewDataSourceWithListSections.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 06/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

/// Base Data Source, works with ListRowsProtocol
open class TableViewDataSource<S: ListRowsProtocol>
    : NSObject
    , UITableViewDataSource {
    
    public typealias I = S.ItemModel
    public typealias Section = S
    
    public typealias ConfigureCell = (TableViewDataSource<S>, UITableView, IndexPath, I) -> UITableViewCell
    public typealias TitleForHeaderInSection = (TableViewDataSource<S>, Int) -> String?
    public typealias TitleForFooterInSection = (TableViewDataSource<S>, Int) -> String?
    public typealias CanEditRowAtIndexPath = (TableViewDataSource<S>, IndexPath) -> Bool
    public typealias CanMoveRowAtIndexPath = (TableViewDataSource<S>, IndexPath) -> Bool
    public typealias SectionIndexTitles = (TableViewDataSource<S>) -> [String]?
    public typealias SectionForSectionIndexTitle = (TableViewDataSource<S>, _ title: String, _ index: Int) -> Int
    public typealias DisplayCellAtIndexPath = ((_ tableView: UITableView, _ indexPath: IndexPath, _ cell: UITableViewCell, _ model: I) -> Void)

    public init(
        configureCell: @escaping ConfigureCell,
        titleForHeaderInSection: @escaping  TitleForHeaderInSection = { _, _ in nil },
        titleForFooterInSection: @escaping TitleForFooterInSection = { _, _ in nil },
        canEditRowAtIndexPath: @escaping CanEditRowAtIndexPath = { _, _ in false },
        canMoveRowAtIndexPath: @escaping CanMoveRowAtIndexPath = { _, _ in false },
        sectionIndexTitles: @escaping SectionIndexTitles = { _ in nil },
        sectionForSectionIndexTitle: @escaping SectionForSectionIndexTitle = { _, _, index in index }
        ) {
        self.configureCell = configureCell
        self.titleForHeaderInSection = titleForHeaderInSection
        self.titleForFooterInSection = titleForFooterInSection
        self.canEditRowAtIndexPath = canEditRowAtIndexPath
        self.canMoveRowAtIndexPath = canMoveRowAtIndexPath
        self.sectionIndexTitles = sectionIndexTitles
        self.sectionForSectionIndexTitle = sectionForSectionIndexTitle
    }
    
    weak public var delegate: Delegatable?
    
    // This structure exists because model can be mutable
    // In that case current state value should be preserved.
    // The state that needs to be preserved is ordering of items in section
    // and their relationship with section.
    // If particular item is mutable, that is irrelevant for this logic to function
    // properly.
    
    open var sectionModels: [S] = []
    
    open subscript(section: Int) -> S {
        return sectionModels[section]
    }
    
    open subscript(indexPath: IndexPath) -> I {
        get {
            return self.sectionModels[indexPath.section].rows[indexPath.row]
        }
        set(item) {
            var section = sectionModels[indexPath.section]
            section.rows[indexPath.item] = item
            sectionModels[indexPath.section] = section
        }
    }
    
    open func model(at indexPath: IndexPath) throws -> Any {
        return self[indexPath]
    }
    
    open func setSections(_ sections: [S]) {
        sectionModels = sections
    }
    
    open var configureCell: ConfigureCell {
        didSet {
        }
    }
    
    open var titleForHeaderInSection: TitleForHeaderInSection {
        didSet {
            
        }
    }
    open var titleForFooterInSection: TitleForFooterInSection {
        didSet {
            
        }
    }
    
    open var canEditRowAtIndexPath: CanEditRowAtIndexPath {
        didSet {
            
        }
    }
    open var canMoveRowAtIndexPath: CanMoveRowAtIndexPath {
        didSet {
            
        }
    }
    
    open var rowAnimation: UITableView.RowAnimation = .automatic
    
    open var sectionIndexTitles: SectionIndexTitles {
        didSet {
            
        }
    }
    open var sectionForSectionIndexTitle: SectionForSectionIndexTitle {
        didSet {
            
        }
    }

    open var onCellConfigure: DisplayCellAtIndexPath?
    
    // UITableViewDataSource
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sectionModels.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard sectionModels.count > section else { return 0 }
        return sectionModels[section].rows.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        precondition(indexPath.item < sectionModels[indexPath.section].rows.count)
        let cell = configureCell(self, tableView, indexPath, self[indexPath])
        onCellConfigure?(tableView, indexPath, cell, self[indexPath])
        return cell

    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleForHeaderInSection(self, section)
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return titleForFooterInSection(self, section)
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canEditRowAtIndexPath(self, indexPath)
    }
    
    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return canMoveRowAtIndexPath(self, indexPath)
    }
    
    open func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        sectionModels.moveFromSourceIndexPath(sourceIndexPath, destinationIndexPath: destinationIndexPath)
    }
    
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionIndexTitles(self)
    }
    
    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionForSectionIndexTitle(self, title, index)
    }
    
    public func registerListItem(withIdentifier identifier: String, type: TableViewRegistrator.TableObjectType, tableView: UITableView) {
        if let tableView = tableView as? TableView {
            tableView.registrator.register(withReuseIdentifier: identifier,
                                           forType: type)
        }
    }

}
