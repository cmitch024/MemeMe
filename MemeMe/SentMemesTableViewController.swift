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
    var memes = [Meme]()
    
    //*************************************************************
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        // Code for shared data model
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        // Refresh the tableView's data
        self.tableView.reloadData()
    }
    
    //**************************************************************
    // MARK: UITableViewDelegate & UITableViewDataSource
    
    // Set number of rows in table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    // Populate the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeMeTableViewCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the labels and image
        cell.textLabel?.text = meme.topString
        cell.detailTextLabel?.text = meme.bottomString
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    // React to user selection of row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
         //Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeMeDetailViewController") as! MemeMeDetailViewController
        
        // Populate VC with an image
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Present the VC using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
        
        
         // Dead code
//        // Get the storyboard and DetailVC
//        let storyboard = UIStoryboard (name: "Main", bundle: nil)
//        let detailVC = storyboard.instantiateViewController(withIdentifier: "MemeMeDetailViewController")as! MemeMeDetailViewController
//        
//        // Assign memed image to imageView in detailVC
//        detailVC.memeDetailImage.image = self.memes[(indexPath as NSIndexPath).row].memedImage
//        self.present(detailVC, animated: true, completion: nil)

    } // end didSelectRowAt
    
} // end SentMemesTableViewController
