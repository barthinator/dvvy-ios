//
//  SignInViewController.swift
//  dvvy
//
//  Created by David Bartholomew on 2/18/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class SignInViewController : UIViewController, UserModelDelegate, UITextFieldDelegate {
    func finishedLoading(user: User) {
        name = "\(user.first) \(user.last)"
        UserDefaults.standard.set(self.name, forKey: "name")
    }
    
    func finishLoadingFollowers(followers: [String]) {
        
    }
    
    func finishedLoadingFollowing(following: [String]) {
        
    }
    
    var userQuery: [User] = []
    
    var userModel : UserModel!
    
    var name : String!
    
    var storage: Storage!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBOutlet weak var usernameLbl: UITextField!
    
    @IBOutlet weak var passwordLbl: ShakingTextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func logInPressed(_ sender: Any) {
        
        let storageRef = storage.reference()
        
        // TODO: Make some sort of email / pass validation
        if let email = usernameLbl.text, let pass = passwordLbl.text {
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            
                if let error = error as NSError? {
                    self.errorLabel.isHidden = false
                    guard let errorCode = AuthErrorCode(rawValue: error.code) else {
                        print("there was an error logging in but it could not be matched with a firebase code")
                        return
                    }
                    
                    //Shaking Text Field Animation
                    self.passwordLbl.shake()
                    
                    switch errorCode {

                    case .invalidEmail:
                        self.errorLabel.text = "invalid email"
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
                        self.errorLabel.text = "User not found"
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
                    case .missingPhoneNumber:
                        print("invalid phone")
                    case .invalidPhoneNumber:
                        print("invalid phone")
                    }
                } else {
                    
                    if let u = user {
                        // User found go to home screen
                        self.performSegue(withIdentifier: "pushToHome", sender: self)
                        
                        
                        // Create a reference to the file you want to download
                        let imgProfRef = storageRef.child("userphotos/\(Auth.auth().currentUser?.uid ?? "fail").jpg")
                        
                        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                        imgProfRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                            if let error = error {
                                // Uh-oh, an error occurred!
                                UserDefaults.standard.set(nil, forKey: "userPhoto" )
                                print(error)
                            } else {
                                // Data for "images/island.jpg" is returned
                                UserDefaults.standard.set(data!, forKey: "userPhoto" )
                            }
                        }
                        
                        self.userModel.getUser(uid: (user?.uid)!)
                        
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
        self.errorLabel.isHidden = true
        storage = Storage.storage()
        userModel = UserModel.init()
        userModel.delegate = self
        
<<<<<<< HEAD
        //Shaking Text Field Animation
        passwordLbl.delegate = self
=======
        signInBtn.layer.cornerRadius = 10
        signInBtn.layer.borderWidth = 1
        signInBtn.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        usernameLbl.layer.cornerRadius = 8
        passwordLbl.layer.cornerRadius = 8
        usernameLbl.clipsToBounds = true
        passwordLbl.clipsToBounds = true
>>>>>>> settings
    }
    
    //Checks if the user is already logged in. If so then go to home page!
    override func viewDidAppear(_ animated: Bool) {

        if(UserDefaults.standard.bool(forKey: "isLoggedIn")){
            
            userModel.delegate = self
            userModel.getUser(uid: (Auth.auth().currentUser?.uid)!)
            
            let storageRef = storage.reference()
            let imgProfRef = storageRef.child("userphotos/\(Auth.auth().currentUser?.uid ?? "fail").jpg")
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            imgProfRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    // Uh-oh, an error occurred!
                    UserDefaults.standard.set(nil, forKey: "userPhoto" )
                    print(error)
                } else {
                    // Data for "images/island.jpg" is returned
                    UserDefaults.standard.set(data!, forKey: "userPhoto" )
                }
            }
            
            UserDefaults.standard.set(self.name, forKey: "name")
            UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "currentUser")
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: "pushToHome", sender: self)
        }
    }
    
    
}
