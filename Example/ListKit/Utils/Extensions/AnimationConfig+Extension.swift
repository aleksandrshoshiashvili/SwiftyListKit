//
//  AnimationConfig+Extension.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 14.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

extension TableAnimationConfiguration {
    static var none: TableAnimationConfiguration {
        .init(rowDeletionAnimation: .none, rowInsertionAnimation: .none, rowReloadAnimation: .none, sectionDeletionAnimation: .none, sectionInsertionAnimation: .none, sectionReloadAnimation: .none)
    }
}
