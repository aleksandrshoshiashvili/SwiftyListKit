import UIKit

@objc open class ListLoader: NSObject {
    
    public typealias AnimationPoint = (from: CGPoint, to: CGPoint)

    public enum ListLoaderType {
        case solid(config: SolidConfiguration)
        case animated(config: AnimationConfiguration)
    }

    public struct AnimationConfiguration {
        public var loaderDuration = 0.85
        public var gradientWidth = 0.17
        public var gradientFirstStop = 0.1
        public var appearenceAnimationDuration = 0.0
        public var direction: Direction = .fromLeftToRight
        public var colors: [UIColor] = [
            .gray,
            .lightGray,
            .gray
        ]
    }

    public struct SolidConfiguration {
        public static var loaderDuration = 0.85
        public static var gradientWidth = 0.17
        public static var gradientFirstStop = 0.1
        public static var direction: Direction = .fromLeftToRight
        public static var colors: [UIColor] = [
            .gray,
            .lightGray,
            .gray
        ]
    }

    public enum Direction {
        case fromLeftToRight
        case fromRightToLeft
        case fromTopToBottom
        case fromBottomToTop
        case fromTopLeftToBottomRight
        case fromBottomRightToTopLeft
        case custom(startPoint: AnimationPoint, endPoint: AnimationPoint)
        
        var startPoint: AnimationPoint {
            switch self {
            case .fromLeftToRight:
                return (from: CGPoint(x: -1, y: 0), to: CGPoint(x: 1, y: 0))
            case .fromRightToLeft:
                return (from: CGPoint(x: 1, y: 0.0), to: CGPoint(x: -1, y: 0.0))
            case .fromTopToBottom:
                return (from: CGPoint(x: 0.0, y: -1), to: CGPoint(x: 0.0, y: 1))
            case .fromBottomToTop:
                return (from: CGPoint(x: 0.0, y: 1), to: CGPoint(x: 0.0, y: -1))
            case .fromTopLeftToBottomRight:
                return (from: CGPoint(x: -1, y: -1), to: CGPoint(x: 1, y: 1))
            case .fromBottomRightToTopLeft:
                return (from: CGPoint(x: 1, y: 1), to: CGPoint(x: -1, y: -1))
            case .custom(let startPoint, _):
                return startPoint
            }
        }
        
        var endPoint: AnimationPoint {
            switch self {
            case .fromLeftToRight, .fromRightToLeft:
                return (from: CGPoint(x: startPoint.from.x + 1, y: 0),
                        to: CGPoint(x: startPoint.to.x, y: 0))
            case .fromTopToBottom, .fromBottomToTop:
                return ( from: CGPoint(x: 0.0, y: startPoint.from.y + 1),
                         to: CGPoint(x: 0.0, y: startPoint.to.y + 1))
            case .fromTopLeftToBottomRight, .fromBottomRightToTopLeft:
                return ( from: CGPoint(x: startPoint.from.x + 1, y: startPoint.from.y + 1),
                         to: CGPoint(x: startPoint.to.x + 1, y: startPoint.to.y + 1))
            case .custom(_, let endPoint):
                return endPoint
            }
        }
    }
    
    static func addLoaderToViews(_ views : [UIView]) {
        CATransaction.begin()
        views.forEach { $0.ld_addLoader() }
        CATransaction.commit()
    }
    
    static func removeLoaderFromViews(_ views: [UIView]) {
        CATransaction.begin()
        views.forEach { $0.ld_removeLoader() }
        CATransaction.commit()
    }
    
    public static func addLoaderTo(_ list : ListLoadable, loaderType: ListLoaderType) {
        let visibleContent = list.ld_visibleContentViews()
        self.addLoaderToViews(visibleContent)
    }
    
    
    public static func removeLoaderFrom(_ list : ListLoadable) {
        let visibleContent = list.ld_visibleContentViews()
        self.removeLoaderFromViews(visibleContent)
    }
}

public extension ListLoader.SolidConfiguration {

    static var `default`: Self {
        return .init()
    }

}

public extension ListLoader.AnimationConfiguration {

    static var `default`: Self {
        return .init()
    }

}
