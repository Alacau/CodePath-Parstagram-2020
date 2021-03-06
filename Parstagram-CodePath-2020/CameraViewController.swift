//
//  CameraViewController.swift
//  Parstagram-CodePath-2020
//
//  Created by Alan Cao on 7/10/20.
//  Copyright © 2020 Alan Cao. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController {

    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var captionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func handleSubmit(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = captionTextField.text!
        post["author"] = PFUser.current()
        
        let imageData = postImageView.image?.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func handlePostImageViewTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        postImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
}
