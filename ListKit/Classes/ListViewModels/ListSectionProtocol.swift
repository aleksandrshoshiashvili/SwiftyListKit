//
//  ListSectionProtocol.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 28/02/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

public protocol ListRowsProtocol {
    associatedtype ItemModel: StringHashable
    
    var rows: [ItemModel] { get set }
    init(rows: [ItemModel])
}

public protocol ListSectionProtocol: ListRowsProtocol {
    var id: Int { get }
    var header: ItemModel? { get set }
    var footer: ItemModel? { get set }
    
    init(header: ItemModel?, footer: ItemModel?, rows: [ItemModel])
}

public extension ListSectionProtocol {
    init(rows: [ItemModel]) {
        self.init(header: nil, footer: nil, rows: rows)
    }
}

public protocol StringHashable {
    var hashString: String { get }
}
