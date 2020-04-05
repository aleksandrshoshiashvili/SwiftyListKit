//
//  UpdateCollectionProtocol.swift
//
//  Created by Alexander Shoshiashvili on 25/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

// MARK: - UpdateCollectionProtocol

public protocol UpdateCollectionProtocol {
    func update(with sections: [CollectionListSection])
    func clearData()
}
