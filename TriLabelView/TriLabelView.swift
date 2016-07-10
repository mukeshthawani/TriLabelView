//
//  TriLabelView.swift
//  TriLabelView
//
//  Created by Mukesh Thawani on 10/07/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//

import Foundation

@IBDesignable class TriLabelView: UIView {
    
    private var length = CGFloat()
    private var viewSize = CGFloat()
    
    var position:Position = .TopLeft
    
    @available(*, unavailable, message="This property is reserved for IB. Use position instead")
    @IBInspectable var positionName: String? {
        didSet {
            setNeedsDisplay()
        }
        willSet {
            if let newPosition = Position(rawValue: newValue?.lowercaseString ?? "") {
                position = newPosition
            }
        }
    }
    
    @IBInspectable var lengthPercentage:CGFloat = 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var firstLabelText:String = "Hi"
    
    @IBInspectable var fontSize:CGFloat = 20
    
    
    override func drawRect(rect: CGRect) {
        let trianglePath = UIBezierPath()
        var pointValues = [CGFloat]()
        length = (lengthPercentage/100)*min(bounds.width, bounds.height)
        viewSize = min(bounds.width, bounds.height)
        switch position {
        case .TopRight:
            pointValues = [viewSize, 0, viewSize, length, viewSize - length, 0, viewSize, 0]
        case .BottomLeft:
            pointValues = [0, viewSize, 0, viewSize - length, length, viewSize, 0, viewSize]
        case .BottomRight:
            pointValues = [viewSize, viewSize, viewSize, viewSize - length, viewSize - length, viewSize, viewSize, viewSize]
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
        let (x, y, labelAngle) = getLabelPostion(viewSize, length: length)
        let firstLabel = UILabel()
        firstLabel.frame = CGRectMake(x, y, length, 0.3*length)
        firstLabel.text = firstLabelText
        firstLabel.transform = CGAffineTransformMakeRotation(labelAngle)
        //        firstLabel.backgroundColor = UIColor.brownColor()
        firstLabel.textAlignment = .Center
        firstLabel.changeFont(fontSize)
        self.addSubview(firstLabel)
    }
    
    private func getLabelPostion(viewSize:CGFloat, length:CGFloat) -> (CGFloat,CGFloat,CGFloat) {
        var x = CGFloat()
        var y = CGFloat()
        var labelAngle:CGFloat = 0
        switch position {
        case .TopRight:
            x = (viewSize - (0.8*length))
            y = 0.2*length
            labelAngle = (3.14/4)
        case .BottomRight:
            x = (viewSize - (0.8*length))
            y = (viewSize - (0.5*length))
            labelAngle = (-3.14/4)
        case .BottomLeft:
            x = (-0.2*length)
            y = (viewSize - (0.5*length))
            labelAngle = (3.14/4)
        default:
            x = (-0.2*length)
            y = 0.2*length
            labelAngle = (7*(3.14/4))
        }
        return(x,y,labelAngle)
    }
    
}

enum Position:String {
    case TopLeft = "topleft"
    case TopRight = "topright"
    case BottomRight = "bottomright"
    case BottomLeft = "bottomleft"
}

extension UILabel {
    func changeFont(fontSize:CGFloat) {
        font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        adjustsFontSizeToFitWidth = true
    }
}