//
//  ListContentMapper.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 10.07.20.
//

@available(iOS 14.0, *)
public struct ListContentMapper {
    public static func mapListContent(data: ListContentDataModel, cell: ListContentTableViewCell) {
        let config = getContentConfig(data: data)
        cell.contentConfiguration = config
    }

    public static func mapListContentAttributed(data: ListContentAttributedDataModel, cell: ListContentTableViewCell) {
        let config = getContentConfig(data: data)
        cell.contentConfiguration = config
    }

    public static func mapListContent(data: ListContentDataModel, cell: ListContentCollectionViewCell) {
        let config = getContentConfig(data: data)
        cell.contentConfiguration = config
    }

    public static func mapListContentAttributed(data: ListContentAttributedDataModel, cell: ListContentCollectionViewCell) {
        let config = getContentConfig(data: data)
        cell.contentConfiguration = config
    }

    // MARK: - Helpers

    private static func getContentConfig(data: ListContentDataModel) -> UIContentConfiguration {
        var config = data.type.config
        config.text = data.text
        config.secondaryText = data.secondaryText
        config.image = data.image
        return config
    }

    private static func getContentConfig(data: ListContentAttributedDataModel) -> UIContentConfiguration {
        var config = data.type.config
        config.attributedText = data.text
        config.secondaryAttributedText = data.secondaryText
        config.image = data.image
        return config
    }

}
