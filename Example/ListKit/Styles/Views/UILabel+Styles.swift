//
//  UILabel+Styles.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 14.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

extension ViewStyle where T: UILabel {
  
    static var infiniteNumberOfLines: ViewStyle<T> {
        return ViewStyle<T> {
            $0.numberOfLines = 0
        }
    }
    
    static var ih4: ViewStyle<T> {
        return ViewStyle<T> {
            $0.font = .italic(size: 14.0)
        }
    }
    
    static var ih3: ViewStyle<T> {
        return ViewStyle<T> {
            $0.font = .italic(size: 16.0)
        }
    }
    
    static var rh1: ViewStyle<T> {
        return ViewStyle<T> {
            $0.font = .h1Regular()
        }
    }
    
    static var dbh3: ViewStyle<T> {
        return ViewStyle<T> {
            $0.font = .demiBold(size: 16)
        }
    }
    
    static var dbh1: ViewStyle<T> {
        return ViewStyle<T> {
            $0.font = .demiBold(size: 20)
        }
    }
}
