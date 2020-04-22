//
//  TitleAndImageDataModel.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/04/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import ListKit

public struct TitleAndImageDataModel: ListItemDataModel {
    public var tag: Any?
    public var title: String
    public var image: UIImage? = UIImage()
    
    public var hashString: String {
        return title + (image?.description ?? "")
    }
    
    public init(tag: String = "", title: String, image: UIImage?) {
        self.tag = tag
        self.title = title
        self.image = image
    }
}
