//
//  ListItemStyle+DividerHeader.swift
//  LastDDM
//
//  Created by Александр Шошиашвили on 04/08/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import ListKit

extension ListItemStyle where T: DividerHeader {

    static var alert: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.titleLabel.apply(.uppercased)
        }
    }

    static var header: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.titleLabel.textColor = .black
            $0.titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
            $0.titleLabel.apply(.uppercased)
        }
    }
}
