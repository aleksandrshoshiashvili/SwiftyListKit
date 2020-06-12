//
//  UIView+Styles.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 14.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

extension ViewStyle where T: UIView {
  
    static var primaryColor: ViewStyle<T> {
        return ViewStyle<T> {
            $0.backgroundColor = .primaryColor
        }
    }
}
