//
//  ViewController.swift
//  Demo-iOS
//
//  Created by Mukesh Thawani on 10/07/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//

import UIKit
import TriLabelView

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    private var colorList:[UIColor] = [.cyanColor(),.cyanColor(),.grayColor(),.grayColor(), .purpleColor(), .purpleColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.whiteColor()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        let cellSize = CGSize(width: viewWidth/2, height: viewHeight/3)
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        let cellTriLabel = cell.triLabel

        // Length Percentage
        cellTriLabel.lengthPercentage = 50
        
        // Text
        cellTriLabel.labelText = "NEW"
        
        // Text Color
        cellTriLabel.textColor = UIColor.whiteColor()
        
        // Font Size
        cellTriLabel.fontSize = 19
        
        // Background Color
        cellTriLabel.viewColor = UIColor.brownColor()
        
        switch indexPath.row {
        case 0:
          cellTriLabel.position = .TopLeft
        case 1:
            cellTriLabel.position = .TopRight
        case 2:
            cellTriLabel.position = .BottomLeft
        case 3:
            cellTriLabel.position = .BottomRight
        default:
            cellTriLabel.hidden = true
            break
        }
        cell.backgroundColor = colorList[indexPath.row]
        return cell
    }
}

