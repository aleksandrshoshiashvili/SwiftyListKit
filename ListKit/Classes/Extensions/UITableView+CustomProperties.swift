//
//  UITableView+CustomProperties.swift
//  DifferenceKitClone
//
//  Created by Alexander Shoshiashvili on 08.05.2020.
//

import UIKit

public extension UITableView {
    
    private struct AssociatedKeys {
        static var selectionStyle: UITableViewCell.SelectionStyle?
    }
    
    var selectionStyle: UITableViewCell.SelectionStyle? {
        get {
            guard let headers = (objc_getAssociatedObject(self, &AssociatedKeys.selectionStyle) as? UITableViewCell.SelectionStyle) else {
                return nil
            }
            return headers
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.selectionStyle,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

}
