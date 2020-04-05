//
//  ListUpdateAnimation.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 13/02/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

/// Animation style for table list reloading
public enum TableListUpdateAnimation {
    /// `default`: UITableView.RowAnimation = .fade for all types of animation
    case `default`
    
    /// change animation on any standard UITableView.RowAnimation
    case standard(configuration: TableAnimationConfiguration)
    
    /// change animation on custom, that implements in `Animation` closure
    case custom(configuration: TableItemsAnimation)
    
    /// calling `reloadData()` without animation
    case noAnimations
}

/// Animation style for collection list  reloading
public enum CollectionListUpdateAnimation {
    /// `default`:  standard animation for performBatchUpdates method
    case `default`

    /// calling `reloadData()` without animation
    case noAnimations
}
