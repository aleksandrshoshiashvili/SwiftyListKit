// WithImageTableViewCell.swift
// SwiftyListKit
//
// Created by Alexander Shoshiashvili on 06/11/2018.
//Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

public protocol WithImageTableViewCellDelegate: Delegatable {
    func didTapImageView()
}

final public class WithImageTableViewCell: UITableViewCell, TableItem, ListItemDelegatable {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    weak var delegate: WithImageTableViewCellDelegate?
    
    public static var defaultStyle: ((ListItem) -> Void)? {
        return { item in
            guard let item = item as? WithImageTableViewCell else { return }
            item.iconImageView.layer.cornerRadius = item.iconImageView.bounds.height / 2.0
            item.iconImageView.layer.masksToBounds = true
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        iconImageView.addGestureRecognizer(tapGesture)
        iconImageView.isUserInteractionEnabled = false
    }
    
    public func set(delegate: Delegatable) {
        self.delegate = delegate as? WithImageTableViewCellDelegate
    }
    
    // MARK: - Actions
    
    @objc func handleTap() {
        delegate?.didTapImageView()
//        let mapper = WithImageTableViewCellMapper()
//        let mapperWrapper = AnyListItemMapper(mapper)
    }


    
}

extension WithImageTableViewCell {
    static func map(model: ImageCellDataModel, cell: WithImageTableViewCell) {
        cell.iconImageView.image = model.image
    }
}
