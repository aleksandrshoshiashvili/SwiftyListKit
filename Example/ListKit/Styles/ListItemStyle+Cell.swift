//
//  ListItemStyle+Cell.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 12/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import ListKit

extension ListItemStyle where T: OneTitleTableViewCell {
    
    static var `default`: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.dummyImageView.apply(.rounded)
            $0.titleLabel.apply(.uppercasedAlert)
        }
    }
    
    static var squareIconAlertTitle: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.dummyImageView.apply(.squared)
            $0.titleLabel.apply(.uppercasedAlert)
        }
    }
    
}
