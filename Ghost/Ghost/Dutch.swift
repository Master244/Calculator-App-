//
//  Dutch.swift
//  Ghost
//
//  Created by Mitchell Tieleman on 22/03/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import Foundation
import CoreData

class Dutch: NSManagedObject {
    @NSManaged var word: String
    
    // loadDictionairy saves the Dutch .lst file to Core Data
    class func loadDictionairy (moc: NSManagedObjectContext) {
        var dictionairy = Dutch.readFile("nederlands", fileType: "lst", moc: moc)
        var dictArray = dictionairy.componentsSeparatedByString("\n")
        var counter = Dutch.fetchAll(moc, entname: "Dutch")
        
        if counter < 188589 && counter != 188589 {
            for item in dictArray[counter..<dictArray.count] {
                Dutch.createWord(moc, word: item)
                println(item)
            }
        }
    }
    
    class func readFile(fileName: String, fileType: String, moc: NSManagedObjectContext) -> String {
        var fileRoot = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        var dictionairy = String(contentsOfFile: fileRoot!, encoding: NSUTF8StringEncoding, error: nil)
        
        return dictionairy!
    }
    
    class func createWord(moc: NSManagedObjectContext, word: String) -> Dutch {
        let newWord = NSEntityDescription.insertNewObjectForEntityForName("Dutch", inManagedObjectContext: moc) as Dutch
        newWord.word = word
        var error: NSError?
        moc.save(&error)
        
        return newWord
    }
    
    class func save(moc: NSManagedObjectContext){
        var error : NSError?
        if(moc.save(&error) ) {
            println(error?.localizedDescription)
        }
    }
    
    class func fetchAll(moc: NSManagedObjectContext, entname: String) -> Int{
        var ctx = moc
        let newRequest = NSEntityDescription()
        var request = NSFetchRequest(entityName: entname)
        var results = ctx.executeFetchRequest(request, error: nil)
        var counter: Int = 0
        if (results?.count > 0){
            counter = (results?.count)!
            for match: AnyObject in results! {
                if let test = match.word {
                } else {
                    println("No entries in CoreData")
                }
            }
        }
        return counter
    }
}
