//
//  HighScoreTableViewController.swift
//  Ghost
//
//  Created by Mitchell Tieleman on 22/03/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import UIKit
import CoreData

// Main knowledge from: http://makeapppie.com/2014/07/12/swift-swift-how-to-use-uitableview-in-swift/ to fetch and store in uiTableView

class HighScoreTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var HighScores = [String]()
    
    // ObjectContext setup as explained at:
    // http://jamesonquave.com/blog/core-data-in-swift-tutorial-part-1/
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    let textCellIdentifier = "Cell"
    
    // This function sets the number of sections in UITableView
    //
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // This function returns the size of the array in which the fetched highHighScores are stored from Core Data
    //
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HighScores.count
    }
    
    // This function sets the title of the cell to be the title of the HighScores
    //
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = HighScores[row]
        return cell
    }
    
    // This function fetches the highscores from the Core Data and stores it in an array "HighScores" this is a valid string that the tableView can read.
    //
    func fetchHighscore(moc: NSManagedObjectContext) {
        
        var ctx = moc
        var request = NSFetchRequest(entityName: "Users")
        var sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        var results = ctx.executeFetchRequest(request, error: nil)
        var stringPart: String = ""
        var numberPart: NSNumber = 0
        var temp: String = ""
        if (results?.count > 0){
            for match: AnyObject in results! {
                if let pair1 = match.valueForKey("player") as? String {
                    
                    stringPart = pair1
                }
                
                if let pair2 = match.valueForKey("score") as? Int {
                    
                    numberPart = pair2
                }
                temp = " \(stringPart)    \(numberPart)"
                HighScores.append(temp)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHighscore(managedObjectContext!)

    }
}
