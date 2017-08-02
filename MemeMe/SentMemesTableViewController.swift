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
class SentMemesTableViewController: UITableViewController  {
    
    //MARK: Properties
    // Local verson of the data model
    var memes: [Meme]!
    
    //*************************************************************
    // MARK: Lifecycle
    override func viewDidLoad() {
        // Code for shared data model
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
} // end SentMemesTableViewController
