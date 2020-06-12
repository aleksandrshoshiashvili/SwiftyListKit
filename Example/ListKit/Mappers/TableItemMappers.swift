//
//  TableItemMappers.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

// MARK: - Title

struct TitleCellMapper: Mapper {
    static func map(data: TextDataModel, cell: OneTitleTableViewCell) {
        cell.titleLabel.text = data.text
    }
}

// MARK: - Icon

struct IconCellMapper: Mapper {
    static func map(data: LocalIconDataModel, cell: IconTableViewCell) {
        cell.iconImageView.image = UIImage(named: data.localIconName)
    }
}

// MARK: - Button

struct ButtonCellMapper: Mapper {
    static func map(data: TextDataModel, cell: ButtonTableViewCell) {
        cell.actionButton.setTitle(data.text, for: .normal)
    }
}

// MARK: - Header

struct HeaderMapper: Mapper {
    static func map(data: TextDataModel, cell: DividerHeader) {
        cell.titleLabel.text = data.text
    }
}



