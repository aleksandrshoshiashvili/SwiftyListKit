//
//  ListContentDataModel.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 10.07.20.
//

import Foundation

@available(iOS 14.0, *)
public struct ListContentDataModel: ListItemDataModel {
    public let image: UIImage?
    public let text: String?
    public let secondaryText: String?
    public let type: ListContentType

    public init(image: UIImage?,
                text: String?,
                secondaryText: String?,
                type: ListContentType) {
        self.image = image
        self.text = text
        self.secondaryText = secondaryText
        self.type = type
    }
}

@available(iOS 14.0, *)
public struct ListContentAttributedDataModel: ListItemDataModel {
    public let image: UIImage?
    public let text: NSAttributedString?
    public let secondaryText: NSAttributedString?
    public let type: ListContentType

    public init(image: UIImage?,
                text: NSAttributedString?,
                secondaryText: NSAttributedString?,
                type: ListContentType) {
        self.image = image
        self.text = text
        self.secondaryText = secondaryText
        self.type = type
    }
}
