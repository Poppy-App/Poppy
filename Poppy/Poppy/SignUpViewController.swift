//
//  SignUpViewController.swift
//  Poppy
//
//  Created by Avi Patel on 4/3/22.
//

import UIKit
import Firebase
import simd

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    @IBOutlet weak var SchoolTextField: UITextField!
    
    @IBOutlet weak var YearTextField: UITextField!
    
    @IBOutlet weak var venmoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackToHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
   
    
    
    @IBAction func SignUp(_ sender: Any) {
        let name = NameTextField.text!
        let email = EmailTextField.text!
        let password = PasswordTextField.text!
        let school = SchoolTextField.text!
        let year = YearTextField.text!
        let venmo = venmoTextField.text!
        
        
        Firebase.Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            guard let res = result else {
                print("Error!")
                return
            }
            print("Signed in as \(res.user.uid)")
            
            var user:[String:Any] = [String:Any]()
            user["bio"] = ""
            user["college"] = school
            user["email"] = email
            user["itemsSold"] = 0
            user["name"] = name
            user["password"] = password
            user["year"] = year
            user["venmo"] = venmo

            let db = Firestore.firestore()
            db.collection("users").document(res.user.uid).setData(user) { error in
                if error != nil {
                    print("Error adding User!")
                }
                else {
                    print("User successfully added!")
                }
            }
            self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
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
