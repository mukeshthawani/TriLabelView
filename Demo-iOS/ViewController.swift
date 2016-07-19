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
    private var colorList:[UIColor] = [.cyanColor(),.magentaColor(),.purpleColor(),.grayColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        let triLabel = TriLabelView(frame: cell.bounds)
        triLabel.labelText = "NEW"
        triLabel.viewColor = UIColor.orangeColor()
        switch indexPath.row {
        case 1:
            triLabel.position = .TopRight
        case 2:
            triLabel.position = .BottomLeft
        case 3:
            triLabel.position = .BottomRight
        default:
            triLabel.position = .TopLeft
        }
        cell.addSubview(triLabel)
        cell.backgroundColor = colorList[indexPath.row]
        return cell
    }
}

