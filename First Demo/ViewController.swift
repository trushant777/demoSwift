//
//  ViewController.swift
//  First Demo
//
//  Created by Sarang Jiwane on 24/10/17.
//  Copyright © 2017 com.demo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SkyFloatingLabelTextField
import TwitterKit
import TwitterCore
import QuartzCore
import Google
import GoogleSignIn
class ViewController: UIViewController,GIDSignInUIDelegate {
    //MARK:UIOutlets
    @IBOutlet var loginBtnView: UIView!
    @IBOutlet var userNameText: SkyFloatingLabelTextField!
    @IBOutlet var emailText: SkyFloatingLabelTextField!
    @IBOutlet var passwordText: SkyFloatingLabelTextField!
    @IBOutlet var SingInBtn: GIDSignInButton!
    
    
    //MARK:Globle Variable
    var tapGesture = UITapGestureRecognizer()
    var dict : [String: AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TAP Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        loginBtnView.addGestureRecognizer(tapGesture)
        loginBtnView.isUserInteractionEnabled = true
        
        singlton.sharedInstance.named = "saurabh"
        
        print(singlton.sharedInstance.named!)
        // Demo Twitter Consumer and Secret Key
       
        GIDSignIn.sharedInstance().uiDelegate = self 
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    // Validation Methods
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        
        guard let name = userNameText.text , !name.isEmpty else{
            print("name is empty!")
            return
        }
       
        guard let email = emailText.text,!email.isEmpty, isValidEmail(testStr: email)  else {
            if(emailText.text?.isEmpty)!{
                print("email empty")
            }else if(!isValidEmail(testStr: userNameText.text!)){
                emailText.selectedLineColor = UIColor.red
                emailText.selectedTitle = "Email Not Valid"
                emailText.selectedTitleColor = UIColor.red
            }
            return
        }
        
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as UIViewController
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(viewController, animated: false, completion: nil)


        
//        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fbLoginBtn(_ sender: UIButton) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        if((FBSDKAccessToken.current()) != nil){
                            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                                if (error == nil){
                                    self.dict = result as? [String : AnyObject]
                                    print(result!)
                                    print(self.dict!)
                                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as UIViewController
                                    let transition = CATransition()
                                    transition.duration = 0.3
                                    transition.type = kCATransitionPush
                                    transition.subtype = kCATransitionFromRight
                                    self.view.window!.layer.add(transition, forKey: kCATransition)
                                    self.present(viewController, animated: false, completion: nil)
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    @IBAction func twitterLoginBtn(_ sender: UIButton) {
        
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                print("signed in as \(String(describing: session?.userName))");
            } else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        })
    }
    @IBAction func googleBtnTap(_ sender: UIButton) {
        func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                    withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let fullName = user.profile.name
                let givenName = user.profile.givenName
                let familyName = user.profile.familyName
                let email = user.profile.email
                // ...
                print(userId!,idToken!,fullName!,givenName!,familyName!,email!)
                
            } else {
                print("\(error.localizedDescription)")
            }
        }
    }
    @IBAction func googleBtnPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
   
}

