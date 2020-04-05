//
//  ListItemHeightStyle.swift
//  ListKit
//
//  Created by Alexander Shoshiashvili on 09/12/2018.
//

import UIKit

/// Determines how high the list item will be drawn
public enum TableItemHeightStyle {
    /// return UITableView.automaticDimension
    case automatic
    /// return fixed `height`
    case `static`(height: CGFloat)
}
