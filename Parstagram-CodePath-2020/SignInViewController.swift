//
//  SignInViewController.swift
//  Parstagram-CodePath-2020
//
//  Created by Alan Cao on 7/10/20.
//  Copyright © 2020 Alan Cao. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    private let user = PFUser()
    
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
    @IBAction func handleSignIn(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        PFUser.logInWithUsername(inBackground: email, password: password) { (user, error) in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            }
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
        }
    }
    
    @IBAction func handleSignUp(_ sender: Any) {
        user.email = emailTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { (success, error) in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
        }
    }
}
