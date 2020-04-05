//
//  TableViewCell.swift
//  ListKit
//
//  Created by Alexander Shoshiashvili on 23/01/2019.
//

import UIKit

open class TableViewCell: UITableViewCell, ListItem, SeparatorHandler {

    // MARK: - Properties

    private var topSeparatorView: SeparatorView?
    private var bottomSeparatorView: SeparatorView?
    private var customSeparatorConfiguration: CustomSeparatorConfiguration = .singleFullWidthLineBottom

    open override func prepareForReuse() {
        super.prepareForReuse()
        topSeparatorView?.removeFromSuperview()
        bottomSeparatorView?.removeFromSuperview()
    }

    // MARK: - SeparatorHandler

    open func configureSeparator(with configuration: CustomSeparatorConfiguration) {
        self.customSeparatorConfiguration = configuration

        switch configuration {
        case .singleLine(let position):
            let separator: SeparatorView = .default
            setupSeparator(separator, withPosition: position)
        case .custom(let separator, let position):
            setupSeparator(separator, withPosition: position)
        }
    }

    // MARK: - Helpers

    private func show(topSeparatorView: SeparatorView? = nil, bottomSeparatorView: SeparatorView? = nil) {

        if let topSeparatorView = topSeparatorView {

            self.topSeparatorView = topSeparatorView
            self.addSubview(topSeparatorView)
            bringSubviewToFront(topSeparatorView)

            let topSeparatorViewConstraints = [
                topSeparatorView.leftAnchor.constraint(equalTo: leftAnchor,
                                                       constant: topSeparatorView.separatorInsets.left),
                topSeparatorView.rightAnchor.constraint(equalTo: rightAnchor,
                                                        constant: -topSeparatorView.separatorInsets.right),
                topSeparatorView.topAnchor.constraint(equalTo: topAnchor,
                                                      constant: topSeparatorView.separatorInsets.top),
                topSeparatorView.heightAnchor.constraint(equalToConstant: topSeparatorView.separatorHeight)
            ]

            NSLayoutConstraint.activate(topSeparatorViewConstraints)
        }

        if let bottomSeparatorView = bottomSeparatorView {

            self.bottomSeparatorView = bottomSeparatorView
            self.addSubview(bottomSeparatorView)
            bringSubviewToFront(bottomSeparatorView)

            let bottomSeparatorViewConstraints = [
                bottomSeparatorView.leftAnchor.constraint(equalTo: leftAnchor,
                                                          constant: bottomSeparatorView.separatorInsets.left),
                bottomSeparatorView.rightAnchor.constraint(equalTo: rightAnchor,
                                                           constant: -bottomSeparatorView.separatorInsets.right),
                bottomSeparatorView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                            constant: -bottomSeparatorView.separatorInsets.bottom),
                bottomSeparatorView.heightAnchor.constraint(equalToConstant: bottomSeparatorView.separatorHeight)
            ]

            NSLayoutConstraint.activate(bottomSeparatorViewConstraints)
        }
    }

    private func setupSeparator(_ separator: SeparatorView, withPosition position: SeparatorPosition) {
        switch position {
        case .top(let inset):
            separator.separatorInsets = inset
            self.show(topSeparatorView: separator)
        case .bottom(let inset):
            separator.separatorInsets = inset
            self.show(bottomSeparatorView: separator)
        case .both(let topInset, let bottomInset):
            let copy: SeparatorView = separator.copy() as? SeparatorView ?? .default
            separator.separatorInsets = topInset
            copy.separatorInsets = bottomInset
            self.show(topSeparatorView: separator, bottomSeparatorView: copy)
        }
    }

}
