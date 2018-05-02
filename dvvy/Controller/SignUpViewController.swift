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
    
    @IBOutlet weak var frName: UITextField!
    
    @IBOutlet weak var emailLbl: UITextField!
    
    @IBOutlet weak var lName: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var passwordLbl: UITextField!
    
    
    @IBOutlet var errLbl: UILabel!
    
    @IBAction func createUser(_ sender: Any) {
        // TODO: Make username actually add to database, its not actually doing anything rignt now
        let userModel = UserModel.init()
        
        //guard let username = usernameLbl.text else { return }
        
        
        // TODO: Make some sort of email / pass validation
        if let email = emailLbl.text, let pass = passwordLbl.text, let fn = frName.text, let ln = lName.text, let phone = phoneNumber.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                // ...
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = fn + " " + ln
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
                    
                    self.errLbl.isHidden = false
                    
                    switch errorCode {
                        
                    case .emailAlreadyInUse:
                        self.errLbl.text = "Email already in use!"
                    case .invalidCustomToken:
                        self.errLbl.text = "Invalid custom token"
                    case .customTokenMismatch:
                        self.errLbl.text = "Custom token mismatch"
                    case .invalidCredential:
                        self.errLbl.text = "Invalid credentials"
                    case .userDisabled:
                        self.errLbl.text = "User currently disabled"
                    case .operationNotAllowed:
                        self.errLbl.text = "Operation not allowed"
                    case .invalidEmail:
                        self.errLbl.text = "Invalid email"
                    case .wrongPassword:
                        self.errLbl.text = "Wrong Password"
                    case .tooManyRequests:
                        self.errLbl.text = "Too many Requests"
                    case .userNotFound:
                        self.errLbl.text = "User not found"
                    case .accountExistsWithDifferentCredential:
                        self.errLbl.text = "Accound exists with different credentials"
                    case .requiresRecentLogin:
                        self.errLbl.text = "Requires recent login"
                    case .providerAlreadyLinked:
                        self.errLbl.text = "Provider already linked"
                    case .noSuchProvider:
                        self.errLbl.text = "No such provider"
                    case .invalidUserToken:
                        self.errLbl.text = "Invalid user token"
                    case .networkError:
                        self.errLbl.text = "Network error"
                    case .userTokenExpired:
                        self.errLbl.text = "User token has expired"
                    case .invalidAPIKey:
                        self.errLbl.text = "Invalid API key"
                    case .userMismatch:
                        self.errLbl.text = "User mismatch"
                    case .credentialAlreadyInUse:
                        self.errLbl.text = "Already logged in"
                    case .weakPassword:
                        self.errLbl.text = "Weak Password"
                    case .appNotAuthorized:
                       self.errLbl.text = "App not authorized"
                    case .expiredActionCode:
                        self.errLbl.text = "Expired action code"
                    case .invalidActionCode:
                        self.errLbl.text = "Invalid action code"
                    case .invalidMessagePayload:
                        self.errLbl.text = "Invalid message payload"
                    case .invalidSender:
                        self.errLbl.text = "Invalid sender"
                    case .invalidRecipientEmail:
                        self.errLbl.text = "Invalid recipient email"
                    case .missingPhoneNumber:
                        self.errLbl.text = "Missing phone number"
                    case .invalidPhoneNumber:
                        self.errLbl.text = "Invalid phone number"
                    case .missingVerificationCode:
                        self.errLbl.text = "Missing verification code"
                    case .invalidVerificationCode:
                        self.errLbl.text = "Invalid verification code"
                    case .missingVerificationID:
                        self.errLbl.text = "Missing verification ID"
                    case .invalidVerificationID:
                        self.errLbl.text = "Invalid verification ID"
                    case .missingAppCredential:
                        self.errLbl.text = "Missing app credential"
                    case .invalidAppCredential:
                        self.errLbl.text = "Invalid app credential"
                    case .sessionExpired:
                        self.errLbl.text = "Session expired"
                    case .quotaExceeded:
                        self.errLbl.text = "Quota exceeded"
                    case .missingAppToken:
                        self.errLbl.text = "Missing app token"
                    case .notificationNotForwarded:
                        self.errLbl.text = "Notification not forwarded"
                    case .appNotVerified:
                        self.errLbl.text = "App not verified"
                    case .keychainError:
                        self.errLbl.text = "Keychain error"
                    case .internalError:
                        self.errLbl.text = "Internal error"
                    case .missingEmail:
                        self.errLbl.text = "Invalid email"
                    case .missingIosBundleID:
                        self.errLbl.text = "Invalid email"
                    case .missingAndroidPackageName:
                        self.errLbl.text = "Invalid email"
                    case .unauthorizedDomain:
                        self.errLbl.text = "Invalid email"
                    case .invalidContinueURI:
                        self.errLbl.text = "Invalid email"
                    case .missingContinueURI:
                       self.errLbl.text = "Invalid email"
                    case .captchaCheckFailed:
                       self.errLbl.text = "Invalid email"
                    case .webContextAlreadyPresented:
                        self.errLbl.text = "Invalid email"
                    case .webContextCancelled:
                        self.errLbl.text = "Invalid email"
                    case .appVerificationUserInteractionFailure:
                        self.errLbl.text = "Invalid email"
                    case .invalidClientID:
                        self.errLbl.text = "Invalid email"
                    case .webNetworkRequestFailed:
                        self.errLbl.text = "Invalid email"
                    case .webInternalError:
                        self.errLbl.text = "Invalid email"
                    }
                } else {
                    
                    if let u = user {
                        
                        //user added to database if successful
                        userModel.setupUser(firstname: fn, lastname: ln, username: fn + " " + ln, email: email, phoneNumber: phone)
                        
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        UserDefaults.standard.synchronize()
                        
                        self.performSegue(withIdentifier: "pushToHome", sender: self)
                        print(u.email ?? "broken")
                    }
                    
                }
                
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordLbl.resignFirstResponder()
        emailLbl.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errLbl.isHidden = true
    }
}
