//
//  ListContentTableViewCell+Styles.swift
//  DifferenceKit
//
//  Created by Alexander Shoshiashvili on 10.07.20.
//

import Foundation
import UIKit

@available(iOS 14.0, *)
public extension ListItemStyle where T: ListContentTableViewCell {

    static func withSelectionStyle(_ style: UITableViewCell.SelectionStyle) -> ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.selectionStyle = style
        }
    }

    static func withImageToTextPadding(_ padding: CGFloat) -> ListItemStyle<T> {
        return ListItemStyle<T> {
            guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
                return
            }
            config.imageToTextPadding = padding
            $0.contentConfiguration = config
        }
    }

    static func withAxesPreservingSuperviewLayoutMargins(_ axis: UIAxis) -> ListItemStyle<T> {
        return ListItemStyle<T> {
            guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
                return
            }
            config.axesPreservingSuperviewLayoutMargins = axis
            $0.contentConfiguration = config
        }
    }

    static func withDirectionalLayoutMargins(_ margins: NSDirectionalEdgeInsets) -> ListItemStyle<T> {
        return ListItemStyle<T> {
            guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
                return
            }
            config.directionalLayoutMargins = margins
            $0.contentConfiguration = config
        }
    }

    static func withPrefersSideBySideTextAndSecondaryText(_ prefersSideBySide: Bool) -> ListItemStyle<T> {
        return ListItemStyle<T> {
            guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
                return
            }
            config.prefersSideBySideTextAndSecondaryText = prefersSideBySide
            $0.contentConfiguration = config
        }
    }

    static func withTextToSecondaryTextHorizontalPadding(_ padding: CGFloat) -> ListItemStyle<T> {
        return ListItemStyle<T> {
            guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
                return
            }
            config.textToSecondaryTextHorizontalPadding = padding
            $0.contentConfiguration = config
        }
    }

    static func withTextToSecondaryTextVerticalPadding(_ padding: CGFloat) -> ListItemStyle<T> {
        return ListItemStyle<T> {
            guard var config = $0.contentConfiguration as? UIListContentConfiguration else {
                return
            }
            config.textToSecondaryTextVerticalPadding = padding
            $0.contentConfiguration = config
        }
    }
    
}
