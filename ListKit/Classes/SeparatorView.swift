//
//  SeparatorView.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 11/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

open class SeparatorView: UIView {

    var separatorColor: UIColor? = UIColor.lightGray
    var separatorHeight: CGFloat = 1.0
    var separatorInsets: UIEdgeInsets = .zero

    class var `default`: SeparatorView {
        let separatorColor: UIColor? = UIColor.lightGray
        let view = SeparatorView(frame: .zero)
        view.backgroundColor = separatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    class func custom(color: UIColor = UIColor.lightGray,
                      height: CGFloat = 1.0,
                      insets: UIEdgeInsets = UIEdgeInsets(top: .zero, left: 16.0, bottom: .zero, right: .zero)) -> SeparatorView {
        let view = SeparatorView(frame: .zero)
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorColor = color
        view.separatorHeight = height
        view.separatorInsets = insets
        return view
    }

}

public enum CustomSeparatorConfiguration {
    case singleLine(position: SeparatorPosition)
    case custom(separator: SeparatorView, position: SeparatorPosition)
}

public extension CustomSeparatorConfiguration {

    static let `default`: CustomSeparatorConfiguration =
        .singleLine(position: .bottom(inset: UIEdgeInsets(top: .zero, left: 16.0, bottom: .zero, right: .zero)))

    static let singleFullWidthLineBottom: CustomSeparatorConfiguration =
        .singleLine(position: .bottom(inset: .zero))

    static let singleFullWidthLineTop: CustomSeparatorConfiguration =
        .singleLine(position: .top(inset: .zero))

    static let singleFullWidthLineTopAndBottom: CustomSeparatorConfiguration =
        .singleLine(position: .both(topInset: .zero, bottomInset: .zero))

}

public enum SeparatorPosition {
    case top(inset: UIEdgeInsets)
    case bottom(inset: UIEdgeInsets)
    case both(topInset: UIEdgeInsets, bottomInset: UIEdgeInsets)
}

public protocol SeparatorHandler {
    func configureSeparator(with style: CustomSeparatorConfiguration)
}
