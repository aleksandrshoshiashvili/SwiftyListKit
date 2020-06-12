//
//  TitleTableViewCell+Styles.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

extension ListItemStyle where T: OneTitleTableViewCell {
    
    static var notSelectable: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.selectionStyle = .none
        }
    }
    
    static var selectable: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.selectionStyle = .default
        }
    }
    
    static var description: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.accessoryType = .none
            $0.titleLabel.apply(.ih4 + .infiniteNumberOfLines)
            $0.apply(.notSelectable)
        }
    }
    
    static var menuItem: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.accessoryType = .disclosureIndicator
            $0.titleLabel.apply(.rh1)
            $0.apply(.selectable)
        }
    }
    
    static var appItem: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.accessoryType = .none
            $0.titleLabel.apply(.rh1)
            $0.apply(.notSelectable)
            $0.configureSeparator(with: .singleFullWidthLineBottom)
        }
    }
    
    static var name: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.accessoryType = .none
            $0.titleLabel.apply(.dbh1)
            $0.apply(.notSelectable)
        }
    }
    
    static var info: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.accessoryType = .none
            $0.titleLabel.apply(.ih3)
            $0.apply(.notSelectable)
        }
    }
    
}
