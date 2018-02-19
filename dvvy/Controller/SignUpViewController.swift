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
                if let error = error as NSError? {
                    
                    guard let errorCode = AuthErrorCode(rawValue: error.code) else {
                        
                        print("there was an error logging in but it could not be matched with a firebase code")
                        return
                        
                    }
                    
                    switch errorCode {
                        
                    case .emailAlreadyInUse:
                        print("invalid email")
                    case .invalidCustomToken:
                        print("invalid custom token")
                    case .customTokenMismatch:
                        print("custom token mismatch")
                    case .invalidCredential:
                        print("invalid credentials")
                    case .userDisabled:
                        print("User currently disabled")
                    case .operationNotAllowed:
                        print("Operation not allowed")
                    case .invalidEmail:
                        print("Invalid email")
                    case .wrongPassword:
                        print("Wrong Password")
                    case .tooManyRequests:
                        print("Too many Requests")
                    case .userNotFound:
                        print("User not found")
                    case .accountExistsWithDifferentCredential:
                        print("Accound exists with different credentials")
                    case .requiresRecentLogin:
                        print("Requires recent login")
                    case .providerAlreadyLinked:
                        print("Provider already linked")
                    case .noSuchProvider:
                        print("No such provider")
                    case .invalidUserToken:
                        print("Invalid user token")
                    case .networkError:
                        print("invalid email")
                    case .userTokenExpired:
                        print("invalid email")
                    case .invalidAPIKey:
                        print("invalid email")
                    case .userMismatch:
                        print("invalid email")
                    case .credentialAlreadyInUse:
                        print("invalid email")
                    case .weakPassword:
                        print("invalid email")
                    case .appNotAuthorized:
                        print("invalid email")
                    case .expiredActionCode:
                        print("invalid email")
                    case .invalidActionCode:
                        print("invalid email")
                    case .invalidMessagePayload:
                        print("invalid email")
                    case .invalidSender:
                        print("invalid email")
                    case .invalidRecipientEmail:
                        print("invalid email")
                    case .missingPhoneNumber:
                        print("invalid email")
                    case .invalidPhoneNumber:
                        print("invalid email")
                    case .missingVerificationCode:
                        print("invalid email")
                    case .invalidVerificationCode:
                        print("invalid email")
                    case .missingVerificationID:
                        print("invalid email")
                    case .invalidVerificationID:
                        print("invalid email")
                    case .missingAppCredential:
                        print("invalid email")
                    case .invalidAppCredential:
                        print("invalid email")
                    case .sessionExpired:
                        print("invalid email")
                    case .quotaExceeded:
                        print("invalid email")
                    case .missingAppToken:
                        print("invalid email")
                    case .notificationNotForwarded:
                        print("invalid email")
                    case .appNotVerified:
                        print("invalid email")
                    case .keychainError:
                        print("invalid email")
                    case .internalError:
                        print("invalid email")
                    }
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
