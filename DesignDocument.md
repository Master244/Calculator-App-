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


<p>GameController</p>
<p>1.</p>
Pushes the input from the TextField to the database if it conforms to a couple of conditions. The checkMaxLength functions checks if only 1 character is given. And the CheckInput Class in Game checks if the input conforms to one of the cases specified.

<p>2.</p>
Makes sure that the current string variable is only updated after the viewdidload() which means you first want to have your functions executed before you want to update the currentString in the view. Only then are you sure that it passed all your conditions. 

<p>3.<p>
Sets an image from the image library as background for the ViewController.

<p>4.<p>
An Override function that hides the keyboard when a touch is recorded outside of the TextField.

![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/GameController.png?raw=true)


