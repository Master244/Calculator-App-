//
//  FinishedGameController.swift
//  Ghost
//
//  Created by Mitchell Tieleman on 22/03/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import UIKit

class FinishedGameController: UIViewController {
    // Returns to the homescreen. Enter users available
    @IBAction func backToStart(sender: AnyObject) {
        self.performSegueWithIdentifier("start", sender: nil)
        let temp = NSUserDefaults.standardUserDefaults()
        temp.setObject("false", forKey: "gameSet" )
        temp.setObject("", forKey: "currentUser")
        
    }
    // Starts over the game with the same settings
    @IBAction func rematch(sender: AnyObject) {
        self.performSegueWithIdentifier("rematch", sender: nil)
        let temp = NSUserDefaults.standardUserDefaults()
        temp.setObject("", forKey: "currentString")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loads background image from library
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundhome.png")!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
