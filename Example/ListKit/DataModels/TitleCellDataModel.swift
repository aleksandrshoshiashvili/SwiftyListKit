//
//  TitleCellViewModel.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import ListKit

public struct TitleCellDataModel: ListItemDataModel {
    public var tag: Any?
    public var title: String
    
    public var hashString: String {
        return title
    }
    
    public init(tag: String = "", title: String = "123") {
        self.tag = tag
        self.title = title
    }
}
