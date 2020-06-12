//
//  ExamplesListViewController.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 25/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

class ExamplesListViewController: BaseAnimatedTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad(withTableStyle: .grouped)
        showExamplesOptions()
        navigationItem.title = "Examples"
        view.backgroundColor = tableView.backgroundColor
    }
    
    func showExamplesOptions() {
        let sections = getExamplesOptionsSections()
        update(with: sections)
        handleDidSelectActions()
        syncDelegate.heightForFooterAtSection = { _, _, _ in
            return 24
        }
    }
    
    func getExamplesOptionsSections() -> [TableListSection] {
        let options = [("Plain with animations", "PlainExampleViewController"),
                       ("Grouped with animations", "GroupedExampleViewController"),
                       ("Collection view", "CollectionExampleViewController"),
                       ("Table View as part of view", "TableViewAsPartViewController"),
                       ("View controller without base class", "ControllerWithProtocolOnly"),
                       ("Profile view controller", "ProfileViewController")]
        
        var sections: [TableListSection] = []
        
        for option in options {
            let oneLineDataModel = TextDataModel(tag: option.1, text: option.0)
            
            let style: ListItemStyle<OneTitleTableViewCell> = ListItemStyle<OneTitleTableViewCell> {
                $0.titleLabel.textColor = .black
            }
            
            let cellViewModel = TableItemViewModel(data: oneLineDataModel,
                                                   map: OneTitleTableViewCell.map1,
                                                   style: .custom(style: style),
                                                   heightStyle: .static(height: 44))
            let section = TableListSection(rows: [cellViewModel])
            sections.append(section)
        }
        
        return sections
    }
    
    // MARK: - Actions
    
    func handleDidSelectActions() {
        syncDelegate.didSelectRow = { [weak self] _, indexPath, model in
            guard let tag = model?.data.tag as? String,
                let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String,
                let any = NSClassFromString(appName + "." + tag),
                let vc = any as? UIViewController.Type else {
                    return
            }
            self?.navigationController?.pushViewController(vc.init(), animated: true)
        }
    }
    
}
