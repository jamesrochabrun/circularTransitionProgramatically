//
//  CircularTransition.swift
//  CircularTransitionProgramUI
//
//  Created by James Rochabrun on 3/17/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

import UIKit


class CircularTransition: NSObject {
    
    var circle = UIView()
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    var circleColor: UIColor = .white
    var duration = 0.3
    
    enum CircularTransitionMode: Int {
        case present, dismiss, pop
    }
    var transitionMode: CircularTransitionMode = .present
    
    //Logic
    fileprivate func frameForCircleWith(viewCenter: CGPoint, viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startingPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startingPoint.y)
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size =  CGSize(width: offsetVector, height: offsetVector)
        return CGRect(origin: CGPoint.zero, size: size)
    }
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                circle = UIView()
                
                circle.frame = frameForCircleWith(viewCenter: viewCenter, viewSize: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                containerView.addSubview(circle)
                
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: { (complete) in
                    if complete {
                        transitionContext.completeTransition(complete)
                    }
                })
            }
        } else {
            //dismiss or pop
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircleWith(viewCenter: viewCenter, viewSize: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                }, completion: { (complete) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(complete)
                })
                
                
            }
        }
    }
}


