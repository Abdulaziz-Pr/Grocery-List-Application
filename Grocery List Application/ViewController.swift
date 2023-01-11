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
    
    @IBAction func logIn(_ sender: Any) {
        
        guard let email = email.text, !email.isEmpty else {return}
        guard let password = pass.text, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
    }

        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if error != nil {
                

            }else{
                self.performSegue(withIdentifier: "goTonext", sender: self)
                let user = Users(onlineUser: Auth.auth().currentUser?.email ?? "")
               // let additemRef = self.ref.child("Online11")
                self.ref.setValue(user.toAnyObject())
                
            }
        }
    }
    
    
    
    @IBAction func signUp(_ sender: Any) {
        guard let email = email.text, !email.isEmpty else {return}
        guard let password = pass.text, !password.isEmpty, password.count >= 6 else {
            alertNewUserError()
            return
    }
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if error != nil {
                self.alertNewUserError()            }
            
             
            
        }
    }
    func alertNewUserError(message: String = "Please enter all information to create a new account.") {
        let alert = UIAlertController(title: "Woops",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    func alertUserLoginError(message: String = "Please enter all information to Log in.") {
        let alert = UIAlertController(title: "Email or Password wrong",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    
    
   
}

