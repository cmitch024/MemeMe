//
//  MemeMeDetailViewController.swift
//  MemeMe
//
//  Created by cmitch024 on 8/2/17.
//  Copyright © 2017 cmitch024. All rights reserved.
//

import Foundation
import UIKit

class MemeMeDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var meme: Meme?
    
    // MARK: Outlet
    
    @IBOutlet weak var memeDetailImage: UIImageView!
    
    //*************************************************************
    // MARK: Lifecycle
    
    override func viewDidLoad() {
//        self.navigationItem.backBarButtonItem?.title = "Sent Memes"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeDetailImage.image = meme?.memedImage
    }
} // end MemeMeDetailViewController
