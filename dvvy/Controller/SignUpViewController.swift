//
//  SignUpViewController.swift
//  dvvy
//
//  Created by David Bartholomew on 2/18/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController : UIViewController {
    
    @IBOutlet weak var usernameLbl: UITextField!
    
    @IBOutlet weak var emailLbl: UITextField!
    
    @IBOutlet weak var passwordLbl: UITextField!
    
    @IBAction func createUser(_ sender: Any) {
        // TODO: Make username actually add to database, its not actually doing anything rignt now
        
        // TODO: Make some sort of email / pass validation
        if let email = emailLbl.text, let pass = passwordLbl.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                // ...
                if let u = user {
                    // User found go to home screen
                    self.performSegue(withIdentifier: "pushToHome", sender: self)
                    print(u)
                }
                else {
                    // Error: check error and message
                    print (error ?? "nothing")
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameLbl.resignFirstResponder()
        passwordLbl.resignFirstResponder()
        emailLbl.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
