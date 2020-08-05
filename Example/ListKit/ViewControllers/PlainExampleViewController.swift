//
//  PlainExampleViewController.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 25/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

import UIKit
import SwiftyListKit

final class PlainExampleViewController: BaseAnimatedTableViewController {
    
    private let rowsCount = 200
    private let sectionsCount = 5

    private var segmentControl: SegmentWithButtonView?
    private var updateAnimation: TableListUpdateAnimation = .default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentControl = SegmentWithButtonView.initFromNib()
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 90.0)
            ])
        
        segmentControl.delegate = self
        
        self.segmentControl = segmentControl
        
        let oneTitleVM = TableItemViewModel(itemType: OneTitleTableViewCell.self)
        let imageVM = TableItemViewModel(itemType: WithImageTableViewCell.self)
        let headerVM = TableItemViewModel(itemType: DividerHeader.self)
        
        let placeholderSection = TableListSection(header: headerVM,
                                             footer: headerVM,
                                             rows: [oneTitleVM, imageVM, oneTitleVM, imageVM, oneTitleVM, oneTitleVM, oneTitleVM, oneTitleVM, oneTitleVM, imageVM])

        self.showLoader(with: [placeholderSection])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let sections = [TableListSection].init(repeating: self.getSectionWithRandomViewModels(), count: 5)
            self.hideLoader(with: sections)
        })
    }
    
    // MARK: - Generate random sections
    
    private func reloadViewModels() {
        var sections: [TableListSection] = []
        
        for _ in 0 ..< sectionsCount {
            let section = getSectionWithRandomViewModels()
            sections.append(section)
        }
        
        update(with: sections, updateAnimation: self.updateAnimation)
    }
    
    // MARK: - Generate random rows/headers
    
    private func getSectionWithRandomViewModels() -> TableListSection {
        var rowViewModels: [TableItemViewModel] = []
        
        for _ in 0 ..< rowsCount / 4 {
            
            // OneLineCell
            
            let oneLineDataModel = TextDataModel(text: "123")
            
            // Init ViewModel with Data, custom Map and default style
            let cellViewModel = TableItemViewModel(data: oneLineDataModel,
                                                  map: OneTitleTableViewCell.map1,
                                                  style: .default)
            
            
            let oneLineDataModel1 = TextDataModel(text: .randomString())
            
            let inCodeDataModel = TextDataModel(text: .randomString(length: 5))
            let inCodeCellViewModel = TableItemViewModel(data: inCodeDataModel,
                                                         map: InCodeTableViewCell.map)
            
            // Init ViewModel with Data, custom Map and custom style
            let cellViewModel1 = TableItemViewModel(data: oneLineDataModel1,
                                                   map: OneTitleTableViewCell.map1,
                                                   style: .custom(style: .squareIconAlertTitle))
            
            let customStyle1: ListItemStyle<OneTitleTableViewCell> = ListItemStyle<OneTitleTableViewCell> {
                $0.titleLabel.textColor = .magenta
            }
            
            let customStyle2: ListItemStyle<OneTitleTableViewCell> = ListItemStyle<OneTitleTableViewCell> {
                $0.dummyImageView.layer.borderColor = UIColor.black.cgColor
                $0.dummyImageView.layer.borderWidth = 2.0
                $0.dummyImageView.apply(.rounded)
            }
            
            let customStyle = customStyle1 + customStyle2
            
            // Init ViewModel with Data, custom Map and custom style
            let oneLineDataModel2 = TextDataModel(text: .randomString())
            let cellViewModel2 = TableItemViewModel(data: oneLineDataModel2,
                                                   map: OneTitleTableViewCell.map1,
                                                   style: .custom(style: customStyle))
            rowViewModels.append(cellViewModel)
            rowViewModels.append(cellViewModel1)
            rowViewModels.append(cellViewModel2)
            rowViewModels.append(inCodeCellViewModel)
        }
        
        // Header
        
        let dividerDataModel = TextDataModel(text: .randomString())
        
        let headerViewModel = TableItemViewModel(data: dividerDataModel,
                                                map: DividerHeader.mapTitle)
        
        let section = TableListSection(header: headerViewModel,
                                  footer: nil,
                                  rows: rowViewModels)
        return section
    }
    
}

// MARK: - SegmentWithButtonViewDelegate

extension PlainExampleViewController: SegmentWithButtonViewDelegate {
    
    func segmentWithButtonViewDidTapOnReload(_ segmentView: SegmentWithButtonView) {
        reloadViewModels()
    }
    
    func segmentWithButtonViewDidSelectSegment(_ segmentView: SegmentWithButtonView, at index: Int) {
        let updateAnimation: TableListUpdateAnimation
        switch index {
        case 0: // default
            updateAnimation = .default
        case 1: // no animations
            updateAnimation = .noAnimations
        case 2: // custom
            // ListUpdateAnimations.rotate(angle: .pi, duration: 0.4, delayFactor: 0.07)
            updateAnimation = .custom(configuration: .slideIn(duration: 1.0, delayFactor: 0.06))
        default:
            updateAnimation = .default
        }
        self.updateAnimation = updateAnimation
    }
    
}
