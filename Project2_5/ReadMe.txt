
Ansel Duff
Buffalo Hird
Project2
Computer Science 164

README.txt - Instructions on constructing our iOSapplication.

What We've Done:

    * Completed all functionality, specs, and requirements
    * Completed our interface
    * Finished mechanisms we will use to load the larget plist and contain Evil hangman methods
    * Implemented user settings
    * Created methods to take user from a new game all the way to a game over alert
    * Hangman prototype 
    * History
    * Works with words.plist
    * Interface accepts only lowercase and uppercase letters
    * Code follows MVC structure and factored out into independent methods whenever possible
    * Unit tests
    
Notable Effects of Design Choices:

  * We load the words plist straight into memory.  We do this because, although costly to memory, we were concerning ourselves with game functionality rather than organizing the plist into a data structure (for example, one with words grouped by the length of the word, etc.).  This didn't seem worthwhile for our non-production app and it does only take 4-5 seconds on an iPhone 4 to load the whole dictionary and choose a word on good, and it should be the same time to load the dictionary on evil.
  
  * We use the NSRob object to handle all grading scenarios
  
  * We found that history, on such a small display, was fine with just a list of string with no title.  In a production environment, we might make it more attractive (actually, I'd use gamekit and gamecenter instead of local data), but since it formats correctly and properly saves/loads we didn't think this was important for the pedagogical experience that is a cs project.
  
  * We use UIStepper and UISegmentedControl instead of UISlider and UISwitch because they function the same way, and we think our choices simply look a lot better while returning the same types of data.  It would have been just as easy to limit the bounds of a slider and since we weren't required to corner case for midrange word lengths that didn't exist, it wouldn't have been any more complicated than that.

  * When the app is opened, the first key press is ignored.  This does not happen on consecutive new games 
  
  * Evil's checking mechanism, while wholly functional, is inefficent. 
  
  