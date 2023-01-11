//
//  Model.swift
//  Grocery List Application
//
//  Created by admin on 1/9/23.
//

import Foundation
import Firebase
struct grocery {
    var ref = Database.database().reference()
    let name : String
    let addByUser : String
    let key : String
    
    init(name: String, addByUser: String, key: String) {
        self.name = name
        self.addByUser = addByUser
        self.key = name
    }
    
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let addByUser = value["addByUser"] as? String else{
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.addByUser = addByUser
    }
    func toAnyObject()-> Any {
    return[
        "name": name,
        "addByUser": addByUser
        
        ]
    }
}
struct Users {
    var ref = Database.database().reference()
    let onlineUser : String
    
    init(onlineUser: String) {
        self.onlineUser = onlineUser
    }
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String: AnyObject],
            let user = value["online"] as? String
             else{
            return nil
        }
        self.ref = snapshot.ref
        self.onlineUser = user
        
    }
    func toAnyObject()-> Any {
    return[
        "User": onlineUser
        
        ]
    }
}
