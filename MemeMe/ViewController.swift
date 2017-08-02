//
//  ViewController.swift
//  MemeMe
//
//  Created by cmitch024 on 7/25/17.
//  Copyright © 2017 cmitch024. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    //MARK: IBOutlets
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    //MARK: IBActions
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        presentImagePickerWith(sourceType: .photoLibrary)
    } // end pickAnImage
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePickerWith(sourceType: .camera)
    } // end pickAnImage
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    } // end presentImagePickerWith
    
    
    @IBAction func shareMeme(_ sender: Any) {
        let meme = generateMemedImage()
        
        let view = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        present(view, animated: true, completion: nil)
        
        view.completionWithItemsHandler = {
            activity,completed,items,error in
            if completed {
                self.save(memedImage: meme)
                self.dismiss(animated: true, completion: nil)
            }
        }
    } // end shareMeme
    
    //MARK: generate a meme object
    // Store meme object
    var memeObject: Meme?
    
    // Save a meme to the memeObject property
    func save(memedImage: UIImage) {
        memeObject = Meme(topString: topText.text!, bottomString: bottomText.text!, origionalImage: memeImage.image!, memedImage: memedImage)
        
        // Add it to the memes array in the App Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append((memeObject)!)
    } // end save
    
    // Generate a meme based on the selected image and typed text
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        configureToolbars(hidden: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        configureToolbars(hidden: false)
        
        return memedImage
    } // end generateMemedImage
    
    func configureToolbars(hidden: Bool){
        if hidden {
            toolbar.isHidden = true
            navbar.isHidden = true
        } else {
            toolbar.isHidden = false
            navbar.isHidden = false
        }
    } // end configureToolbars
    
    //MARK: meme text attributes
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -1.0,
        NSBackgroundColorAttributeName: UIColor.clear]
    
    //MARK: Lifecycle events
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        if memeImage.image != nil {
        shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        
        configure(textField: topText, text: "TOP TEXT", defaultAttributes: memeTextAttributes)
        configure(textField: bottomText, text: "BOTTOM TEXT", defaultAttributes: memeTextAttributes)
        
        subscribeToKeyboardNotifications()
    } // end viewWillAppear
    
    //Configure the text fields for use
    func configure(textField: UITextField, text: String, defaultAttributes: [String:Any]) {
        textField.delegate = self
        textField.text = text
        textField.defaultTextAttributes = self.memeTextAttributes
        textField.textAlignment = .center
        } // end configure
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    } // end viewWillDisappear
    
    override func viewDidLoad() {
        super.viewDidLoad()
    } // end viewDidLoad
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        
    } // end textFieldDidBeginEditing
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    } // end textFielddShouldReturn
    
    //MARK: View adjustment for keyboard
    func keyboardWillShow(_ notification:Notification) {
        if bottomText.isFirstResponder {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    } // end keyboardWillShow
    
    func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    } // end keyboardWillHide
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    } // end getKeyboardHeight
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    } // end subscribeToKeyboardNotifications
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    } // end unsubscribeFromKeyboardNotifications
    
    //MARK: Image picker controller functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    } // end imagePickerController
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    } // end imagePickerControllerDidCancel
    
} // end ViewController

