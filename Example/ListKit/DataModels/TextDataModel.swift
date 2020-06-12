//
//  TextDataModel.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

struct TextDataModel: ListItemDataModel {
    var tag: Any?
    let text: String
}
