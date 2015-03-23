//
//  GameController.swift
//  Ghost
//
//  Created by Mitchell Tieleman on 22/03/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    // ObjectContext setup as explained at:
    // http://jamesonquave.com/blog/core-data-in-swift-tutorial-part-1/
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    
    @IBOutlet weak var playerStatus: UILabel!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var curr: UILabel!
    
    @IBAction func pushInput(sender: AnyObject) {
        let letter = input.text
        let temp = NSUserDefaults.standardUserDefaults()
        var name1 = temp.stringForKey("userOne")
        var name2 = temp.stringForKey("userTwo")
        var currentName = temp.stringForKey("currentUser")
        playerStatus.text = currentName!
        
        if letter == "" {
            
        }
        
        if (Game.gameWon(managedObjectContext!, currentstring: letter) != true) {
            let temp = NSUserDefaults.standardUserDefaults()
            var name1 = temp.stringForKey("userOne")
            var name2 = temp.stringForKey("userTwo")
            var currentName = temp.stringForKey("currentUser")
            currentName = Game.turn(name1!, player2: name2!, current: currentName!)
            playerStatus.text = currentName!
            
        } else {
            currentName = Game.turn(name1!, player2: name2!, current: currentName!)
            let alert = UIAlertView()
            alert.title = "Game Over!"
            alert.message = ("Player: " + currentName! + " Won!")
            alert.addButtonWithTitle("Ok")
            alert.show()
            self.performSegueWithIdentifier("ending", sender: nil)
        }
        let checker = ""
        let pred = temp.stringForKey("currentString")
        let dict = temp.stringForKey("currentDict")
        let final = pred! + checker
        curr.text = final
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        let curr = defaults.stringForKey("userOne")
        playerStatus.text = curr
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundhome.png")!)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true);
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (countElements(textField.text!) > maxLength) {
            textField.deleteBackward()
        }
    }    
}
