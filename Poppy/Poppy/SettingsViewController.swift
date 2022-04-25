//
//  SettingsViewController.swift
//  Poppy
//
//  Created by Herman Saini on 4/20/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SettingsViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var schoolText: UITextField!
    @IBOutlet weak var emailTExt: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var venmoText: UITextField!
    
    @IBOutlet weak var filterChoice: UISegmentedControl!
    
    
    var name: Any?
    var password: Any?
    var school: Any?
    var email: Any?
    var year: Any?
    var venmo: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("at testing page!")
        
        let userUID = Auth.auth().currentUser?.uid
        
        Firestore.firestore().collection("users").document(userUID!).getDocument { snapshot, error in
            if error != nil {
                // ERROR
                print("error")
            }
            else {
                self.name = snapshot?.get("name")
                self.password = snapshot?.get("password")
                self.school = snapshot?.get("college")
                self.email = snapshot?.get("email")
                self.year = snapshot?.get("year")
                self.venmo = snapshot?.get("venmo")
                
                self.nameText.text = self.name as! String
                self.passwordText.text = self.password as! String
                self.schoolText.text = self.school as! String
                self.emailTExt.text = self.email as! String
                self.yearText.text = self.year as! String
                self.venmoText.text = self.venmo as! String
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitChanges(_ sender: Any) {
        let filter1 = filterChoice.selectedSegmentIndex
        UserDefaults.standard.set(filter1, forKey: "Filter")
        
        let user = Auth.auth().currentUser!
        let userUID = Auth.auth().currentUser?.uid
        Firebase.Auth.auth().updateCurrentUser(user) { error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                var user:[String:Any] = [String:Any]()
                user["college"] = self.schoolText.text
                user["email"] = self.emailTExt.text
                user["name"] = self.nameText.text
                user["password"] = self.passwordText.text
                user["year"] = self.yearText.text
                user["itemSold"] = 0
                user["bio"] = ""
                user["venmo"] = self.venmoText.text

                let db = Firestore.firestore()
                db.collection("users").document(userUID!).setData(user) { error in
                    if error != nil {
                        print("Error adding User!")
                    }
                    else {
                        print("User successfully added!")
                    }
                }
                
            }
        }
        
        self.performSegue(withIdentifier: "backSet", sender: nil)
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
