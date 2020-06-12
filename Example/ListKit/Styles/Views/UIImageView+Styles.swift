//
//  UIImageView+Styles.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 14.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

extension ViewStyle where T: UIImageView {
  
    static func cornerRadius(_ radius: CGFloat) -> ViewStyle<T> {
        return ViewStyle<T> {
            $0.layer.cornerRadius = radius
            $0.layer.masksToBounds = true
        }
    }
}
