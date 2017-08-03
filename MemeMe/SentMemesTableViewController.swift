//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by cmitch024 on 8/2/17.
//  Copyright © 2017 cmitch024. All rights reserved.
//

import Foundation
import UIKit
//UITableViewDataSource
class SentMemesTableViewController: UITableViewController {
    
    //MARK: Properties
    // Local verson of the data model
    var memes: [Meme]!
    
    //*************************************************************
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Code for shared data model
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    //**************************************************************
    // MARK: UITableViewDelegate 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeMeDetailViewController") as! MemeMeDetailViewController
        
        // Populate VC with an image
        detailController.memeDetailImage.image = memes[(indexPath as NSIndexPath).row].memedImage
        
        // Present the VC using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    
} // end SentMemesTableViewController
