//
//  UIFont+Extensions.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

extension UIFont {

    static func demiBold(size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-DemiBold", size: size)!
    }
    
    static func regular(size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-Regular", size: size)!
    }
    
    static func italic(size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-Italic", size: size)!
    }
    
    static func h1Regular() -> UIFont {
        return regular(size: 20)
    }
    
    static func h3Regular() -> UIFont {
        return regular(size: 16)
    }
}
