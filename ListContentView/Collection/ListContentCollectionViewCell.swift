//
//  ListContentCollectionViewCell.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 22.07.20.
//

import UIKit

@available(iOS 14.0, *)
public class ListContentCollectionViewCell: UICollectionViewCell, CollectionItem {

    public override var reuseIdentifier: String? {
        return "ListContentCollectionViewCell"
    }

}
