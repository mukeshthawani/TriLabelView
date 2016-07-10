//
//  TriLabelView.swift
//  TriLabelView
//
//  Created by Mukesh Thawani on 10/07/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//

import Foundation

@IBDesignable class TriLabelView: UIView {
    
    @IBInspectable var position: Position = .TopLeft {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lengthPercentage:CGFloat = 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func drawRect(rect: CGRect) {
        let trianglePath = UIBezierPath()
        var pointValues = [CGFloat]()
        let length = (lengthPercentage/100)*min(bounds.width, bounds.height)
        let viewSize = min(bounds.width, bounds.height)
        switch position {
        case .TopRight:
            pointValues = [viewSize, 0, viewSize, length, viewSize - length, 0, viewSize, 0]
        default:
            // Default is TopLeft
            pointValues = [0, 0, 0, length, length, 0, 0, 0]
            
        }
        trianglePath.moveToPoint(CGPoint(x: pointValues[0], y: pointValues[1]))
        trianglePath.addLineToPoint(CGPoint(x: pointValues[2], y: pointValues[3]))
        trianglePath.addLineToPoint(CGPoint(x: pointValues[4], y: pointValues[5]))
        trianglePath.addLineToPoint(CGPoint(x: pointValues[6], y: pointValues[7]))
        trianglePath.closePath()
        UIColor.blackColor().setStroke()
        UIColor.blueColor().setFill()
        trianglePath.lineWidth = 3
        trianglePath.fill()
        trianglePath.stroke()
    }
    
}

enum Position {
    case TopLeft
    case TopRight
    case BottomRight
    case BottomLeft
}