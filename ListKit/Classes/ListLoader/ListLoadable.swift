//
//  ListLoadable.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 31.01.20.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

@objc public protocol ListLoadable {
    func ld_visibleContentViews() -> [UIView]
}

public protocol ListLoadableView: ListLoadable where Self: UIView {
    func showLoader(loaderType: ListLoader.ListLoaderType)
    func hideLoader()
}

public extension ListLoadableView where Self: ListLoadable {
    func showLoader(loaderType: ListLoader.ListLoaderType) {
        if self is UIScrollView {
            isUserInteractionEnabled = false
            ListLoader.addLoaderTo(self, loaderType: loaderType)
        } else {
            isUserInteractionEnabled = false
            ListLoader.addLoaderToViews([self])
        }
    }

    func hideLoader() {
        if self is UIScrollView {
            isUserInteractionEnabled = true
            ListLoader.removeLoaderFrom(self)
        } else {
            isUserInteractionEnabled = true
            ListLoader.removeLoaderFromViews([self])
        }
    }
}

@objc extension UITableView: ListLoadableView, ListLoadable {
    public func ld_visibleContentViews() -> [UIView] {
        guard let views = (visibleItems as NSArray) as? [UIView] else {
            return []
        }

        let contentViews = views.compactMap { (view) -> UIView? in
            if view is UITableViewHeaderFooterView {
                return view
            } else {
                return view.value(forKey: "contentView") as? UIView
            }
        }

        return contentViews
    }
}

@objc extension UICollectionView: ListLoadableView, ListLoadable {
    public func ld_visibleContentViews() -> [UIView] {
        guard let contentViews = (visibleCells as NSArray).value(forKey: "contentView") as? [UIView] else {
            return []
        }
        return contentViews
    }
}
