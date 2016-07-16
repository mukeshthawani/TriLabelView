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
    private var colorList:[UIColor] = [.cyanColor(),.magentaColor(),.purpleColor(),.grayColor(),.redColor(),.blueColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        let triLabel = TriLabelView(frame: cell.bounds)
        cell.addSubview(triLabel)
        cell.backgroundColor = colorList[indexPath.row]
        return cell
    }
}

