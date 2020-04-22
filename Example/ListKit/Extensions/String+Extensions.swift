//
//  String+Extensions.swift
//  SwiftyListKit_Example
//
//  Created by Alexander Shoshiashvili on 06/11/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

extension String {
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length - 1)
            .map({ _ in
                letters.randomElement() ?? Character("")
            }))
    }
    
    static func randomString() -> String {
        let randomLenght = Int.random(in: 1...50)
        return randomString(length: randomLenght)
    }
}
