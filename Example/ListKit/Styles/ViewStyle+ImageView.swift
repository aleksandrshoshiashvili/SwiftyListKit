//
//  ViewStyle+ImageView.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 12/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import ListKit

extension ViewStyle where T: UIImageView {
    
    static func rounded(radius: CGFloat) -> ViewStyle<T> {
        return ViewStyle<T> {
            $0.layer.cornerRadius = radius
        }
    }
    
    static var rounded: ViewStyle<T> {
        return ViewStyle<T> {
            $0.layer.cornerRadius = 4.0
        }
    }
    
    static var opaque: ViewStyle<T> {
        return ViewStyle<T> {
            $0.alpha = 0.5
        }
    }
    
    static var squared: ViewStyle<T> {
        return rounded(radius: 0)
    }
}
