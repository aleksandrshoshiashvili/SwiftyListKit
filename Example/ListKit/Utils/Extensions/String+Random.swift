//
//  String+Random.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import Foundation

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
