//
//  TriangleLoader.swift
//  triangleLoader
//
//  Created by Pavel Kozlov on 06/08/2018.
//  Copyright © 2018 Pavel Kozlov. All rights reserved.
//

import Foundation
import UIKit

class TriangleLoader: UIView {
    
    var centerTriangle: CAShapeLayer!
    var topTriangle: CAShapeLayer!
    var rightTriangle: CAShapeLayer!
    var leftTriangle: CAShapeLayer!
    
    var isAnimating = false
    
    private let duration = 1.43
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createEquilateralTriangle(bounds.width)
    }
    
    func createEquilateralTriangle(_ squareSize: CGFloat) {
        let mainTrianglePath = UIBezierPath()
        
        let pointA = CGPoint(x: squareSize / 2, y: 0)
        let pointB = CGPoint(x: squareSize * (2 + sqrt(3.0)) / 4,
                             y: squareSize * 3 / 4)
        let pointC = CGPoint(x: squareSize * (2 - sqrt(3.0)) / 4,
                             y: squareSize * 3 / 4)
        
        mainTrianglePath.move(to: pointA)
        mainTrianglePath.addLine(to: pointB)
        mainTrianglePath.addLine(to: pointC)
        mainTrianglePath.close()
        
        centerTriangle = CAShapeLayer()
        centerTriangle.frame = bounds
        centerTriangle.fillColor = UIColor.black.cgColor
        centerTriangle.path = mainTrianglePath.cgPath
        layer.addSublayer(centerTriangle)
        
        
        let topTrianglePath = UIBezierPath()
        topTrianglePath.move(to: pointA)
        topTrianglePath.addLine(to: midpoint(from: pointA, to: pointB))
        topTrianglePath.addLine(to: midpoint(from: pointA, to: pointC))
        topTrianglePath.close()
        
        topTriangle = CAShapeLayer()
        topTriangle.frame = bounds
        topTriangle.fillColor = UIColor.black.cgColor
        topTriangle.path = topTrianglePath.cgPath
        layer.addSublayer(topTriangle)
        
        let rightTrianglePath = UIBezierPath()
        rightTrianglePath.move(to: midpoint(from: pointA, to: pointB))
        rightTrianglePath.addLine(to: pointB)
        rightTrianglePath.addLine(to: midpoint(from: pointB, to: pointC))
        rightTrianglePath.close()
        
        rightTriangle = CAShapeLayer()
        rightTriangle.frame = bounds
        rightTriangle.fillColor = UIColor.black.cgColor
        rightTriangle.path = rightTrianglePath.cgPath
        layer.addSublayer(rightTriangle)
        
        let leftTrianglePath = UIBezierPath()
        leftTrianglePath.move(to: midpoint(from: pointA, to: pointC))
        leftTrianglePath.addLine(to: midpoint(from: pointB, to: pointC))
        leftTrianglePath.addLine(to: pointC)
        leftTrianglePath.close()
        
        leftTriangle = CAShapeLayer()
        leftTriangle.frame = bounds
        leftTriangle.fillColor = UIColor.black.cgColor
        leftTriangle.path = leftTrianglePath.cgPath
        layer.addSublayer(leftTriangle)
    }
    
    
    func startAnimating() {
        guard !isAnimating else { return }
        isAnimating = true
        
        let rotateMainAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        rotateMainAnimation.keyTimes = [0.0, 0.9, 1.0]
        rotateMainAnimation.values = [0.0, CGFloat.pi / 3 * 0.980, CGFloat.pi / 3]
        
        let scaleMainAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleMainAnimation.fromValue = 1.0
        scaleMainAnimation.toValue = 0.5
        scaleMainAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let groupMainAnimation = CAAnimationGroup()
        groupMainAnimation.animations = [rotateMainAnimation, scaleMainAnimation]
        groupMainAnimation.duration = duration
        groupMainAnimation.repeatCount = Float.infinity
        groupMainAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        centerTriangle.add(groupMainAnimation, forKey: "groupMainAnimation")
        
        
        //FIRST
        let rotateTopAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateTopAnimation.fromValue = CGFloat.pi
        rotateTopAnimation.toValue = CGFloat.pi * 2
        
        let scaleTopAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleTopAnimation.fromValue = 0.0
        scaleTopAnimation.toValue = 1.0
        
        let positionTopAnimation = CAKeyframeAnimation(keyPath: "position")
        let topPath = UIBezierPath()
        topPath.move(to: CGPoint(x: -bounds.size.width / 4,
                              y: bounds.size.height / 4))
        topPath.addQuadCurve(to: CGPoint(x: bounds.size.width / 2,
                                         y: bounds.size.height / 2),
            controlPoint: CGPoint(x: bounds.size.width / 4,
                                  y: 0))
        positionTopAnimation.path = topPath.cgPath
        
        let groupTopAnimation = CAAnimationGroup()
        groupTopAnimation.animations = [rotateTopAnimation, scaleTopAnimation, positionTopAnimation]
        groupTopAnimation.duration = duration
        groupTopAnimation.repeatCount = Float.infinity
        groupTopAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        topTriangle.add(groupTopAnimation, forKey: "groupTopAnimation")
        
        
        //SECOND
        let rotateRightAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateRightAnimation.fromValue = CGFloat.pi
        rotateRightAnimation.toValue = CGFloat.pi * 2
        
        let scaleRightAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleRightAnimation.fromValue = 0.0
        scaleRightAnimation.toValue = 1.0
        
        let positionRightAnimation = CAKeyframeAnimation(keyPath: "position")
        let rightPath = UIBezierPath()
        rightPath.move(to: CGPoint(x: bounds.size.width,
                                 y: 0))
        rightPath.addQuadCurve(to: CGPoint(x: bounds.size.width / 2,
                                           y: bounds.size.height / 2),
                               controlPoint: CGPoint(x: bounds.size.width,
                                                     y: bounds.size.height))
        positionRightAnimation.path = rightPath.cgPath
        
        let groupRightAnimation = CAAnimationGroup()
        groupRightAnimation.animations = [rotateRightAnimation, scaleRightAnimation, positionRightAnimation]
        groupRightAnimation.duration = duration
        groupRightAnimation.repeatCount = Float.infinity
        groupRightAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        rightTriangle.add(groupRightAnimation, forKey: "groupRightAnimation")
        
        //THIRD
        let rotateLeftAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateLeftAnimation.fromValue = CGFloat.pi
        rotateLeftAnimation.toValue = CGFloat.pi * 2
        
        let scaleLeftAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleLeftAnimation.fromValue = 0.0
        scaleLeftAnimation.toValue = 1.0
        
        let positionLeftAnimation = CAKeyframeAnimation(keyPath: "position")
        let leftPath = UIBezierPath()
        leftPath.move(to: CGPoint(x: bounds.size.width / 2,
                                   y: bounds.size.height * 5 / 4))
        leftPath.addQuadCurve(to: CGPoint(x: bounds.size.width / 2,
                                           y: bounds.size.height / 2),
                               controlPoint: CGPoint(x: 0,
                                                     y: bounds.size.height * 3 / 4))
        positionLeftAnimation.path = leftPath.cgPath
        
        let groupLeftAnimation = CAAnimationGroup()
        groupLeftAnimation.animations = [rotateLeftAnimation, scaleLeftAnimation, positionLeftAnimation]
        groupLeftAnimation.duration = duration
        groupLeftAnimation.repeatCount = Float.infinity
        groupLeftAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        leftTriangle.add(groupLeftAnimation, forKey: "groupLeftAnimation")
    }
    
    func stopAnimating() {
        guard isAnimating else { return }
        isAnimating = false

        centerTriangle.removeAllAnimations()
        topTriangle.removeAllAnimations()
        rightTriangle.removeAllAnimations()
        leftTriangle.removeAllAnimations()
    }
    
    func midpoint(from start: CGPoint, to end: CGPoint) -> CGPoint {
        let x = (end.x + start.x) / 2
        let y = (end.y + start.y) / 2
        return CGPoint(x: x, y: y)
    }
}
