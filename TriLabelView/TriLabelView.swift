//
//  TriLabelView.swift
//  TriLabelView
//
//  Created by Mukesh Thawani on 10/07/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//

import Foundation

@IBDesignable public class TriLabelView: UIView {
    
    private var length = CGFloat()
    private var originalFrameValue = CGRect()
    
    public var position:Position = .TopLeft {
        didSet {
            updateFrameValue()
            setNeedsDisplay()
        }
    }
    
    @available(*, unavailable, message="This property is reserved for IB. Use position instead")
    @IBInspectable public var positionName: String? {
        didSet {
            setNeedsDisplay()
        }
        willSet {
            if let newPosition = Position(rawValue: newValue?.lowercaseString ?? "") {
                position = newPosition
            }
        }
    }
    
    @IBInspectable public var lengthPercentage:CGFloat = 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var labelText:String = "Hi"
    
    @IBInspectable public var fontSize:CGFloat = 20
    
    @IBInspectable public var viewColor:UIColor = UIColor.blueColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var textColor:UIColor = UIColor.blackColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.opaque = false
        originalFrameValue = self.frame
        updateFrameValue()
    }
    
    func updateFrameValue() {
        length = (lengthPercentage/100)*min(originalFrameValue.width, originalFrameValue.height)
        switch position {
        case .TopRight:
            frame = CGRectMake(originalFrameValue.width-length, 0, length, length)
        case .BottomLeft:
            frame = CGRectMake(0, originalFrameValue.height-length, length, length)
        case .BottomRight:
            frame = CGRectMake(originalFrameValue.width-length, originalFrameValue.height-length, length, length)
        default:
            frame = CGRectMake(0, 0, length, length)
        }
    }
    
    override public func drawRect(rect: CGRect) {
        let trianglePath = UIBezierPath()
        var pointValues = [CGFloat]()
        switch position {
        case .TopRight:
            pointValues = [frame.width, 0, frame.width, frame.width, 0, 0, frame.width, 0]
        case .BottomLeft:
            pointValues = [0, frame.width, 0, 0, frame.width, frame.width, 0, frame.width]
        case .BottomRight:
            pointValues = [frame.width, frame.width, frame.width, 0, 0, frame.width, frame.width, frame.width]
        default:
            // Default is TopLeft
            pointValues = [0, 0, 0, frame.width, frame.width, 0, 0, 0]
            
        }
        trianglePath.moveToPoint(CGPoint(x: pointValues[0], y: pointValues[1]))
        trianglePath.addLineToPoint(CGPoint(x: pointValues[2], y: pointValues[3]))
        trianglePath.addLineToPoint(CGPoint(x: pointValues[4], y: pointValues[5]))
        trianglePath.addLineToPoint(CGPoint(x: pointValues[6], y: pointValues[7]))
        trianglePath.closePath()
        UIColor.clearColor().setStroke()
        viewColor.setFill()
        trianglePath.fill()
        trianglePath.stroke()
        addSecondLabelView()
    }
    
    private func addSecondLabelView() {
        let (x, y, labelAngle,textWidth,textHeight) = getLabelPostion(frame.width)
        let firstLabel = UILabel()
        firstLabel.frame = CGRectMake(x, y, textWidth, textHeight)
        firstLabel.text = labelText
        firstLabel.transform = CGAffineTransformMakeRotation(labelAngle)
        firstLabel.textAlignment = .Center
        firstLabel.textColor = textColor
        firstLabel.changeFont(fontSize)
        self.addSubview(firstLabel)
        
    }
    
    private func getLabelPostion(length:CGFloat) -> (CGFloat,CGFloat,CGFloat,CGFloat,CGFloat) {
        var x = CGFloat()
        var y = CGFloat()
        var labelAngle:CGFloat = 0
        
        let (textWidth,textHeight) = getTextCGSize(labelText)
        
        switch position {
        case .TopRight:
            x = 2/3*length-textWidth/2
            y = 1/3*length-textHeight/2
            labelAngle = (3.14/4)
        case .BottomRight:
            x = 2/3*length-textWidth/2
            y = 2/3*length-textHeight/2
            labelAngle = (-3.14/4)
        case .BottomLeft:
            x = 1/3*length - textWidth/2
            y = 2/3*length-textHeight/2
            labelAngle = (3.14/4)
        default:
            x = 1/3*length - textWidth/2
            y = 1/3*length - textHeight/2
            labelAngle = (7*(3.14/4))
        }
        return(x,y,labelAngle,textWidth,textHeight)
    }
    
    func getTextCGSize(text:String) -> (CGFloat,CGFloat) {
        let uiFont:UIFont = UIFont.init(name: "HelveticaNeue-Bold", size: fontSize)!
        let textAttr = [NSFontAttributeName:uiFont]
        let nsText = text as NSString
        
        let cgSize = nsText.sizeWithAttributes(textAttr)
        return (cgSize.width,cgSize.height)
    }

    
}

public enum Position:String {
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