//
//  ItemViewerViewController.swift
//  Poppy
//
//  Created by Herman Saini on 4/7/22.
//

import UIKit
import Firebase

class ItemViewerViewController: UIViewController {
    
    var listing: [String:Any]!

    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemPhoto: UIImageView!
    
    @IBOutlet weak var itemDescription: UILabel!
    
    @IBOutlet weak var usedOrNot: UILabel!
    
    @IBOutlet weak var Age: UILabel!
    
    @IBOutlet weak var ConditionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var collegeYear: UILabel!
    
    @IBOutlet weak var itemsSold: UILabel!
    
    var listerUID = "";
    
    @IBAction func venmoButton(_ sender: Any) {
        Firestore.firestore().collection("users").document(listerUID).getDocument { snapshot, error in
            if error != nil {
                // ERROR
                print("error")
            }
            else {
                let userVemo = snapshot?.get("venmo") as! String
                let venurl = "https://account.venmo.com/u/"
                UIApplication.shared.open(URL(string: venurl + userVemo)! as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameLabel.text = listing["listingTitle"] as? String ?? ""
        guard let url = URL(string: "\(listing["image"] as? String ?? "")") else {
            print("can't get image url")
            itemPhoto.image = UIImage(named: "image_placeholder")!
            return
        }
        
        itemPhoto.af.setImage(withURL: url)
        itemDescription.text = listing["descrip"] as? String ?? ""
        let PriorUse = "\u{2022} \(listing["PriorUse"]!)"
        let age = "\u{2022} \(listing["age"]!) Years Old"
        let condition = "\u{2022} \(listing["condition"]!)"
        usedOrNot.text = PriorUse
        Age.text = age
        ConditionLabel.text = condition
        let price = "\u{2022} $\(listing["price"]!)"
        
        let user_id = listing["user_id"] as? String ?? ""
        
        listerUID = user_id
        print("oooga")
        print(user_id)
        
        let userRef = Firestore.firestore().collection("users").document(user_id)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let itemsSold_num = "\u{2022} \((dataDescription?["itemsSold"]) ?? 0) Items Sold"
                let school = "\u{2022} School: \((dataDescription?["college"])!)"
                let year = "\u{2022} Year: \((dataDescription?["year"])!)"
                self.schoolLabel.text = school
                self.collegeYear.text = year
                self.itemsSold.text = itemsSold_num
                self.priceLabel.text = price;
                
            } else {
                print("Document does not exist")
            }
        }
        
        

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
