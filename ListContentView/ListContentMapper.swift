//
//  ListContentMapper.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 10.07.20.
//

@available(iOS 14.0, *)
public struct ListContentMapper {
    public static func mapListContent(data: ListContentDataModel, cell: ListContentTableViewCell) {
        var config = data.type.config
        config.text = data.text
        config.secondaryText = data.secondaryText
        config.image = data.image

        cell.contentConfiguration = config
    }

    public static func mapListContentAttributed(data: ListContentAttributedDataModel, cell: ListContentTableViewCell) {
        var config = data.type.config
        config.attributedText = data.text
        config.secondaryAttributedText = data.secondaryText
        config.image = data.image
        cell.contentConfiguration = config
    }
}
