//
//  CollectionItemViewModel.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 07.01.20.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import DifferenceKitClone

public struct CollectionItemViewModel: StringHashable, Differentiable {

    public func isContentEqual(to source: CollectionItemViewModel) -> Bool {
        return self.data.hashString == source.data.hashString
    }

    public var differenceIdentifier: String = ""

    public let data: ListItemDataModel
    public let reuseIdentifier: String
    public let heightStyle: CollectionItemHeightStyle
    public let map: MapDataToItemClosure?
    public let style: MapStyleToItemClosure?

    public var hashString: String { return data.hashString }

    /**
     Initializes a new ListItemViewModel object from ListItem type. The initializers should be used if you want to display a static element with default styling without data.

     - Parameters:
     - itemType: The type of ListItem element to be displayed
     - heightStyle: Determines how high the list item will be drawn (default = .automatic)

     */
    public init(itemType: CollectionItem.Type, heightStyle: CollectionItemHeightStyle = .static(height: 10, width: 10)) {
        self.data = EmptyDataViewModel()
        self.reuseIdentifier = itemType.reuseId
        self.heightStyle = heightStyle
        self.map = itemType.defaultDataMap
        self.style = itemType.defaultStyle
        self.differenceIdentifier = data.hashString
    }

    /**
     Initializes a new ListItemViewModel object from ListItem type and with data. The initializers should be used if you want to display a static element with default styling with data and with default data mapping.

     - Parameters:
     - itemType: The type of ListItem element to be displayed
     - data: Object that contains needed data for list item
     - heightStyle: Determines how high the list item will be drawn (default = .automatic)

     */
    public init<T: ListItemDataModel>(itemType: CollectionItem.Type, data: T, heightStyle: CollectionItemHeightStyle = .static(height: 10, width: 10)) {
        self.data = data
        self.reuseIdentifier = itemType.reuseId
        self.heightStyle = heightStyle
        self.map = itemType.defaultDataMap
        self.style = itemType.defaultStyle
        self.differenceIdentifier = data.hashString
    }

    /**
     Initializes a new ListItemViewModel object with data, custom map and style. The common initializers for ListItemViewModel.

     - Parameters:
     - data: Object that contains needed data for list item
     - map: Closure that determine how to map data to list item
     - style: Closure that determine how to stylize list item
     - heightStyle: Determines how high the list item will be drawn (default = .automatic)

     */
    public init<T: ListItemDataModel, U: CollectionItem>(data: T,
                                                   map: @escaping MapDataToItem<T, U>,
                                                   style: StyleType<U>? = nil,
                                                   heightStyle: CollectionItemHeightStyle = .static(height: 10, width: 10)) {
        self.data = data
        self.reuseIdentifier = U.reuseId
        self.heightStyle = heightStyle
        self.differenceIdentifier = data.hashString

        self.map = { dataModel, item in
            guard let dataModel = dataModel as? T, let item = item as? U else { return }
            map(dataModel, item)
        }

        if let mapping = style {
            switch mapping {
            case .custom(let style):
                let stylingBlock = style.styling
                self.style = { item in
                    guard let item = item as? U else { return }
                    stylingBlock(item)
                }
            case .default:
                self.style = U.defaultStyle
            }
        } else {
            self.style = U.defaultStyle
        }
    }

    /// Helper function
    static func +(left: CollectionItemViewModel, right: CollectionItemViewModel) -> [CollectionItemViewModel] {
        let result = [left, right]
        return result
    }
}
