//
//  TriLabelView.swift
//  TriLabelView
//
//  Created by Mukesh Thawani on 10/07/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//

import Foundation

@IBDesignable class TriLabelView: UIView {
    
    let secondLabel = UILabel()
    var length = CGFloat()
    var viewSize = CGFloat()
    
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
    
    @IBInspectable var firstLabelText:String = "Hi"
    
    
    override func drawRect(rect: CGRect) {
        let trianglePath = UIBezierPath()
        var pointValues = [CGFloat]()
        length = (lengthPercentage/100)*min(bounds.width, bounds.height)
        viewSize = min(bounds.width, bounds.height)
        switch position {
        case .TopRight:
            pointValues = [viewSize, 0, viewSize, length, viewSize - length, 0, viewSize, 0]
            //        case .BottomLeft:
            //
            //        case .BottomRight:
            
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
        addSecondLabelView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSecondLabelView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSecondLabelView()
    }
    
    
    private func addSecondLabelView() {
        var x = CGFloat()
        var y = CGFloat()
        length = (lengthPercentage/100)*min(bounds.width, bounds.height)
        viewSize = min(bounds.width, bounds.height)
        switch position {
        case .TopRight:
            x = viewSize
            y = 0.1 * length
            //        case .BottomRight:
            //
            //        case .BottomLeft:
        //
        default:
            x = 0
            y = 0.1 * length
        }
        let firstLabel = UILabel()
        firstLabel.frame = CGRectMake(x, y, length, 20)
        firstLabel.text = firstLabelText
        firstLabel.transform = CGAffineTransformMakeRotation(3*(3.14/2) + (3.14/4))
        firstLabel.backgroundColor = UIColor.brownColor()
        self.addSubview(firstLabel)
    }
    
}

enum Position {
    case TopLeft
    case TopRight
    case BottomRight
    case BottomLeft
}