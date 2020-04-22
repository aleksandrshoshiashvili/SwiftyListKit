//
//  ImageCellViewModel.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import ListKit

public struct ImageCellDataModel: ListItemDataModel {
    public var image: UIImage? = UIImage()
    public var tag: Any?
    
    public init(tag: String = "", image: UIImage?) {
        self.tag = tag
        self.image = image
    }
}
