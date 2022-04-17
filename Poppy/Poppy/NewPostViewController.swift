//
//  NewPostViewController.swift
//  Poppy
//
//  Created by Herman Saini on 4/11/22.
//  Finished by Yashvardhan Khaitan on 4/17/22.

import UIKit
import Firebase
import FirebaseStorage
import AlamofireImage

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var descriptionBox: UITextView!
    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var statusChoose: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var priceBox: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ageBox: UITextField!
    
    let pickerData = [String](arrayLiteral: "Flawless", "Good", "Scratches", "Broken")
    var valueSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        valueSelected = pickerData[row] as String
        return pickerData[row]
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
        let title = nameBox.text!
        let description = descriptionBox.text!
        let usage = statusChoose.selectedSegmentIndex // 0 or 1
        let price = priceBox.text!
        let age = ageBox.text!
        
        print(title)
        print(description)
        print(usage)
        print(valueSelected)
        print(price)
        
        guard let imageData = imageView.image?.pngData() else {
            print("can't get image data")
            return
        }

        let storageRef = FirebaseStorage.Storage.storage().reference()
        guard let userUIUD = Firebase.Auth.auth().currentUser?.uid else {
            print("can't set filename")
            return
        }

        let fileRef = storageRef.child("\(userUIUD)/files/\(Date().timeIntervalSince1970.formatted()).png")

        let uploadTask = fileRef.putData(imageData, metadata: nil) {
            metadata, error in guard metadata != nil else {
                return
            }
            
            if error != nil {
                print(error?.localizedDescription ?? "Error")
                return
            }

            fileRef.downloadURL {
                url, error in if error != nil {
                    print("Error getting file url")
                    return
                }

                var post:[String:Any] = [String:Any]()
                post["listingTitle"] = title
                post["descrip"] = description
                
                if (usage == 0) {
                    post["PriorUse"] = "New"
                } else if (usage == 1) {
                    post["PriorUse"] = "Used"
                }
                
                post["condition"] = self.valueSelected
                post["price"] = price
                post["age"] = age
                post["image"] = url?.absoluteString ?? ""
                
                post["user_id"] = "\(userUIUD)"
                
                let postID = "\(userUIUD)-post\(Date().timeIntervalSince1970.formatted())"
                
                let db = Firestore.firestore()
                db.collection("listing").document(postID).setData(post) {
                    error in if error != nil {
                        print("Error making post!")
                    } else {
                        print("Post successfully written!")
//                        self.performSegue(withIdentifier: "backToListing", sender: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
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
