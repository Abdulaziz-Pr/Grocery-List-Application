//
//  ViewController.swift
//  Grocery List Application
//
//  Created by admin on 1/8/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    let ref = Database.database().reference(withPath: "Online")
    var items : [Users] = []
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var pass: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    //this func to make tect field Empty
    override func viewWillAppear(_ animated: Bool) {
            email.text = ""
            pass.text = ""

        }
    // this button for sign in
    @IBAction func logIn(_ sender: Any) {
        // guard to make that email is not empty and pass has more than 6 character if any thing wrong call func
        guard let email = email.text, !email.isEmpty else {return}
        guard let password = pass.text, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
    }
     // Authentication the email and password to see if this email are in firebase
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if error != nil {
                

            }else{
                // navigation to ListViewController
                self.performSegue(withIdentifier: "goTonext", sender: self)
                // here if user online show me in data base
                let user = Users(onlineUser: Auth.auth().currentUser?.email ?? "")
                
               
                self.ref.setValue(user.toAnyObject())
               
               
            }
            
            
        }
        
    }
    
    
    // Button for sign up
    @IBAction func signUp(_ sender: Any) {
        // guard to make that email is not empty and pass has more than 6 character if any thing wrong call func

        guard let email = email.text, !email.isEmpty else {return}
        guard let password = pass.text, !password.isEmpty, password.count >= 6 else {
            alertNewUserError()
            return
    }
        // Authentication the email and password to create User

        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if error != nil {
                self.alertNewUserError()
                
            }else{
                // here if user online show me in data base
                let user = Users(onlineUser: Auth.auth().currentUser?.email ?? "")
               self.ref.setValue(user.toAnyObject())
                
                // navigation to ListViewController
                self.performSegue(withIdentifier: "goTonext", sender: self)
            }
            
             
            
        }
    }
    // alert func for sign up if somthing wrong in emai and pass this alert will show
    func alertNewUserError(message: String = "Please enter all information to create a new account.") {
        let alert = UIAlertController(title: "Email and pass are formated corectly",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    // alert func for sign in if somthing wrong in emai and pass this alert will show

    func alertUserLoginError(message: String = "Please enter all information to Log in.") {
        let alert = UIAlertController(title: "Email or Password wrong",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    
    
   
}


