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
    
    var i : [String] = []
    
   
    
   

    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        a()
        print(i)
        

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    
        // Do any additional setup after loading the view.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        i.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let itemObject = i[indexPath.row]
       
        
        cell.emailOn.text =  itemObject
        return cell
        
    }
    func a(){
        ref.observe(.childAdded, with: { snap in
            guard let em = snap.value as? String else {return}
            self.i.append(em)
            let inP = IndexPath(row: self.i.count - 1, section: 0)
            self.userTableView.insertRows(at: [inP], with: .top)
            })
        ref.observe(.childRemoved, with: { snap in

                    guard let emailToFind = snap.value as? String else { return }
                    for (index, email) in self.i.enumerated()
                    {
                        if email == emailToFind
                        {
                            let indexPath = IndexPath(row: index, section: 0)
                            self.i.remove(at: index)
                            self.userTableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                } )
    }


    @IBAction func signOut(_ sender: Any) {
        
       
       
        let onlineRef = Database.database().reference(withPath: "Online")

                onlineRef.removeValue
                { (error, _) in

                    if let error = error
                    {
                        print("Removing online failed: \(error)")
                        return
                    }
                    do {
                             try Auth.auth().signOut()
                        self.navigationController?.popToRootViewController(animated: true)
                       

                    }catch{
                        print("An error occurred")
                    }
                }

        
    }
        
        
  
    

}
