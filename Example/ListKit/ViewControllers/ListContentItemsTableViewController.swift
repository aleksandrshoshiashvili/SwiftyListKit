//
//  ListContentItemsViewController.swift
//  ListKit_Example
//
//  Created by Alexander Shoshiashvili on 10.07.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyListKit

@available(iOS 14.0, *)
final class ListContentItemsTableViewController: BaseAnimatedTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad(withTableStyle: .grouped)
        reloadViewModels()
        view.backgroundColor = tableView.backgroundColor
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
            let data = ListContentDataModel(image: Bool.random() ? UIImage(systemName: "airplayaudio") : nil,
                                            text: .randomString(),
                                            secondaryText: Bool.random() ? .randomString() : nil,
                                            type: .random)

            // If you want to stylize icon or text —> uncomment this
            //            let imagePropertiesStyle = ListItemStyle<ListContentTableViewCell> {
            //                    guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
            //                        return
            //                    }
            //                config.imageProperties.tintColor = .darkText
            //                $0.contentConfiguration = config
            //                }
            //
            //            let textPropertiesStyle = ListItemStyle<ListContentTableViewCell> {
            //                guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
            //                    return
            //                }
            //                config.textProperties.color = .red
            //                config.secondaryTextProperties.color = .brown
            //                $0.contentConfiguration = config
            //            }
            //            let viewModel = TableItemViewModel(data: data,
            //                                               map: ListContentMapper.mapListContent,
            //                                               style: .custom(style: textPropertiesStyle + imagePropertiesStyle))

            let viewModel = TableItemViewModel(data: data,
                                               map: ListContentMapper.mapListContent)
            viewModels.append(viewModel)
        }

        let section = TableListSection(rows: viewModels)
        return section
    }

}

@available(iOS 14.0, *)
extension ListContentType {

    static var random: ListContentType {
        let randInt = Int.random(in: 0...9)
        switch randInt {
        case 0:
            return .cell
        case 1:
            return .subtitleCell
        case 2:
            return .valueCell
        case 3:
            return .plainFooter
        case 4:
            return .plainHeader
        case 5:
            return .groupedHeader
        case 6:
            return .groupedFooter
        case 7:
            return .sidebarCell
        case 8:
            return .sidebarSubtitleCell
        case 9:
            return .sidebarHeader
        default:
            return .cell
        }
    }

}
