//
//  Users.swift
//  Ghost
//
//  Created by Mitchell Tieleman on 22/03/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import Foundation
import CoreData

class Users: NSManagedObject {

    @NSManaged var player: String
    @NSManaged var score: NSNumber

    class func createUser(moc: NSManagedObjectContext, playertextbox: String) -> Users {
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: moc) as Users
        
        newUser.player = playertextbox
        var error: NSError?
        moc.save(&error)
        
        return newUser
    }
    
    class func save(moc: NSManagedObjectContext){
        var error : NSError?
        
        if(moc.save(&error) ) {
            println(error?.localizedDescription)
        }
    }
    
    class func playerIsTrue(moc: NSManagedObjectContext, player: String) -> Bool {
        if (player != "" && player != "Enter Name") {
            Users.checkUser(moc, playertextbox: player)
            return true
        }
        return false
    }
    
    class func checkUser(moc: NSManagedObjectContext, playertextbox: String){
        var ctx = moc
        var request = NSFetchRequest()
        let entityDescription =
        NSEntityDescription.entityForName("Users",
            inManagedObjectContext: moc)
        let predicate = NSPredicate(format: "player MATCHES[cd] %@", playertextbox)
        request.predicate = predicate
        request.entity = entityDescription
        var results = moc.executeFetchRequest(request, error: nil)
        if results?.count == 0 {
            Users.createUser(moc, playertextbox: playertextbox)
            Users.save(moc)
            println("User created")
        } else {
            println("Match found")
        }
    }
    
    class func fetchUser(moc: NSManagedObjectContext, entname: String, playertextbox: String) {
        var ctx = moc
        let newFetch = NSEntityDescription()
        let predicate = NSPredicate(format: "player MATCHES[cd] %@", playertextbox)
        var request = NSFetchRequest(entityName: entname)
        request.predicate = predicate
        var returnedObjects = moc.executeFetchRequest(request, error: nil)
        
        if let object = returnedObjects {
            if object.count > 0 {
                let match = object[0] as NSManagedObject
                var playertextbox1 = playertextbox
                if let playertextbox1 = match.valueForKey("player") as? String {
                    var test = match.valueForKey("player") as? String
                    println(test!)
                }
            }
        }
    }
    
    class func fetchAll(moc: NSManagedObjectContext, entname: String, playertextbox: String) {
        
        var ctx = moc
        let newFetch = NSEntityDescription()
        var request = NSFetchRequest(entityName: entname)
        var results = ctx.executeFetchRequest(request, error: nil)
        if (results?.count > 0){
            for match: AnyObject in results! {
                if let test = match.player {
                    println(test)
                }
                if let test2 = match.score {
                    println(test2)
                }
            }
        } else {
            println("No entries Found")
        }
    }
}

