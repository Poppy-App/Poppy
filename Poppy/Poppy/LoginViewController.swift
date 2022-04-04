//
//  LoginViewController.swift
//  Poppy
//
//  Created by Avi Patel on 4/3/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    
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
    @IBAction func Login(_ sender: Any) {
        let username = UsernameTextField.text!;
        let password = PasswordTextField.text!;
        Firebase.Auth.auth().signIn(withEmail: username, password: password) {
            result, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            guard let res = result else {
                print("Error!")
                return
            }
            print("Signed in as \(res.user.uid)")
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }
    
    
    
    
    
    
    
    
}
