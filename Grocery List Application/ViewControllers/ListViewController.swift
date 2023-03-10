//
//  ListViewController.swift
//  Grocery List Application
//
//  Created by admin on 1/8/23.
//

import UIKit
import Firebase
import FirebaseAuth

class ListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
   
    let ref = Database.database().reference(withPath: "Grocery-items")
    var items : [grocery] = []
    var changeText: UITextField?
    
    var itemId = ""
    
    let user = Auth.auth().currentUser?.email

    @IBOutlet weak var ourList: UITableView!
    
    
    // this button will navigation to OnlineUsers ViewController
    @IBAction func onlineUsers(_ sender: Any) {
        self.performSegue(withIdentifier: "goToUsers", sender: self)
    }
    
    // Button to add new item in Gerocery List
    @IBAction func addItem(_ sender: Any) {
        
        
        let alertController = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField! ) -> Void in
            textField.placeholder = "Enter your item"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let itemTextField = alertController.textFields![0] as UITextField

            if let name = itemTextField.text {
                // if textfield not empty add rhis item in database with child and show it in tableView
                if name != "" {
                    let additem = grocery(name: name, addByUser: self.user ?? "", key: name)
                    let additemRef = self.ref.child("\(name)")
                    additemRef.setValue(additem.toAnyObject())
                  
                }

            }

            self.ourList.reloadData()
            self.dismiss(animated: true, completion: nil)


        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true)
  }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)

        // this i use it to see my database and show it in output
        ref.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
            
        })
        // show the observe from my database take what i write to my database
        ref.observe(.value, with: { snapshot in
            var newItem : [grocery] = []
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                   let Allitems = grocery(snapshot: snapshot){
                    newItem.append(Allitems)
                }
            }
            self.items = newItem
            self.ourList.reloadData()
        })
        
        
    }
    // number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    // control cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ourList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let itemObject = items[indexPath.row]
        cell.setupCell(titleName: itemObject.name, subTitleEmail: itemObject.addByUser)
        
        return cell
        
    }
    // for delete
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
         if editingStyle == .delete {
             let itemDele = items[indexPath.row]
             itemDele.ref.removeValue()
         }
        
        
    }
    // this for edit my cell
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit", message: "Edit task", preferredStyle: .alert)
        let update = UIAlertAction(title: "Update", style: .default) {_ in
            // itemid will take key when i press cell to do edit
           self.itemId = self.items[indexPath.row].key
            // if i have id for my cell i can this func will help me to put my edit in my database
            self.editGrocery()
            let updateName = self.changeText?.text
            let n = grocery(name: updateName ?? "", addByUser: self.user ?? "", key: updateName ?? "")
           
            // this will take itemid and update it
            self.ref.child(self.itemId).updateChildValues(n.toAnyObject() as! [AnyHashable: Any])


        }
         self.ourList.reloadData()
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("Canceled")
        }
        alert.addAction(update)
        alert.addAction(cancel)
        alert.addTextField { textField in
            self.changeText = textField
            self.changeText?.text = self.items[indexPath.row].key
            self.changeText?.placeholder = "Enter your new task"
        }
       present(alert, animated: true, completion: nil)
    }
    
    func editGrocery (){
        // will see the root for this child to make change
        ref.child(itemId).observeSingleEvent(of: .value, with: { (snapshot) in
                    let personDict = snapshot.value as? [String: Any]
                    let name = personDict?["name"] as? String
                    let addByUser = personDict?["addByUser"] as? String
                    let key = personDict?["key"] as? String
                                    
                 }) { (error) in
                    print(error.localizedDescription)
                }
            }
    
    
}
