//
//  UIKit+CustomExtensions.swift
//  SwiftyListKit
//
//  Created by Dmitry Grebenschikov on 06/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import DifferenceKit

extension UITableView {
    func reload<C>(
        using stagedChangeset: StagedChangeset<C>,
        with animationConfiguration: TableAnimationConfiguration,
        interrupt: ((Changeset<C>) -> Bool)? = nil,
        setData: (C) -> Void
        ) {
        reload(
            using: stagedChangeset,
            deleteSectionsAnimation: animationConfiguration.sectionDeletionAnimation,
            insertSectionsAnimation: animationConfiguration.sectionInsertionAnimation,
            reloadSectionsAnimation: animationConfiguration.rowReloadAnimation,
            deleteRowsAnimation: animationConfiguration.rowDeletionAnimation,
            insertRowsAnimation: animationConfiguration.rowInsertionAnimation,
            reloadRowsAnimation: animationConfiguration.rowReloadAnimation,
            interrupt: interrupt,
            setData: setData
        )
    }
}
