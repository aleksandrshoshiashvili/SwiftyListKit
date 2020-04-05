//
//  CollectionView.swift
//
//  Created by Alexander Shoshiashvili on 04/06/2018.
//  Copyright © 2018 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

public class CollectionView: UICollectionView {

  var registrator: CollectionViewRegistrator!
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    registrator = CollectionViewRegistrator(collectionView: self)
  }
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    registrator = CollectionViewRegistrator(collectionView: self)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
