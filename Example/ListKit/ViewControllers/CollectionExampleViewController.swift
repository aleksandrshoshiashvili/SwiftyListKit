//
//  CollectionExampleViewController.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/04/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

final class CollectionExampleViewController: BaseAnimatedCollectionViewController {
    
    override func viewDidLoad() {
        let layout = UICollectionViewFlowLayout()
        super.viewDidLoad(withLayout: layout)
        
        let button = UIBarButtonItem(barButtonSystemItem: .refresh,
                                     target: self,
                                     action: #selector(reloadViewModels))
        navigationItem.setRightBarButton(button, animated: false)
        
        reloadViewModels()
    }
    
    // MARK: - Generate random sections
    
    @objc private func reloadViewModels() {
        var sections: [CollectionListSection] = []
        
        for _ in 0 ..< 5 {
            let section = getSectionWithRandomViewModels()
            sections.append(section)
        }
        
        update(with: sections)
    }
    
    // MARK: - Generate random rows/headers
    
    private func getSectionWithRandomViewModels() -> CollectionListSection {
        var viewModels: [CollectionItemViewModel] = []
        
        for _ in 0 ..< 20 {
            // Init by cell type. Use for cell that have only `static` elements
            let data = TitleAndImageDataModel(title: .randomString(),
                                              image: UIImage(named: "backdropPlaceholder"))
            let cellViewModel = CollectionItemViewModel(data: data, map: IconWithTitleCollectionViewCell.map)
            viewModels.append(cellViewModel)
        }
        
        let section = CollectionListSection(header: nil,
                                            footer: nil,
                                            rows: viewModels)
        return section
    }
    
}
