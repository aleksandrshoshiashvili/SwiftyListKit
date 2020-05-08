//
//  ListUpdater.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 07/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import DifferenceKitClone

class ListUpdater {
    
    static func updateTableView<S: ListSectionProtocol>(_ tableView: UITableView,
                                                 with dataSource: TableViewDataSourceAnimated<S>,
                                                 newSections: [S],
                                                 updateAnimation: TableListUpdateAnimation) {
        DispatchQueue.main.async {
            // if view is not in view hierarchy, performing batch updates will crash the app
            if tableView.window == nil {
                dataSource.setSections(newSections)
                tableView.reloadData()
                return
            }
            
            let oldSections = dataSource.sectionModels.convertToDiffable()
                .map({ (section) in
                    return ArraySection(model: section, elements: section.rows)
                })
            
            let newDiffableSections = newSections.convertToDiffable()
                .map({ (section) in
                    return ArraySection(model: section, elements: section.rows)
                })
            
            let setSectionsBlock: ([ArraySection<DiffableListSection<S>, TableItemViewModel>]) -> Void = { data in
                let newSections = data.map({ (section) -> S in
                    let convertedSection = S.init(header: section.model.header,
                                                  footer: section.model.footer,
                                                  rows: section.model.rows)
                    return convertedSection
                })
                dataSource.setSections(newSections)
            }
            
            switch updateAnimation {
            case .default:
                let changeset = StagedChangeset(source: oldSections, target: newDiffableSections)
                tableView.reload(using: changeset, with: .fade, setData: { setSectionsBlock($0) })
            case .noAnimations:
                dataSource.setSections(newSections)
                tableView.reloadData()
            case .standard(let configuration):
                let changeset = StagedChangeset(source: oldSections, target: newDiffableSections)
                tableView.reload(using: changeset, with: configuration, setData: { setSectionsBlock($0) })
            case .custom(let configuration):
                let changeset = StagedChangeset(source: oldSections, target: newDiffableSections)
                tableView.reload(using: changeset, with: .none, setData: { setSectionsBlock($0) })
                configuration.animate(tableView: tableView)
            }
        }
    }
    
    static func updateCollectionViewView<S: ListSectionProtocol>(_ collectionView: UICollectionView,
                                                        with dataSource: CollectionViewDataSourceAnimated<S>,
                                                        newSections: [S],
                                                        updateAnimation: CollectionListUpdateAnimation) {
        DispatchQueue.main.async {
            // if view is not in view hierarchy, performing batch updates will crash the app
            if collectionView.window == nil {
                dataSource.setSections(newSections)
                collectionView.reloadData()
                return
            }
            
            let oldSections = dataSource.sectionModels.convertToDiffable()
                .map({ (section) in
                    return ArraySection(model: section, elements: section.rows)
                })
            
            let newDiffableSections = newSections.convertToDiffable()
                .map({ (section) in
                    return ArraySection(model: section, elements: section.rows)
                })
            
            let setSectionsBlock: ([ArraySection<DiffableListSection<S>, CollectionItemViewModel>]) -> Void = { data in
                let newSections = data.map({ (section) -> S in
                    let convertedSection = S.init(header: section.model.header,
                                                  footer: section.model.footer,
                                                  rows: section.model.rows)
                    return convertedSection
                })
                dataSource.setSections(newSections)
            }
            
            switch updateAnimation {
            case .default:
                let changeset = StagedChangeset(source: oldSections, target: newDiffableSections)
                collectionView.reload(using: changeset, setData: { setSectionsBlock($0) })
            case .noAnimations:
                dataSource.setSections(newSections)
                collectionView.reloadData()
            }
        }
    }
    
}
