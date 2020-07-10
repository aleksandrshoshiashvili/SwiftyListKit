//
//  ListContentType.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 10.07.20.
//

import Foundation

@available(iOS 14.0, *)
public enum ListContentType {
    case cell
    case subtitleCell
    case valueCell
    case plainHeader
    case plainFooter
    case groupedHeader
    case groupedFooter
    case sidebarCell
    case sidebarSubtitleCell
    case sidebarHeader
}

@available(iOS 14.0, *)
extension ListContentType {

    var config: UIListContentConfiguration {
        switch self {
        case .cell:
            return .cell()
        case .subtitleCell:
            return .subtitleCell()
        case .valueCell:
            return .valueCell()
        case .plainHeader:
            return .plainHeader()
        case .plainFooter:
            return .plainFooter()
        case .groupedHeader:
            return .groupedHeader()
        case .groupedFooter:
            return .groupedFooter()
        case .sidebarCell:
            return .sidebarCell()
        case .sidebarSubtitleCell:
            return .sidebarSubtitleCell()
        case .sidebarHeader:
            return .sidebarHeader()
        }
    }

}
