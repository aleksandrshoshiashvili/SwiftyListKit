// OneTitleTableViewCell.swift
// SwiftyListKit
//
// Created by Alexander Shoshiashvili on 06/11/2018.
//Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import ListKit

public class OneTitleTableViewCell: UITableViewCell, TableItem {
    
    @IBOutlet weak var titleLabel: UILabel!

    let dummyImageView = UIImageView.init()
    
    public static var defaultStyle: MapStyleToItemClosure? {
        return { item in
            guard let item = item as? OneTitleTableViewCell else { return }
            item.titleLabel.textColor = .black
            item.titleLabel.backgroundColor = .yellow
            item.dummyImageView.backgroundColor = .blue
        }
    }
}

extension OneTitleTableViewCell {
    static func map1(model: TitleCellDataModel, cell: OneTitleTableViewCell) {
        cell.titleLabel.text = model.title
    }
    
    static func map2(model: ImageCellDataModel, cell: OneTitleTableViewCell) {
        cell.dummyImageView.image = model.image
    }
}
