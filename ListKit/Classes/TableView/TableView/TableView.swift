//
//  TableView.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 23/02/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

open class TableView: UITableView {

    open var registrator: TableViewRegistrator!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        registrator = TableViewRegistrator(tableView: self)
    }
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style) 
        registrator = TableViewRegistrator(tableView: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
