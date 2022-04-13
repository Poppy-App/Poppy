//
//  NewPostViewController.swift
//  Poppy
//
//  Created by Herman Saini on 4/11/22.
//

import UIKit
import Firebase
import FirebaseStorage
import AlamofireImage

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var descriptionBox: UITextView!
    
    @IBOutlet weak var nameBox: UITextField!
    
    @IBOutlet weak var statusChoose: UISegmentedControl!
    
    @IBOutlet weak var conditionChoice: UIButton!
    
    @IBOutlet weak var priceBox: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionChoice.changesSelectionAsPrimaryAction = true
        conditionChoice.showsMenuAsPrimaryAction = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraOpen(_ sender: Any) {
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
           let size = CGSize(width: 230, height: 230)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
           imageView.image = scaledImage
           dismiss(animated: true, completion: nil)
       }
    
    
    @IBAction func onPost(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
