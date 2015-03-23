//
//  English.swift
//  Ghost
//
//  Created by Mitchell Tieleman on 22/03/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import Foundation
import CoreData

class English: NSManagedObject {
    
    @NSManaged var word: String
    
    // loadDictionairy saves the English .lst file to Core Data
    class func loadDictionairy (moc: NSManagedObjectContext) {
    var dictionairy = English.readFile("engels", fileType: "lst", moc: moc)
    var dictArray = dictionairy.componentsSeparatedByString("\n")
    var counter = English.fetchAll(moc, entname: "English")
    
    if counter < 296802 && counter != 296802 {
        for item in dictArray[counter..<dictArray.count] {
            English.createWord(moc, word: item)

            }
        }
    }
    
    class func readFile(fileName: String, fileType: String, moc: NSManagedObjectContext) -> String {
    var fileRoot = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
    var dictionairy = String(contentsOfFile: fileRoot!, encoding: NSUTF8StringEncoding, error: nil)
    
    return dictionairy!
    
    }
    
    class func createWord(moc: NSManagedObjectContext, word: String) -> English {
        let newWord = NSEntityDescription.insertNewObjectForEntityForName("English", inManagedObjectContext: moc) as English
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
        let newFetch = NSEntityDescription()
        var request = NSFetchRequest(entityName: entname)
        var returnedResult = ctx.executeFetchRequest(request, error: nil)
        var counter: Int = 0
        
        if (returnedResult?.count > 0){
            counter = (returnedResult?.count)!
            for match: AnyObject in returnedResult! {
                if let test = match.word {
                }
                else {
                    println("No entries in CoreData")
                }
            }
        }
        return counter
    }

}


