//
//  ViewStyle+Cell.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 12/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

extension ViewStyle where T: UITableViewCell {
    static func filled(with color: UIColor = .white) -> ViewStyle<T> {
        return ViewStyle<T> {
            $0.contentView.backgroundColor = color
        }
    }
    
    static var rounded: ViewStyle<T> {
        return ViewStyle<T> {
            $0.layer.cornerRadius = 4.0
        }
    }
}
