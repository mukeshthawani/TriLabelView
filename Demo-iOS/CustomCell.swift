//
//  CustomCell.swift
//  TriLabelView
//
//  Created by Mukesh Thawani on 01/08/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//

import UIKit
import TriLabelView

class CustomCell: UICollectionViewCell {
  
  var triLabel:TriLabelView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    // Initialize
    triLabel = TriLabelView(frame: bounds)
    addSubview(triLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
