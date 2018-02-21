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
        
        guard let username = usernameLbl.text else { return }
        
        
        // TODO: Make some sort of email / pass validation
        if let email = emailLbl.text, let pass = passwordLbl.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                // ...
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User ")
                    }
                }
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
                        print("Network error")
                    case .userTokenExpired:
                        print("User token has expired")
                    case .invalidAPIKey:
                        print("Invalid API key")
                    case .userMismatch:
                        print("User mismatch")
                    case .credentialAlreadyInUse:
                        print("Already logged in")
                    case .weakPassword:
                        print("Weak Password")
                    case .appNotAuthorized:
                        print("App not authorized")
                    case .expiredActionCode:
                        print("Expired action code")
                    case .invalidActionCode:
                        print("Invalid action code")
                    case .invalidMessagePayload:
                        print("Invalid message payload")
                    case .invalidSender:
                        print("Invalid sender")
                    case .invalidRecipientEmail:
                        print("Invalid recipient email")
                    case .missingPhoneNumber:
                        print("Missing phone number")
                    case .invalidPhoneNumber:
                        print("Invalid phone number")
                    case .missingVerificationCode:
                        print("Missing verification code")
                    case .invalidVerificationCode:
                        print("Invalid verification code")
                    case .missingVerificationID:
                        print("Missing verification ID")
                    case .invalidVerificationID:
                        print("Invalid verification ID")
                    case .missingAppCredential:
                        print("Missing app credential")
                    case .invalidAppCredential:
                        print("Invalid app credential")
                    case .sessionExpired:
                        print("Session expired")
                    case .quotaExceeded:
                        print("Quota exceeded")
                    case .missingAppToken:
                        print("Missing app token")
                    case .notificationNotForwarded:
                        print("Notification not forwarded")
                    case .appNotVerified:
                        print("App not verified")
                    case .keychainError:
                        print("Keychain error")
                    case .internalError:
                        print("Internal error")
                    }
                } else {
                    
                    if let u = user {
                        // User found go to home screen
                        self.performSegue(withIdentifier: "pushToHome", sender: self)
                        print(u.email ?? "broken")
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
