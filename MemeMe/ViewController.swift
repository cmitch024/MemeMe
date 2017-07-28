//
//  ViewController.swift
//  MemeMe
//
//  Created by cmitch024 on 7/25/17.
//  Copyright © 2017 cmitch024. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var memeImage: UIImageView!
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    } // end pickAnImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    } // end viewDidLoad
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("imagePickerController method called.")
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    } // end imagePickerController
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel method called.")
        dismiss(animated: true, completion: nil)
    } // end imagePickerControllerDidCancel
    
} // end ViewController

