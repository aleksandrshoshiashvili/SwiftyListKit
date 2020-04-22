//
//  SegmentWithButtonView.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 25/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

protocol SegmentWithButtonViewDelegate: class {
    func segmentWithButtonViewDidSelectSegment(_ segmentView: SegmentWithButtonView, at index: Int)
    func segmentWithButtonViewDidTapOnReload(_ segmentView: SegmentWithButtonView)
}

class SegmentWithButtonView: UIView {

    weak var delegate: SegmentWithButtonViewDelegate?
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func handleSegmentControlAction(_ sender: Any) {
        delegate?.segmentWithButtonViewDidSelectSegment(self, at: segmentControl.selectedSegmentIndex)
    }
    
    @IBAction func handleReloadAction(_ sender: Any) {
        delegate?.segmentWithButtonViewDidTapOnReload(self)
    }

}

// MARK: Extensions

extension UIView {
    class func instanceFromNib(name: String) -> UIView? {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

extension SegmentWithButtonView {
    class func initFromNib() -> SegmentWithButtonView {
        guard let fromNib = instanceFromNib(name: "SegmentWithButtonView") as? SegmentWithButtonView else {
            return SegmentWithButtonView()
        }
        return fromNib
    }
}
