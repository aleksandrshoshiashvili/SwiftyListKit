//
//  TableViewProtocol.swift
//  TableKit
//
//  Created by Alexander Shoshiashvili on 25/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

// MARK: - Protocols

/// Protocol for updating table view only, this protocol should use only in UIViewContoller's
public protocol UpdateTableProtocol: UpdateListProtocol {
    func clearData()
    func update(with sections: [TableListSection], updateAnimation: TableListUpdateAnimation)
}
