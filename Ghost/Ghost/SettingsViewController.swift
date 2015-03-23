//
//  SettingsViewController.swift
//  Ghost
//
//  Created by Mitchell Tieleman on 22/03/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import CoreData
import UIKit


class SettingsViewController: UIViewController {
    
    let globalGame = ViewController()

    // ObjectContext setup as explained at:
    // http://jamesonquave.com/blog/core-data-in-swift-tutorial-part-1/
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    @IBOutlet weak var playerone: UITextField!
    @IBOutlet weak var playertwo: UITextField!
    
    // This functions checks for valid inputs before pushing to CoreData and setting gameSet on 'true'
    @IBAction func setSettings(sender: AnyObject) {
        let p1 = playerone.text
        let p2 = playertwo.text
        
        var user1 = Users.playerIsTrue(managedObjectContext!, player: p1)
        var user2 = Users.playerIsTrue(managedObjectContext!, player: p2)
        
        let temp = NSUserDefaults.standardUserDefaults()
        let name = temp.stringForKey("currentDict")
        
        //first time check if no dictionairy has been loaded.
        if (name == "") {
            let alert = UIAlertView()
            alert.title = "No Language Selected"
            alert.message = "Please select a language below!"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        // If one or no inputs are found the proper error message will be displayed.
        if (user1 == false || user2 == false) {
            if user1 == false {
                let alert = UIAlertView()
                alert.title = "Player 1 not Found."
                alert.message = "Please enter a name for player 1."
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
            if user2 == false {
                let alert = UIAlertView()
                alert.title = "Player 2 not Found."
                alert.message = "Please enter a name for player 2."
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        // All conforms to what we want and so the game can start!
        if (user1 == true && user2 == true && name != "") {
            let temp = NSUserDefaults.standardUserDefaults()
            temp.setObject(p1, forKey: "userOne" )
            temp.setObject(p2, forKey: "userTwo" )
            temp.setObject("", forKey: "currentString" )
            temp.setObject(p1, forKey: "currentUser" )
            temp.setObject("false", forKey: "gameWon")
            temp.setObject("true", forKey: "gameSet" )
            let alert = UIAlertView()
            alert.title = "New Settings have been Set!"
            alert.message = "Please go Back to Play Ghost"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
    }
    
    // loads Dutch dictionairy
    @IBAction func viewNl(sender: AnyObject){
        var count = Dutch.fetchAll(managedObjectContext!, entname: "Dutch")
        println(count)
        if (count != 188589) {
            Dutch.loadDictionairy(managedObjectContext!)
        }
        let temp = NSUserDefaults.standardUserDefaults()
        temp.setObject("Dutch", forKey: "currentDict" )
        if let name = temp.stringForKey("currentDict")
        {
            println(name)
        }
    }
    // loads English Library
    @IBAction func viewEng(sender: AnyObject) {
        var count = English.fetchAll(managedObjectContext!, entname: "English")
        println(count)
        if (count != 296802) {
            English.loadDictionairy(managedObjectContext!)
        }
        let temp = NSUserDefaults.standardUserDefaults()
        temp.setObject("English", forKey: "currentDict" )
        if let name = temp.stringForKey("currentDict")
        {
            println(name)
        }
    }
    
    // Func to hide keyboard when a touch outside of the textfield is registered.
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
