//
//  Mapper.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

protocol Mapper {
    associatedtype TableItem: ListItem
    associatedtype Data: ListItemDataModel
    
    static func map(data: Data, cell: TableItem)
}
