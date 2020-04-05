//
//  CutoutView.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 31.01.20.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

@objc class CutoutView : UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(self.bounds)

        var subviews: [UIView] = superview?.subviews ?? []
        if superview is UITableViewHeaderFooterView, (superview?.subviews.count ?? 0) > 1 {
            subviews = Array(subviews.dropFirst())
        }

        for view in subviews where view != self {
            context?.setBlendMode(.clear)
            let rect = view.frame
            let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: view.layer.cornerRadius).cgPath
            context?.addPath(clipPath)
            context?.setFillColor(UIColor.clear.cgColor)
            context?.closePath()
            context?.fillPath()
        }
    }

    override func layoutSubviews() {
        setNeedsDisplay()
        superview?.ld_getGradient()?.frame = superview?.bounds ?? .zero
    }
}

extension UIView {

    private struct Configuration {
        static var cutoutHandle: UInt8 = 0
        static var gradientHandle: UInt8 = 0
    }

    func ld_addLoader() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.size.width , height: bounds.size.height)
        layer.insertSublayer(gradient, at: 0)
        configureAndAddAnimationToGradient(gradient, config: .default)
        addCutoutView()
    }

    func ld_removeLoader() {
        ld_getCutoutView()?.removeFromSuperview()
        ld_getGradient()?.removeAllAnimations()
        ld_getGradient()?.removeFromSuperlayer()
        subviews.applyForEachAnimatable({ $0.alpha = 1 })
    }

    fileprivate func ld_getCutoutView() -> UIView? {
        return objc_getAssociatedObject(self, &Configuration.cutoutHandle) as? UIView
    }

    fileprivate func ld_setCutoutView(_ aView : UIView) {
        return objc_setAssociatedObject(self, &Configuration.cutoutHandle, aView, .OBJC_ASSOCIATION_RETAIN)
    }

    fileprivate func ld_getGradient() -> CAGradientLayer? {
        return objc_getAssociatedObject(self, &Configuration.gradientHandle) as? CAGradientLayer
    }

    fileprivate func ld_setGradient(_ aLayer: CAGradientLayer) {
        return objc_setAssociatedObject(self, &Configuration.gradientHandle, aLayer, .OBJC_ASSOCIATION_RETAIN)
    }

    func configureAndAddAnimationToGradient(_ gradient: CAGradientLayer, config: ListLoader.AnimationConfiguration) {
        gradient.startPoint = CGPoint(x: -1.0 + CGFloat(config.gradientWidth), y: 0)
        gradient.endPoint = CGPoint(x: 1.0 + CGFloat(config.gradientWidth), y: 0)

        var gradientColors: [UIColor] = []

        for color in config.colors {
            gradientColors.append(color)
        }

        for color in config.colors.dropLast().reversed() {
            gradientColors.append(color)
        }

        gradient.colors = gradientColors.map({ $0.cgColor })

        let startPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.startPoint))
        let direction = config.direction
        startPointAnim.fromValue = direction.startPoint.from
        startPointAnim.toValue = direction.startPoint.to

        let endPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.endPoint))
        endPointAnim.fromValue = direction.endPoint.from
        endPointAnim.toValue = direction.endPoint.to

        let animGroup = CAAnimationGroup()
        animGroup.animations = [startPointAnim, endPointAnim]
        animGroup.duration = 1.2
        animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animGroup.repeatCount = .infinity

        gradient.add(animGroup, forKey: "")

        ld_setGradient(gradient)
    }

    fileprivate func addCutoutView() {
        subviews.applyForEachAnimatable({ $0.alpha = 0.0 })

        let cutout = CutoutView()
        cutout.frame = bounds
        cutout.backgroundColor = UIColor.clear

        addSubview(cutout)
        cutout.setNeedsDisplay()
        cutout.boundInside(self)
        bringSubviewToFront(cutout)

        ld_setCutoutView(cutout)
    }
}

@objc fileprivate extension UIView {
    func boundInside(_ superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["subview": self]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["subview": self]))
    }
}

fileprivate extension Array where Element: UIView {
    func applyForEachAnimatable(_ body: @escaping (Element) -> Void) {
        // TODO: Change 0.0 to configurational constant
        UIView.animate(withDuration: 0.0) {
            self.forEach(body)
        }
    }
}
