// IconWithTitleCollectionViewCell.swift
// SwiftyListKit
//
// Created by Alexander Shoshiashvili on 06/11/2018.
// Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import ListKit

final public class IconWithTitleCollectionViewCell: UICollectionViewCell, CollectionItem {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    public static var defaultStyle: ((ListItem) -> Void)? {
        return { item in
            guard let item = item as? IconWithTitleCollectionViewCell else { return }
            item.contentView.layer.cornerRadius = 8.0
            item.contentView.layer.masksToBounds = true
            item.contentView.backgroundColor = UIColor.orange.withAlphaComponent(0.2)
            item.titleLabel.textColor = .black
            item.iconImageView.layer.borderColor = UIColor.gray.cgColor
            item.iconImageView.layer.borderWidth = 1.0
        }
    }
    
    override public func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = ceil(size.width)
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}

extension IconWithTitleCollectionViewCell {
    static func map(model: TitleAndImageDataModel, cell: IconWithTitleCollectionViewCell) {
        cell.iconImageView.image = model.image
        cell.titleLabel.text = model.title
    }
}
