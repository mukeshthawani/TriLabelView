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
    private var colorList:[UIColor] = [.cyan,.cyan,.gray,.gray, .purple, .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        let cellSize = CGSize(width: viewWidth/2, height: viewHeight/3)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        let cellTriLabel = cell.triLabel!

        // Length Percentage
        cellTriLabel.lengthPercentage = 50
        
        // Text
        cellTriLabel.labelText = "NEW"
        
        // Text Color
        cellTriLabel.textColor = UIColor.white
        
        // Font Size
        cellTriLabel.fontSize = 19
        
        // Background Color
        cellTriLabel.viewColor = UIColor.brown
    
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
            cellTriLabel.isHidden = true
            break
        }
        cell.backgroundColor = colorList[indexPath.row]
        return cell
    }
}

