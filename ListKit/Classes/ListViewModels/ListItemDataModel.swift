//
//  ListItemViewModel.swift
//  TableKit
//
//  Created by Alexander Shoshiashvili on 25/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import Foundation
import UIKit

/// ListItemDataModel represent protocol for Data containers for list item
public protocol ListItemDataModel: StringHashable {
    /// Tag is something like userInfo
    /// Usually tag needed to distinguish one data model from another, so it stored `id`
    var tag: Any? { get }
}

extension ListItemDataModel {
    
    public var tag: Any? {
        get {
            return nil
        }
    }
    
    public var hashString: String {
        get {
            var hash: String = ""
            let children = Mirror(reflecting: self).children
            
            children.forEach { (child) in
                let key = child.label ?? ""
                var value = ""
                if let stringValue = child.value as? String {
                    value += stringValue
                } else if let stringConvertibleValue = child.value as? CustomStringConvertible {
                    value += stringConvertibleValue.description
                }
                hash += "\(key)-\(value)"
            }
            
            return hash
        }
    }
    
}

struct EmptyDataViewModel: ListItemDataModel {}
