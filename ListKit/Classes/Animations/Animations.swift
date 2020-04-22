//
//  ListUpdateAnimation.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 13/02/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

/// Some built-in custom animations
public struct TableItemsAnimation {

    /// Closure for implemention custom animation for reloading table view
    public typealias Animation = (UITableView) -> Void

    typealias ViewAnimation = (UIView) -> Void

    public enum SlideDirection {
        case fromLeftToRight
        case fromRightToLeft
    }

    public enum MoveDirection {
        case fromBottomToUp
        case fromUpToBottom
    }

    private let animation: Animation

    // MARK: - Init

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    // MARK: - Animate

    func animate(tableView: UITableView) {
        animation(tableView)
    }

    // MARK: - Built-in animations
    
    public static func fade(duration: TimeInterval,
                            delayFactor: Double = 0.08) -> TableItemsAnimation {
        let animation = { (tableView: UITableView) in
            let visibleItems: [UIView] = tableView.visibleItems
            
            applyAnimation(
                animation: { (view) in
                    view.alpha = 1.0
            },
                withInitialSetup: { (view) in
                    view.alpha = 0.0
            },
                to: visibleItems,
                duration: duration,
                delayFactor: delayFactor)
        }
        return .init(animation: animation)
    }
    
    public static func moveWithBounce(direction: MoveDirection = .fromUpToBottom,
                                      duration: TimeInterval,
                                      delayFactor: Double = 0.08,
                                      damping: CGFloat = 0.6) -> TableItemsAnimation {
        let animation = { (tableView: UITableView) in
            let tableViewHeight = tableView.bounds.size.height
            
            let visibleItems: [UIView] = tableView.visibleItems
            
            applyAnimation(
                animation: { (view) in
                    view.transform = CGAffineTransform.identity
            },
                withInitialSetup: { (view) in
                    switch direction {
                    case .fromBottomToUp:
                        view.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
                    case .fromUpToBottom:
                        view.transform = CGAffineTransform(translationX: 0, y: -tableViewHeight)
                    }
            },
                to: visibleItems,
                duration: duration,
                delayFactor: delayFactor,
                damping: damping)
        }
        return .init(animation: animation)
    }
    
    public static func slideIn(direction: SlideDirection = .fromRightToLeft,
                               duration: TimeInterval,
                               delayFactor: Double,
                               damping: CGFloat = 0.6) -> TableItemsAnimation {
        let animation = { (tableView: UITableView) in
            let visibleItems: [UIView] = tableView.visibleItems
            
            applyAnimation(
                animation: { (view) in
                    view.transform = CGAffineTransform.identity
            },
                withInitialSetup: { (view) in
                    switch direction {
                    case .fromLeftToRight:
                        view.transform = CGAffineTransform(translationX: -tableView.bounds.width, y: 0)
                    case .fromRightToLeft:
                        view.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
                    }
            },
                to: visibleItems,
                duration: duration,
                delayFactor: delayFactor,
                damping: damping)
        }
        return .init(animation: animation)
    }
    
    public static func rotate(angle: CGFloat,
                              duration: TimeInterval,
                              delayFactor: Double,
                              damping: CGFloat = 0.6) -> TableItemsAnimation {
        let animation = { (tableView: UITableView) in
            let visibleItems: [UIView] = tableView.visibleItems
            
            applyAnimation(
                animation: { (view) in
                    view.transform = CGAffineTransform.identity
            },
                withInitialSetup: { (view) in
                    view.transform = CGAffineTransform(rotationAngle: angle)
            },
                to: visibleItems,
                duration: duration,
                delayFactor: delayFactor,
                damping: damping)
        }
        return .init(animation: animation)
    }
    
    // MARK: - Helpers
    
    private static func applyAnimation(animation: @escaping ViewAnimation,
                                       withInitialSetup setup: @escaping ViewAnimation,
                                       to views: [UIView],
                                       duration: TimeInterval,
                                       delayFactor: Double,
                                       damping: CGFloat = 1.0) {
        var delayCounter = 0
        
        for view in views {
            setup(view)
        }
        
        for view in views {
            UIView.animate(withDuration: duration,
                           delay: delayFactor * Double(delayCounter),
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            animation(view)
            }, completion: nil)
            delayCounter += 1
        }
    }
    
}
