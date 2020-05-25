//
//  Optional+CustomStringConvertible.swift
//  DifferenceKitClone
//
//  Created by Alexander Shoshiashvili on 25.05.2020.
//

import Foundation

extension Optional: CustomStringConvertible where Wrapped: CustomStringConvertible {
    public var description: String {
        switch self {
        case .some(let wrapped): return wrapped.description
        case .none: return "nil"
        }
    }
}
