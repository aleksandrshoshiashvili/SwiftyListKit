//
//  UIButton+Styles.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 14.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

extension ViewStyle where T: UIButton {
  
    static var action: ViewStyle<T> {
        return ViewStyle<T> {
            $0.titleLabel?.apply(.dbh3)
            $0.setTitleColor(.white, for: .normal)
        }
    }
    
    static var textual: ViewStyle<T> {
        return ViewStyle<T> {
            $0.titleLabel?.apply(.dbh3)
            $0.setTitleColor(.primaryColor, for: .normal)
        }
    }
    
    static var roundedСorners: ViewStyle<T> {
        return ViewStyle<T> {
            $0.layer.cornerRadius = 12.0
            $0.layer.masksToBounds = true
        }
    }
    
    static var roundedOff: ViewStyle<T> {
        return ViewStyle<T> {
            $0.layer.cornerRadius = 0
            $0.layer.masksToBounds = false
        }
    }
    
}
