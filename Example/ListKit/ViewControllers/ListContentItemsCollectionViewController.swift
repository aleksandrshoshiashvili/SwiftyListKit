//
//  ListContentItemsCollectionViewController.swift
//  ListKit_Example
//
//  Created by Alexander Shoshiashvili on 22.07.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyListKit

@available(iOS 14.0, *)
final class ListContentItemsCollectionViewController: BaseAnimatedCollectionViewController {

    override func viewDidLoad() {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        super.viewDidLoad(withLayout: layout)
        
        reloadViewModels()
        view.backgroundColor = collectionView.backgroundColor
    }

    // MARK: - Generate random sections

    private func reloadViewModels() {
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
            let data = ListContentDataModel(image: Bool.random() ? UIImage(systemName: "airplayaudio") : nil,
                                            text: .randomString(),
                                            secondaryText: Bool.random() ? .randomString() : nil,
                                            type: .random)

            // If you want to stylize icon or text —> uncomment this
            //            let imagePropertiesStyle = ListItemStyle<ListContentCollectionViewCell> {
            //                guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
            //                    return
            //                }
            //                config.imageProperties.tintColor = .darkText
            //                $0.contentConfiguration = config
            //            }
            //
            //            let textPropertiesStyle = ListItemStyle<ListContentCollectionViewCell> {
            //                guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
            //                    return
            //                }
            //                config.textProperties.color = .red
            //                config.secondaryTextProperties.color = .brown
            //                $0.contentConfiguration = config
            //            }
            //            let viewModel = CollectionItemViewModel(data: data,
            //                                                    map: ListContentMapper.mapListContent,
            //                                                    style: .custom(style: textPropertiesStyle + imagePropertiesStyle))

            let viewModel = CollectionItemViewModel(data: data,
                                               map: ListContentMapper.mapListContent)
            viewModels.append(viewModel)
        }

        let section = CollectionListSection(rows: viewModels)
        return section
    }

}
