//
//  ListItemStyle.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 06/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

/// Struct for ListItem styling, where styling — closure.
public struct ListItemStyle<T: ListItem> {
    
    /// The styling function that takes a `ListItem` instance
    /// and performs side-effects on it.
    public let styling: (T) -> Void
    
    public init(styling: @escaping (T) -> Void) {
        self.styling = styling
    }
    
    /// Apply this style to a ListItem.
    ///
    /// - Parameter view: the view to style
    public func apply(to listItem: T) {
        styling(listItem)
    }
    
    
    /// Apply this style to multiple views.
    ///
    /// - Parameter views: the views to style
    public func apply(to listItems: T...) {
        for listItem in listItems {
            styling(listItem)
        }
    }
    
    static public func +(left: ListItemStyle<T>, right: ListItemStyle<T>) -> ListItemStyle<T> {
        return ListItemStyle { listItem in
            left.styling(listItem)
            right.styling(listItem)
        }
    }
    
    static public func += (left: inout ListItemStyle<T>, right: ListItemStyle<T>) {
        return left = left + right
    }
}
