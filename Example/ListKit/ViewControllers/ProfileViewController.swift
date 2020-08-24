//
//  ResultViewController.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

enum ActionType {
    case readMore
    case add
}

final class ProfileViewController: BaseAnimatedTableViewController {
    
    var user: User = .iosDeveloper
    var showFullDescription = false
    let mapper = ResultViewModelsMapper()
    
    override func viewDidLoad() {
        super.viewDidLoad(withTableStyle: .plain)
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        // reload
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh,
                                           target: self,
                                           action: #selector(reloadData))
        navigationItem.rightBarButtonItem = reloadButton
        
        updateView()
    }
    
    // MARK: - Actions
    
    @objc private func reloadData() {
        user = .getRandomUser()
        showFullDescription = false
        updateView()
    }
    
    func updateView() {
        let sections = mapper.getSections(for: user, showFullDescription: showFullDescription)
        update(with: sections)
    }
    
}

// MARK: - ButtonTableViewCellDelegate

extension ProfileViewController: ButtonTableViewCellDelegate {
    func buttonTableViewCellDidPressOnButton(_ cell: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell), let tag = dataSource.getViewModel(for: indexPath)?.data.tag as? ActionType else { return }
        switch tag {
        case .readMore:
            showFullDescription.toggle()
            updateView()
        case .add:
            user.favouriteApps.append(.randomString(length: 20))
            updateView()
        }
    }
}

// MARK: - MAPPER

struct ResultViewModelsMapper {

    func getSections(for user: User, showFullDescription: Bool) -> [TableListSection] {
        var sections: [TableListSection] = []

        let avatar = LocalIconDataModel(localIconName: user.imageName)
        let avatarViewModel = TableItemViewModel(data: avatar, map: IconCellMapper.map, style: .custom(style: .profileAvatar))

        let name = TextDataModel(text: user.name)
        let nameViewModel = TableItemViewModel(data: name, map: TitleCellMapper.map, style: .custom(style: .name))

        let info = TextDataModel(text: user.info)
        let infoViewModel = TableItemViewModel(data: info, map: TitleCellMapper.map, style: .custom(style: .info))

        sections.append(TableListSection(rows: [avatarViewModel, nameViewModel, infoViewModel]))

        let aboutMeHeader = header(title: "About me")

        let aboutMeString = showFullDescription ? user.aboutMe : String(user.aboutMe.prefix(140))
        let aboutMe = TextDataModel(text: aboutMeString)
        let description = TableItemViewModel(data: aboutMe, map: TitleCellMapper.map, postLayoutStyle: .description)

        let readMoreString = showFullDescription ? "Hide" : "Read more"
        let readMore = TextDataModel(tag: ActionType.readMore, text: readMoreString)
        let readMoreViewModel = TableItemViewModel(data: readMore, map: ButtonCellMapper.map, postLayoutStyle: .textual)

        sections.append(TableListSection(header: aboutMeHeader, rows: [description, readMoreViewModel]))

        let appsHeader = header(title: "Favorite apps")

        var appsViewModels: [TableItemViewModel] = []
        let favouriteAppsViewModels = user.favouriteApps.map { (appName) -> TableItemViewModel in
            let app = TextDataModel(text: appName)
            return TableItemViewModel(data: app, map: TitleCellMapper.map, style: .custom(style: .appItem))
        }
        appsViewModels.append(contentsOf: favouriteAppsViewModels)

        let add = TextDataModel(tag: ActionType.add, text: "Add")
        let addViewModel = TableItemViewModel(data: add, map: ButtonCellMapper.map, postLayoutStyle: .add)
        appsViewModels.append(addViewModel)

        sections.append(TableListSection(header: appsHeader, rows: appsViewModels))
        return sections
    }

    // MARK: - Private

    private func header(title: String) -> TableItemViewModel {
        let data = TextDataModel(text: title)
        return TableItemViewModel(data: data, map: HeaderMapper.map)
    }
}
