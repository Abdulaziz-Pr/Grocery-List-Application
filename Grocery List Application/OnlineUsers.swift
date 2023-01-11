//
//  OnlineUsers.swift
//  Grocery List Application
//
//  Created by admin on 1/10/23.
//

import UIKit
import Firebase
import FirebaseAuth

class OnlineUsers: UIViewController {
    let ref = Database.database().reference()
    var items : [Users] = []

    @IBOutlet weak var usertableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

    }
        // Do any additional setup after loading the view.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usertableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let itemObject = items[indexPath.row]
       // cell.setupCell(titleName: itemObject.name, subTitleEmail: itemObject.addByUser)
        cell.textLabel?.text = itemObject.onlineUser
        usertableview.reloadData()
        return cell
        
    }


    @IBAction func signOut(_ sender: Any) {
//        guard let strongSelf? = self else {
//            return
//        }
//
//
//        do {
//            try FirebaseAuth.Auth.auth().signOut()
//
//            let vc = ViewController()
//            let nav = UINavigationController(rootViewController: vc)
//            nav.modalPresentationStyle = .fullScreen
//            strongSelf.present(nav, animated: true)
//        }
//        catch {
//            print("Failed to log out")
//        }

    }
    

}
