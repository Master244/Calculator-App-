<h1>Ghost Word IOS Game Design Document<h1> 
<p>I started this project for the Stanford CS193P IOS Swift Course. The assignment is to build the game Ghost. 

Ghost is a written or spoken word game in which players take turns adding letters to a growing word fragment, trying not to be the one to complete a valid word. Each fragment must be the beginning of an actual word, and usually some minimum is set on the length of a word that counts, such as three or four letters. The player who completes a word loses the round and earns a "letter" (as in the basketball game horse), with players being eliminated when they have been given all five letters of the word "ghost".</p>
<h2>Features:</h2>
- 2 Player mode
- High Scores
- Create accounts
- English and Dutch dictionary 

<h2>Internal frameworks, libraries, or other technologies:</h2>
- UIKit
- AppDelegate(core functions)
- Core Data
- NSManagedObjectContext

<h2>Patterns:</h2>
- Settings
- Help (Rules)
- Compatibility
- UITableView

Iphone 4/4S Design
Designing for iOS
The designs can be found in the doc directory

---------------
<h1>Design Decisions:</h1>

<h2>NSManagedObjectContext</h2>
Most knowledge about this subject I learned through http://jamesonquave.com/blog/core-data-in-swift-tutorial-part-1/ . Initially following this easy tutorial helped me understand how the NSPersistentStoreCoordinator and CoreData worked. 

If you look at the image below you can see the NSPersistentStoreCoordinator centered between storage modules and controllers that want to acces these modules. The name alone makes it quite scary to try and understand what it does. I called him my Indian Trader. 

He wants to deliver and pick-up goods but he misses the instructions to properly deliver it to NSPersistentStore. Thats where the NSManagedObjectContext comes in. It alligns and marks all the goods and wraps it up for the Indian Trader. Alligning and marking is only allowed to be done by NSManagedObjectContext not by the NSPersistentStoreCoordinator. The reason is in the name itself it's a 'Coordinator' module which sends packages to the correct storage. You can imagine what happens when the Indian Trader has a package withouth an adress. He would still be underway delivering that package.

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/NSM.png?raw=true)

I choose to use the CoreData because it was offered in the app it's core functions. CoreData has a bit of a learning curve but the fun begins when you get that Trader to work for you as he able to. The advantage of using CoreData is that if your app crashes all the data is saved in the CoreData of the device used. No Data will be lost as what will happen if you use NSUserDefaults, which is a way to temporarily store data that can be manipulated by different classes and functions. This data obviously gets lost when the code is done running or if the app crashes. 


<h2>ViewControllers</h2>

<h3>PlayCheckController</h3>
This is the initial controller fired up at the start. The Play button checks if the game has been set from the settings menu. If not a message will appear that will ask you to go to the settings controller and setup the game. 

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/PlayCheckController.png?raw=true)

<h3>SettingsViewController</h3>
<p>1.</p>
This is where a big part of the magic happens. First of all the managedObjectContext is declared to create a context where objects like users and the selected dictionairy can be neatly arranged for our Indian Trader to pick up. 

<p>2.</p>
This function checks if the fields are properly filled before it undertakes any action like checking any data. If all constraints are met the function will push the names from the TextFields to the Database configured for the Entity "Users". 

<p>3.</p>
Loads and sets the currenDictionairy to English. 
The function is hardcoded on the number of objects in the dictionairy file I used. If you want to reuse this code change that value to your needs. After loading the dictionairy the function then stores a value to set the CurrentDictionairy which allows our play button in the first view to continiue to the GameViewController.

<p>4.</p>
Loads and sets the currenDictionairy to Dutch. 

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/SettingsViewController.png?raw=true)


<h3>GameController</h3>
<p>1.</p>
Pushes the input from the TextField to the database if it conforms to a couple of conditions. The checkMaxLength functions checks if only 1 character is given. And the CheckInput Class in Game checks if the input conforms to one of the cases specified.

<p>2.</p>
Makes sure that the current string variable is only updated after the viewdidload() which means you first want to have your functions executed before you want to update the currentString in the view. Only then are you sure that it passed all your conditions. 

<p>3.<p>
Sets an image from the image library as background for the ViewController.

<p>4.<p>
An Override function that hides the keyboard when a touch is recorded outside of the TextField.

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/GameController.png?raw=true)


<h3>FinishedGameController</h3>
<p>1.</p>
Brings you back to the homeScreen and clears the currentUsers so you have to set them from the settings again. 

<p>w.</p>
Restart the match with the same settings. 

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/FinishedGameController.png?raw=true)


<h3>HighScoreTableViewController</h3>
<p>This controller executes a fetchrequest that returns objects from Core Data. These need be cast to a string and preferably sorted on score which can be achieved with the sortDescriptor. The controller then loops over the results and checks for matches for the name and score. This is then appended in to one string to be shown in the UITableView.</p>

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/HighScoreTableViewController.png?raw=true)




