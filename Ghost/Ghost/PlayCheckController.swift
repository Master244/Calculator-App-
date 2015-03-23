//
//  PlayCheckController.swift
//  Ghost
//
//  Created by Mitchell Tieleman on 22/03/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import Foundation
import UIKit

class PlayCheckController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundhome.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // This function checks if the game has been set from the settings screen. If not a message will appear to ask the user to do so.
    @IBAction func play(sender: AnyObject) {
        let temp = NSUserDefaults.standardUserDefaults()
        let gameSet = temp.stringForKey("gameSet")
        temp.setObject("false", forKey: "gameSet")
        
        if gameSet! == "true" {
            self.performSegueWithIdentifier("play", sender: nil)
        }
        else {
            let alert = UIAlertView()
            alert.title = "No Players Found!"
            alert.message = "Please enter names in the settings menu"
            alert.addButtonWithTitle("Will Do!")
            alert.show()
        }
    }
}