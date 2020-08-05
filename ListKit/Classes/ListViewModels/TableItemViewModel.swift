//
//  ListItemConfiguration.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 18/12/2018.
//

import UIKit
import DifferenceKit

public typealias MapDataToItem<T: ListItemDataModel, U: ListItem> = ((T, U) -> Void)
public typealias MapDataToItemClosure = ((ListItemDataModel, ListItem) -> Void)

public typealias MapStyleToItem<U: ListItem> = ((U) -> Void)
public typealias MapStyleToItemClosure = ((ListItem) -> Void)

/// Enum to declare how to stylize list item
public enum StyleType<U: ListItem> {
    /// custom style — closure from ListItem to Void
    case custom(style: ListItemStyle<U>)
    /// `default` — get style from ListITem default closure
    case `default`
}

public struct TableItemViewModel: StringHashable, Differentiable {
    
    public func isContentEqual(to source: TableItemViewModel) -> Bool {
        return self.data.hashString == source.data.hashString
    }
    
    public var differenceIdentifier: String = ""
    
    public let data: ListItemDataModel
    public let reuseIdentifier: String
    public let heightStyle: TableItemHeightStyle
    public let map: MapDataToItemClosure?
    public let style: MapStyleToItemClosure?
    
    public var hashString: String { return data.hashString }
    
    /**
     Initializes a new ListItemViewModel object from ListItem type. The initializers should be used if you want to display a static element with default styling without data.
     
     - Parameters:
       - itemType: The type of ListItem element to be displayed
       - heightStyle: Determines how high the list item will be drawn (default = .automatic)
     
     */
    public init(itemType: TableItem.Type, heightStyle: TableItemHeightStyle = .automatic) {
        self.data = EmptyDataViewModel()
        self.reuseIdentifier = itemType.reuseId
        self.heightStyle = heightStyle
        self.map = itemType.defaultDataMap
        self.style = itemType.defaultStyle
        self.differenceIdentifier = data.hashString
    }

    /**
     Initializes a new ListItemViewModel object from ListItem type and style. The initializers should be used if you want to display a static element with default styling without data.

     - Parameters:
       - itemType: The type of ListItem element to be displayed
       - heightStyle: Determines how high the list item will be drawn (default = .automatic)

     */
    public init<U: TableItem>(itemType: U.Type, style: StyleType<U>? = nil, heightStyle: TableItemHeightStyle = .automatic) {
        self.data = EmptyDataViewModel()
        self.reuseIdentifier = itemType.reuseId
        self.heightStyle = heightStyle
        self.map = itemType.defaultDataMap
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
        self.differenceIdentifier = data.hashString
    }
    
    /**
     Initializes a new ListItemViewModel object from ListItem type and with data. The initializers should be used if you want to display a static element with default styling with data and with default data mapping.
     
     - Parameters:
       - itemType: The type of ListItem element to be displayed
       - data: Object that contains needed data for list item
       - heightStyle: Determines how high the list item will be drawn (default = .automatic)
     
     */
    public init<T: ListItemDataModel>(itemType: TableItem.Type,
                                      data: T,
                                      heightStyle: TableItemHeightStyle = .automatic) {
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
    public init<T: ListItemDataModel, U: TableItem>(data: T,
                                                   map: @escaping MapDataToItem<T, U>,
                                                   style: StyleType<U>? = nil,
                                                   heightStyle: TableItemHeightStyle = .automatic) {
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

    public init<T: ListItemDataModel, U: TableItem>(data: T,
                                                   map: AnyListItemMapper<T, U>,
                                                   style: StyleType<U>? = nil,
                                                   heightStyle: TableItemHeightStyle = .automatic) {
        self.data = data
        self.reuseIdentifier = U.reuseId
        self.heightStyle = heightStyle
        self.differenceIdentifier = data.hashString

        self.map = { dataModel, item in
            guard let dataModel = dataModel as? T, let item = item as? U else { return }
            map.map(model: dataModel, item: item)
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
    static func +(left: TableItemViewModel, right: TableItemViewModel) -> [TableItemViewModel] {
        let result = [left, right]
        return result
    }
}
