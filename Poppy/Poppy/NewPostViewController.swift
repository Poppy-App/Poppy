//
//  NewPostViewController.swift
//  Poppy
//
//  Created by Herman Saini on 4/11/22.
//

import UIKit
import Firebase
import FirebaseStorage

class NewPostViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionBox: UITextView!
    
    @IBOutlet weak var nameBox: UITextField!
    
    @IBOutlet weak var statusChoose: UISegmentedControl!
    
    @IBOutlet weak var conditionChoice: UIButton!
    
    @IBOutlet weak var priceBox: UITextField!
    
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

}
