//
//  GroupedExampleViewController.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 25/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

final class GroupedExampleViewController: BaseAnimatedTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad(withTableStyle: .grouped)
        reloadViewModels()
    }
    
    // MARK: - Generate random sections
    
    private func reloadViewModels() {
        var sections: [TableListSection] = []
        
        for _ in 0 ..< 5 {
            let section = getSectionWithRandomViewModels()
            sections.append(section)
        }
        
        update(with: sections)
    }
    
    // MARK: - Generate random rows/headers
    
    private func getSectionWithRandomViewModels() -> TableListSection {
        var viewModels: [TableItemViewModel] = []
        
        for _ in 0 ..< 20 {
            // Init by cell type. Use for cell that have only `static` elements
            let cellViewModel = TableItemViewModel(itemType: OneTitleTableViewCell.self)
            
            viewModels.append(cellViewModel)
        }
        
        // Header
        
        var dividerDataModel = TitleCellDataModel()
        dividerDataModel.title = .randomString()
        
        let headerViewModel = TableItemViewModel(data: dividerDataModel,
                                                map: DividerHeader.mapTitle)
        
        let section = TableListSection(header: headerViewModel,
                                  footer: nil,
                                  rows: viewModels)
        return section
    }
    
}
