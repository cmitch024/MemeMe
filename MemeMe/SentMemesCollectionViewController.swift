//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by cmitch024 on 8/2/17.
//  Copyright © 2017 cmitch024. All rights reserved.
//

import Foundation
import UIKit

// UICollectionViewDelegate
class SentMemesCollectionViewController: UICollectionViewController  {
    // Local verson of the data model
    var memes: [Meme]!
    
    //*************************************************************
    // MARK: Outlets
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //*************************************************************
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Code for shared data model
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        // Code for collection view flow layout
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    //**************************************************************
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    // Set number of items in collection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    // Build a custom cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeMeCollectionViewCell", for: indexPath) as! MemeMeCollectionViewCell
        // Set the image
        cell.memeImage.image = UIImage(named: memes[(indexPath as NSIndexPath).row].memedImage.description)
        
        return cell
    }
    
    // Respond to user selection
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeMeDetailViewController") as! MemeMeDetailViewController
        
        // Populate VC with an image
        detailController.memeDetailImage.image = memes[(indexPath as NSIndexPath).row].memedImage
        
        // Present the VC using navigation
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
} // end SentMemesCollectionViewController
