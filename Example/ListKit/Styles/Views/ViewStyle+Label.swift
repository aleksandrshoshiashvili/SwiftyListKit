//
//  ViewStyle+Label.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 12/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

extension ViewStyle where T: UILabel {
    static var uppercased: ViewStyle<T> {
        return ViewStyle<T> {
            $0.text = $0.text?.uppercased()
        }
    }

    static var lowercased: ViewStyle<T> {
        return ViewStyle<T> {
            $0.text = $0.text?.lowercased()
        }
    }

    static var disclaimer: ViewStyle<T> {
        return ViewStyle<T> {
            $0.textColor = .gray
        }
    }

    static var normal: ViewStyle<T> {
        return ViewStyle<T> {
            $0.textColor = .black
        }
    }

    static var alert: ViewStyle<T> {
        return ViewStyle<T> {
            $0.textColor = .red
        }
    }

    static var uppercasedAlert: ViewStyle<T> {
        return uppercased + alert
    }
}
