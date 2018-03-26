//
//  SignInViewController.swift
//  dvvy
//
//  Created by David Bartholomew on 2/18/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController : UIViewController {
    
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBOutlet weak var usernameLbl: UITextField!
    
    @IBOutlet weak var passwordLbl: UITextField!
    
    
    @IBAction func logInPressed(_ sender: Any) {
        
        // TODO: Make some sort of email / pass validation
        if let email = usernameLbl.text, let pass = passwordLbl.text {
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                
                if let error = error as NSError? {
                    
                    guard let errorCode = AuthErrorCode(rawValue: error.code) else {
                        print("there was an error logging in but it could not be matched with a firebase code")
                        return
                    }
                    
                    switch errorCode {
                        
                    case .invalidEmail:
                        print("invalid email")
                    case .invalidCustomToken:
                        print("invalid custom token")
                    case .customTokenMismatch:
                        print("custom token mismatch")
                    case .invalidCredential:
                        print("invalid credentials")
                    case .userDisabled:
                        print("user disables")
                    case .operationNotAllowed:
                        print("operation not allowed")
                    case .emailAlreadyInUse:
                        print("email already in use")
                    case .wrongPassword:
                        print("wrong password")
                    case .tooManyRequests:
                        print("too many requests")
                    case .userNotFound:
                        print("user not found")
                    case .accountExistsWithDifferentCredential:
                        print("Account exists with different credentials")
                    case .requiresRecentLogin:
                        print("Requires recent login")
                    case .providerAlreadyLinked:
                        print("provider already linked")
                    case .noSuchProvider:
                        print("No such provider")
                    case .invalidUserToken:
                        print("Invalid User Token")
                    case .networkError:
                        print("Network Error")
                    case .userTokenExpired:
                        print("User token expired")
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
                    case .missingEmail:
                        print("invalid email")
                    case .missingIosBundleID:
                        print("invalid email")
                    case .missingAndroidPackageName:
                        print("invalid email")
                    case .unauthorizedDomain:
                        print("invalid email")
                    case .invalidContinueURI:
                        print("invalid email")
                    case .missingContinueURI:
                        print("invalid email")
                    case .captchaCheckFailed:
                        print("invalid email")
                    case .webContextAlreadyPresented:
                        print("invalid email")
                    case .webContextCancelled:
                        print("invalid email")
                    case .appVerificationUserInteractionFailure:
                        print("invalid email")
                    case .invalidClientID:
                        print("invalid email")
                    case .webNetworkRequestFailed:
                        print("invalid email")
                    case .webInternalError:
                        print("invalid email")
                    }
                } else {
                    
                    if let u = user {
                        // User found go to home screen
                        self.performSegue(withIdentifier: "pushToHome", sender: self)
                        
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        UserDefaults.standard.set(user?.uid, forKey: "currentUser")
                        UserDefaults.standard.synchronize()
                        print(u.email ?? "broken")
                    }
                    
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameLbl.resignFirstResponder()
        passwordLbl.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Checks if the user is already logged in. If so then go to home page!
    override func viewDidAppear(_ animated: Bool) {
        let userModel = UserModel.init()
        if(userModel.isLoggedIn()){
            // User found go to home screen
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "currentUser")
            self.performSegue(withIdentifier: "pushToHome", sender: self)
        }
    }
    
    
}
