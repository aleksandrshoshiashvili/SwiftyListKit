//
//  StylizableProtocol.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 06/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

/// This protocol extend UIView to support `apply(_ style:_)`
public protocol StylizableProtocol {}

extension UIView: StylizableProtocol { }

public extension StylizableProtocol where Self: UIView {
    func apply(_ style: ViewStyle<Self>) {
        style.apply(to: self)
    }
}

public extension StylizableProtocol where Self: ListItem {
    func apply(_ style: ListItemStyle<Self>) {
        style.apply(to: self)
    }
}
