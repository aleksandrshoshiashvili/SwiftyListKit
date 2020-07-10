//
//  ListContentTableViewCell.swift
//  DifferenceKit
//
//  Created by Alexander Shoshiashvili on 10.07.20.
//

import UIKit

@available(iOS 14.0, *)
public class ListContentTableViewCell: TableViewCell, TableItem {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "ListContentTableViewCell")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
