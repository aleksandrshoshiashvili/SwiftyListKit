//
//  UpdateListProtocol.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 27/06/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

// MARK: - Protocols

public typealias CompletionBlock = (() -> Void)?

/// Common Protocol for updating table or collection view.
public protocol UpdateListProtocol {
    func update(with sections: [TableListSection])
}
