//
//  ListItemStyle.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 06/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

/// Struct for UIView styling, where styling — closure.
public struct ViewStyle<T: UIView> {
    
    /// The styling function that takes a `UIView` instance
    /// and performs side-effects on it.
    public let styling: (T)-> Void
    
    public init(styling: @escaping (T) -> Void) {
        self.styling = styling
    }
    
    /// Apply this style to a UIView.
    ///
    /// - Parameter view: the view to style
    public func apply(to view: T) {
        styling(view)
    }
    
    
    /// Apply this style to multiple views.
    ///
    /// - Parameter views: the views to style
    public func apply(to views: T...) {
        for view in views {
            styling(view)
        }
    }
    
    static public func +(left: ViewStyle<T>, right: ViewStyle<T>) -> ViewStyle<T> {
        return ViewStyle { view in
            left.styling(view)
            right.styling(view)
        }
    }
}
