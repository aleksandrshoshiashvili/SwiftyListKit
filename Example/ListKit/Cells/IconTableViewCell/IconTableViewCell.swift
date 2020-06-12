//
//  IconTableViewCell.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

final class IconTableViewCell: UITableViewCell, TableItem {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
}
