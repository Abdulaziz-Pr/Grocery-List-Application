//
//  OnlineUsers.swift
//  Grocery List Application
//
//  Created by admin on 1/10/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class OnlineUsers: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    let ref = Database.database().reference(withPath: "Online")
    
    var ConnectUsers : [String] = []
    
   
    
   

    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showUsersConecting()
        
        

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    
        // Do any additional setup after loading the view.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ConnectUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let itemObject = ConnectUsers[indexPath.row]
       
        
        cell.emailOn.text =  itemObject
        return cell
        
    }
    
    func showUsersConecting(){
        // this  append Online users in database to my array and show it in table View
        ref.observe(.childAdded, with: { snap in
            guard let em = snap.value as? String else {return}
            self.ConnectUsers.append(em)
            let inP = IndexPath(row: self.ConnectUsers.count - 1, section: 0)
            self.userTableView.insertRows(at: [inP], with: .top)
            })
        // this remove any users press sign out from database to my array
        ref.observe(.childRemoved, with: { snap in

                    guard let emailToFind = snap.value as? String else { return }
                    for (index, email) in self.ConnectUsers.enumerated()
                    {
                        if email == emailToFind
                        {
                            let indexPath = IndexPath(row: index, section: 0)
                            self.ConnectUsers.remove(at: index)
                            self.userTableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                } )
    }


    @IBAction func signOut(_ sender: Any) {
        
       
       // this to go inside database to path online
        let onlineRef = Database.database().reference(withPath: "Online")
                  // remove from this path
                onlineRef.removeValue
                { (error, _) in
                    // to make sure tha there is no error
                    if let error = error
                    {
                        print("Removing online failed: \(error)")
                        return
                    }
                    do {
                        // sign out from Authentication
                             try Auth.auth().signOut()
                        self.navigationController?.popToRootViewController(animated: true)
                       

                    }catch{
                        print("An error occurred")
                    }
                }

        
    }
        
        
  
    

}
