//
//  IconTableViewCell+Style.swift
//  TheHat
//
//  Created by Alexander Shoshiashvili on 19.04.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import Foundation
import SwiftyListKit

extension ListItemStyle where T: IconTableViewCell {
    private static var `default`: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.selectionStyle = .none
        }
    }
    
    static var profileAvatar: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.apply(.default)
            $0.heightConstraint.constant = 160
            $0.widthConstraint.constant = 160
            $0.iconImageView.apply(.cornerRadius(80))
        }
    }
}
