//
//  ListItem.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/12/2018.
//

import UIKit

/// Implement this protocol to set external object as list item delegate
public protocol ListItemDelegatable {
    func set(delegate: Delegatable)
}

/// This protocol needed to mark any protocol as ListKit compatible,
/// should be used in cell's or header's delegates.
public protocol Delegatable: class {}

/// Implement this protocol on UITableViewCell, UITableHeaderFooterView to mark it as ListKit compatible
public protocol ListItem {
    static var defaultDataMap: MapDataToItemClosure? { get }
    static var defaultStyle: MapStyleToItemClosure? { get }
}

public extension ListItem {
    static var reuseId: String {
        return String(describing: self)
    }
    
    static var defaultDataMap: MapDataToItemClosure? {
        return nil
    }
    
    static var defaultStyle: MapStyleToItemClosure? {
        return nil
    }
}

public protocol ListItemMapperProtocol {
    associatedtype Model: ListItemDataModel
    associatedtype Item: ListItem

    func map(model: Model, item: Item)
}

public class AnyListItemMapper<M: ListItemDataModel, I: ListItem>: ListItemMapperProtocol {
    public typealias Model = M
    public typealias Item = I

    private let _map: (_ model: M, _ item: I) -> Void

    public init<U: ListItemMapperProtocol>(_ mapper: U) where U.Model == M, U.Item == I {
        _map = mapper.map
    }

    public func map(model: AnyListItemMapper<M, I>.Model,
                    item: AnyListItemMapper<M, I>.Item) {
        _map(model, item)
    }
}
