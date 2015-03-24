<h1>Ghost Word IOS Game Design Document<h1> 

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

I started this project for the Stanford CS193P IOS Swift Course. The assignment is to build the game Ghost. 

Ghost is a written or spoken word game in which players take turns adding letters to a growing word fragment, trying not to be the one to complete a valid word. Each fragment must be the beginning of an actual word, and usually some minimum is set on the length of a word that counts, such as three or four letters. The player who completes a word loses the round and earns a "letter" (as in the basketball game horse), with players being eliminated when they have been given all five letters of the word "ghost".

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

I choose to use the CoreData because it was offered in the app it's core functions. CoreData has a bit of a learning curve but the fun begins when you get that Trader to work for you as he should. The advantage of using CoreData is that if your app crashes data is saved in the CoreData of the phone. No Data will be lost as what will happen if you use NSUserDefaults, which is a way to temporarily store data that can be manipulated by different classes and functions. This data obviously gets lost when the code is done running or if the app crashes. 


<h2>ViewControllers</h2>
![Alt text](https://github.com/Master244/Calculator-App-/blob/master/doc/NSM.png?raw=true)





