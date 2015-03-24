

<h1>Ghost Word IOS Game Design Document<h1> 
<p>I started this project for the Stanford CS193P IOS Swift Course. The assignment is to build the game Ghost. 

Ghost is a written or spoken word game in which players take turns adding letters to a growing word fragment, trying not to be the one to complete a valid word. Each fragment must be the beginning of an actual word, and usually some minimum is set on the length of a word that counts, such as three or four letters. The player who completes a word loses the round and earns a "letter" (as in the basketball game horse), with players being eliminated when they have been given all five letters of the word "ghost".</p>
<h2>Features:</h2>
<ul>
  <li>2 Player mode</li>
  <li>High Scores</li>
  <li>Create accounts</li>
  <li>English and Dutch dictionary</li>
</ul>

<h2>Internal frameworks, libraries, or other technologies:</h2>
<ul>
  <li>UIKit</li>
  <li>AppDelegate(core functions)</li>
  <li>Core Data</li>
  <li>NSManagedObjectContext</li>
</ul>

<ul>
<h2>Patterns:</h2>
  <li>Settings</li>
  <li>Help (Rules)</li>
  <li>Compatibility</li>
  <li>UITableView</li>
</ul>

<h1>Design Decisions:</h1>

<h2>NSManagedObjectContext</h2>
Usefull readings on this subject: http://www.techotopia.com/index.php/An_iOS_8_Swift_Core_Data_Tutorial , http://jamesonquave.com/blog/core-data-in-swift-tutorial-part-1/ ,http://www.raywenderlich.com/77974/making-a-gesture-driven-to-do-list-app-like-clear-in-swift-part-1. Initially following this easy tutorial helped me understand how the NSPersistentStoreCoordinator and CoreData worked. 

If you look at the image below you can see the NSPersistentStoreCoordinator centered between storage modules and controllers that want to acces these modules. The name alone makes it quite scary to try and understand what it does. I called him my Indian Trader. 

He wants to deliver and pick-up goods but he misses the instructions to properly deliver it to NSPersistentStore. Thats where the NSManagedObjectContext comes in. It alligns and marks all the goods and wraps it up for the Indian Trader. Alligning and marking is only allowed to be done by NSManagedObjectContext not by the NSPersistentStoreCoordinator. The reason is in the name itself it's a 'Coordinator' module which sends packages to the correct storage. You can imagine what happens when the Indian Trader has a package withouth an adress. He would still be underway delivering that package.

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/NSM.png?raw=true)

I choose to use the CoreData because it was offered in the Xcodes core functions. CoreData has a bit of a learning curve but the fun begins when you get that Trader to work for you as hes able to. The advantage of using CoreData is that if your app crashes all the data is saved in the CoreData of the device used. No Data will be lost as what will happen if you use NSUserDefaults, which is a way to temporarily store data that can be manipulated by different classes and functions. This data obviously gets lost when the code is done running or if the app crashes. 


<h2>ViewControllers</h2>

<h3>PlayCheckController</h3>
This is the initial controller fired up at the start. The Play button checks if the game has been set from the settings menu. If not a message will appear that will ask you to go to the settings controller and setup the game. 

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/PlayCheckController.png?raw=true)

<h3>SettingsViewController</h3>
<p>1.</p>
This is where a big part of the magic happens. First of all the managedObjectContext is declared to create a context where objects like users and the selected dictionairy can be neatly arranged for our Indian Trader to pick up. Secondly calling the context like this makes it able to use it anywhere in the viewcontroller to arrange and wrap up our packages.

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

<p>2.</p>
Restart the match with the same settings. 

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/FinishedGameController.png?raw=true)


<h3>HighScoreTableViewController</h3>
<p>This controller executes a fetchrequest that returns objects from Core Data. These need be cast to a string and preferably sorted on score which can be achieved with the sortDescriptor. The controller then loops over the results and checks for matches for the name and score. This is then appended in to one string to be shown in the UITableView.</p>

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/HighScoreTableViewController.png?raw=true)

<h2>Classes List with description</h2>

userFiles
  <ul>
  Users.swift
    <li>createUser //creates a user in Entity Users where the UITextField is the new value to be stored and then returns a newUser.</li>     
    <li>save // Gives our Indian Trader a go to deliver all packages. Everything has been wrapped and alligned.</li>
    <li>playerisTrue // Checks for a valid input to be stored as User.</li>
    <li>checkUser // Check if the user already exists in CoreData</li>
    <li>fetchUser // Used by checkUser to see if the name that has been given already exists.</li>
    <li>fetchAll // </li>
  </ul>
  
DictFiles
  <ul>
  Dutch.swift
   <li> loadDictionairy() // Is a Function hardcoded to load the dutch .lst file and first stores the words in a String before they get pushed for word in Entity Dutch </li>
  </ul>
  <ul>
  English.swift
    <li>loadDictionairy() // Is a Function hardcoded to load the English .lst file and first stores the words in a String before they get pushed for word in Entity Dutch</li>
  </ul>
  
  <ul>
  Game.swift
<li>GameWon() // The game class gets a string and returns a boolean if a match is found to stop the game cycle. The game checks                  for valid input and checks if the current string made by the players is matching any word in the selected                      dictionairy.</li>
</ul>




