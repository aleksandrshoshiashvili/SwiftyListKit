//
//  ButtonTableViewCell+Style.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 14.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

import Foundation
import SwiftyListKit

extension ListItemStyle where T: ButtonTableViewCell {
    private static var `default`: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.selectionStyle = .none
        }
    }
    
    static var add: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.apply(.default)
            $0.heightConstraint.constant = 44
            $0.topConstraint.constant = 8
            $0.actionButton.apply(.action)
            $0.actionButton.contentHorizontalAlignment = .center
            $0.actionButton.backgroundColor = .primaryColor
            $0.actionButton.apply(.roundedСorners)
        }
    }
    
    static var textual: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.apply(.default)
            $0.backgroundColor = .white
            $0.heightConstraint.constant = 24
            $0.topConstraint.constant = 0
            $0.actionButton.apply(.textual)
            if #available(iOS 11.0, *) {
                $0.actionButton.contentHorizontalAlignment = .leading
            }
            $0.actionButton.backgroundColor = .white
            $0.actionButton.apply(.roundedOff)
        }
    }
    
}
