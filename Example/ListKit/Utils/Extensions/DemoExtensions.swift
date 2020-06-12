//
//  DemoExtensions.swift
//  SwiftyListKit
//
//  Created by Александр Шошиашвили on 03/08/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

extension TableListUpdateAnimation {

    static func random() -> TableListUpdateAnimation {

        let option = Int.random(in: 0..<5)

        switch option {
        case 0:
            return .default
        case 1:
            return .standard(configuration: .init(rowDeletionAnimation: .automatic, rowInsertionAnimation: .bottom, rowReloadAnimation: .fade, sectionDeletionAnimation: .left, sectionInsertionAnimation: .middle, sectionReloadAnimation: .right))
        case 2:
            return .custom(configuration: .moveWithBounce(direction: .fromBottomToUp, duration: 1.0, delayFactor: 0.08, damping: 0.6))
        case 3:
            return .custom(configuration: .fade(duration: 1.0))
        case 4:
            return .custom(configuration: .rotate(angle: .pi, duration: 0.4, delayFactor: 0.07))
        default:
            return .default
        }

    }

}

extension Array {
    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        let count = self.count
        indices.lazy.dropLast().forEach {
            swapAt($0, Int(arc4random_uniform(UInt32(count - $0))) + $0)
        }
        return self
    }
    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}
