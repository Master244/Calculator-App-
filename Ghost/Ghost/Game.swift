//
//  Game.swift
//  Ghost
//
//  Created by Mitchell Tieleman on 22/03/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// The game class gets a string and return a boolean if a match is found to stop the game cycle. The game checks for valid input and checks if the current string made by the players is matching any word in the selected dictionairy.
//
class Game {
    class func gameWon(moc: NSManagedObjectContext, currentstring: String) -> Bool {
        let oneCharacter = countElements(currentstring)
        println(oneCharacter)
        if (oneCharacter == 1) {
            if Game.checkInput(currentstring) == true {
                let temp = NSUserDefaults.standardUserDefaults()
                let pred = temp.stringForKey("currentString")
                let dictionairy = temp.stringForKey("currentDict")
                let final = pred! + currentstring
                let finalC = countElements(final)
                var match = Game.matchPossibleWord(moc, input: final, entname: dictionairy!)
                var noPos = Game.noPossibleWord(moc, input: final, entname: dictionairy!)
                if match == true || noPos == true || noPos == true && finalC <= 3 {
                    return true
                } else {
                    temp.setObject(final, forKey: "currentString")
                }
            }
        } else {
            let alert = UIAlertView()
            alert.title = "Invalid input/ Input Needed"
            alert.message = "Only accepts 1. letter"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        return false
    }
    
    class func matchPossibleWord(moc: NSManagedObjectContext, input: String, entname: String) -> Bool {
        var ctx = moc
        let newFetch = NSEntityDescription()
        let pred = NSPredicate(format: "word BEGINSWITH[cd] %@", input)
        var request = NSFetchRequest(entityName: entname)
        request.predicate = pred
        var objects = moc.executeFetchRequest(request, error: nil)
        if objects?.count == 1 {
            println("No more words in result")
            return true
        } else {
            println("Valid Match")
        }
        return false
    }
    
    class func noPossibleWord(moc: NSManagedObjectContext, input: String, entname: String) -> Bool {
        var ctx = moc
        let newFetch = NSEntityDescription()
        let pred = NSPredicate(format: "word BEGINSWITH[cd] %@", input)
        var request = NSFetchRequest(entityName: entname)
        request.predicate = pred
        var objects = moc.executeFetchRequest(request, error: nil)
        if objects?.count == 0 {
            println("No more possible word in result")
            return true
        } else {
            println("Continue possibility")
        }
        return false
    }
    
    class func turn (player1: String, player2: String, current: String) -> String {
        var curr = current
        var stringTemp = ""
        if curr == player1 {
            let temp = NSUserDefaults.standardUserDefaults()
            temp.setObject(player2, forKey: "currentUser")
            stringTemp = temp.stringForKey("currentUser")!
        }
        if curr == player2 {
            let temp = NSUserDefaults.standardUserDefaults()
            temp.setObject(player1, forKey: "currentUser")
            stringTemp = temp.stringForKey("currentUser")!
        }
        return stringTemp
    }
    
    class func checkInput(letter: String) -> Bool {
        for character in letter {
            switch character {
            case "a", "b", "c", "d", "e", "f", "g", "h","i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H","I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z":
                return true
            default:
                let alert = UIAlertView()
                alert.title = "Invalid input"
                alert.message = "Only letters"
                alert.addButtonWithTitle("Ok")
                alert.show()
                return false
            }
        }
        return false
    }
}
