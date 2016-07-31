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
  private var newRect = CGRect()
  
  public var position:Position = .TopLeft {
    didSet {
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
  
  @IBInspectable public var labelText:String = "Hi" {
    didSet {
      setNeedsDisplay()
    }
  }
  
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
  }
  
  func updateNewRect() {
    let rectWidth = bounds.width
    let rectHeight = bounds.height
    length = (lengthPercentage/100)*min(rectWidth, rectHeight)
    switch position {
    case .TopRight:
      newRect = CGRectMake(rectWidth-length, 0, length, length)
    case .BottomLeft:
      newRect = CGRectMake(0, rectHeight-length, length, length)
    case .BottomRight:
      newRect = CGRectMake(rectWidth-length, rectHeight-length, length, length)
    default:
      newRect = CGRectMake(0, 0, length, length)
    }
  }
  
  override public func drawRect(rect: CGRect) {
    updateNewRect()
    let trianglePath = UIBezierPath()
    var pointValues = [CGFloat]()
    let rectOriginX = newRect.origin.x
    let rectOriginY = newRect.origin.y
    let rectWidth = newRect.width + rectOriginX
    let rectHeight = newRect.width + rectOriginY
    switch position {
    case .TopRight:
      pointValues = [rectOriginX,rectOriginY, rectWidth, rectOriginY, rectWidth, rectHeight, rectOriginX, rectOriginY]
    case .BottomLeft:
      pointValues = [rectOriginX, rectOriginY, rectWidth, rectHeight, rectOriginX, rectHeight, rectOriginX, rectOriginY]
    case .BottomRight:
      pointValues = [rectWidth, rectOriginY, rectWidth, rectHeight, rectOriginX, rectHeight, rectWidth, rectOriginY]
    default:
      // Default is TopLeft
      pointValues = [rectOriginX, rectOriginY, rectWidth, rectOriginY, rectOriginX, rectHeight, rectOriginX, rectOriginY]
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
    self.clearChildViews()
    let (x, y, labelAngle,textWidth,textHeight) = getLabelPostion(newRect.width)
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
    let rectOriginX = newRect.origin.x
    let rectOriginY = newRect.origin.y
    let rectWidth = newRect.width
    let (textWidth,textHeight) = getTextCGSize(labelText)
    
    switch position {
    case .TopRight:
      x = (2/3*rectWidth+rectOriginX)-textWidth/2
      y = (1/3*rectWidth+rectOriginY)-textHeight/2
      labelAngle = (3.14/4)
    case .BottomRight:
      x = (2/3*rectWidth+rectOriginX)-textWidth/2
      y = (2/3*rectWidth+rectOriginY)-textHeight/2
      labelAngle = (-3.14/4)
    case .BottomLeft:
      x = (1/3*rectWidth+rectOriginX)-textWidth/2
      y = (2/3*rectWidth+rectOriginY)-textHeight/2
      labelAngle = (3.14/4)
    default:
      x = (1/3*rectWidth+rectOriginX) - textWidth/2
      y = (1/3*rectWidth+rectOriginY) - textHeight/2
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

extension UIView {
  func clearChildViews(){
    subviews.forEach({ $0.removeFromSuperview() })
  }
}

extension UILabel {
  func changeFont(fontSize:CGFloat) {
    font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
    adjustsFontSizeToFitWidth = true
  }
}