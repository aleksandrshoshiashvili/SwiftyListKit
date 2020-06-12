//
//  IconDataModel.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

struct LocalIconDataModel: ListItemDataModel {
    var tag: Any?
    let localIconName: String
}
