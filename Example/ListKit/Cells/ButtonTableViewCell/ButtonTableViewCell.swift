//
//  ButtonTableViewCell.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 14.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

protocol ButtonTableViewCellDelegate: Delegatable {
    func buttonTableViewCellDidPressOnButton(_ cell: ButtonTableViewCell)
}

final class ButtonTableViewCell: UITableViewCell, TableItem, ListItemDelegatable {
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    func set(delegate: Delegatable) {
        self.delegate = delegate as? ButtonTableViewCellDelegate
    }
    
    @IBAction func handleAction(_ sender: Any) {
        delegate?.buttonTableViewCellDidPressOnButton(self)
    }
}
