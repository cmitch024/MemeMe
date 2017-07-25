//
//  ViewController.swift
//  MemeMe
//
//  Created by cmitch024 on 7/25/17.
//  Copyright © 2017 cmitch024. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var memeImage: UIImageView!
    
    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        present(pickerController, animated: true, completion: nil)
    } // end pickAnImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    } // end viewDidLoad
    
} // end ViewController

