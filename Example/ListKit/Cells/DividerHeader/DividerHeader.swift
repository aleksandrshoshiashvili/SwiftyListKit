// DividerHeader.swift
// ListKit
//
// Created by Alexander Shoshiashvili on 06/11/2018.
//Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ListKit

final public class DividerHeader: UITableViewHeaderFooterView, TableItem {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .lightGray
        backgroundColor = .lightGray
    }

}

extension DividerHeader {
    static func mapTitle(model: TitleCellDataModel, cell: DividerHeader) {
        cell.titleLabel.text = model.title
    }
}
