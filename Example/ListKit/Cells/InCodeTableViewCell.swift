//
//  InCodeTableViewCell.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 26/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import ListKit

final class InCodeTableViewCell: UITableViewCell, TableItem {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "InCodeTableViewCell")
        textLabel?.text = .randomString()
        accessoryType = .detailButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension InCodeTableViewCell {
    static func map(model: TitleCellDataModel, cell: InCodeTableViewCell) {
        cell.textLabel?.text = model.title
    }
}
