//
//  MainViewController.m
//  Project2_5
//
//  Created by Ansel Duff on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <string.h>

#import "MainViewController.h"

#define LETTERSPAWNY1  180
#define LETTERSPAWNY2  210
#define LETTERSPAWNLANDSCAPEY1 95
#define LETTERSPAWNLANDSCAPEY2 120

@implementation MainViewController

@synthesize answerLabel = _answerLabel;
@synthesize textField = _textField;
@synthesize guessesCounter = _guessesCounter;
@synthesize guessesLabel = _guessesLabel;
@synthesize letterSpawnX = _letterSpawnX;
@synthesize lettersArray = _lettersArray;
@synthesize outputText = _outputText;
@synthesize gameplay = _gameplay;
@synthesize history = _history;
@synthesize guessesScore = _guessesScore;
@synthesize gameplayScore = _gameplayScore;
@synthesize gameWon = _gameWon; 
@synthesize gameNavBar = _gameNavBar;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // create a hidden textField to recieve input from user via built-in keyboard
    self.textField.hidden = YES;
    [self.textField becomeFirstResponder];
    self.textField.text = @"_";
    
    // set default values
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"3" forKey:@"length"];
    [defaultValues setObject:@"5" forKey:@"guesses"];
    [defaultValues setObject:@"1" forKey:@"hangmanMode"];
    [defaultValues setObject:@"20" forKey:@"longestWord"];
    
    // register default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultValues];
    
    
    // initialize the lettersArray and wordArray
    self.lettersArray = [[NSMutableArray alloc] initWithObjects: nil];
    
    [self newGame: nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self redrawLandscape];
    }
    else
    {
        [self redrawPortrait];
    }
    
    
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:controller animated:YES];
}


- (void)redrawLandscape 
{
    // we need to move the interface elements created programatically to fit most optimally in the rotated display
    self.answerLabel.frame = CGRectMake(0, 65, 480, 21);
    
    self.letterSpawnX = 20;
    
    // recreates the guessable letters list
    for(int i = 0; i < 26; i++)
    {
        
        // row 1 of letters
        if( i < 13) 
        {
            UILabel *s = [self.lettersArray objectAtIndex:i];
            s.frame = CGRectMake(self.letterSpawnX, LETTERSPAWNLANDSCAPEY1, 20, 15);
            self.letterSpawnX += 35;
            
        }
        // row 2 of letters
        else 
        {
            
            // reset the x values for the beginning of row 2
            if( i == 13)
                self.letterSpawnX = 20;
            
            UILabel *s = [self.lettersArray objectAtIndex:i];
            s.frame = CGRectMake(self.letterSpawnX, LETTERSPAWNLANDSCAPEY2, 20, 15);
            self.letterSpawnX += 35;
        }
        
    }
}

- (void)redrawPortrait
{
    self.answerLabel.frame = CGRectMake(0, 122, 320, 21);
    
    self.letterSpawnX = 0;
    
    // recreates the guessable letters list
    for(int i = 0; i < 26; i++) 
    {
        
        // row 1 of letters
        if( i < 13)
        {
            UILabel *s = [self.lettersArray objectAtIndex:i];
            s.frame = CGRectMake(self.letterSpawnX, LETTERSPAWNY1, 20, 15);
            self.letterSpawnX += 25;
            
        }
        // row 2 of letters
        else 
        {
            
            // reset the x values for the beginning of row 2
            if( i == 13)
                self.letterSpawnX = 0;
            
            UILabel *s = [self.lettersArray objectAtIndex:i];
            s.frame = CGRectMake(self.letterSpawnX, LETTERSPAWNY2, 20, 15);
            self.letterSpawnX += 25;
        }
        
    }
}

- (IBAction)newGame: (id)sender{
    
    
    
    // resets the gameWon status
    self.gameWon = @"Lost on";
    
    // remove all guessed letters from the screen to begin anew
    for (UILabel *s in self.lettersArray)
    {
        
        [s removeFromSuperview];
        
    }
    
    self.letterSpawnX = 0;
    
    // creates the guessable letters list
    for(int i = 0; i < 26; i++) 
    {
        if( i < 13) 
        {
            UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.letterSpawnX, LETTERSPAWNY1, 20, 15)];
            
            [self letterLabelCreate:letterLabel withIndex:i];
        }
        
        else {
            if( i == 13)
                self.letterSpawnX = 0;
            
            UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.letterSpawnX, LETTERSPAWNY2, 20, 15)];
            
            [self letterLabelCreate:letterLabel withIndex:i];
        }
        
    }
    
    self.guessesLabel.text = @"Guess A Letter!";
    
    // resets the score
    self.guessesScore = 0;
    
    // again, load our default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // sets the gameplay mode and game title based on the user's choice
    if([[defaults stringForKey:@"hangmanMode"]intValue] == 0)
    {
        self.gameplay = [[GoodGameplay alloc] init];
        self.gameNavBar.topItem.title = @"  Hangman";
    }
    else if([[defaults stringForKey:@"hangmanMode"] intValue] == 1)
    {
        self.gameplay = [[EvilGameplay alloc] init];
        self.gameNavBar.topItem.title = @" Evil Hangman";
    }
    
    // resets the words array
    self.gameplay.wordsArray = [[NSMutableArray alloc] initWithObjects: nil];
    
    // resets the gameplayScore for score tracking
    int gameplayScoreInt = [[defaults stringForKey:@"hangmanMode"] intValue];
    if(gameplayScoreInt == 0)
        self.gameplayScore = @"Good";
    else 
        self.gameplayScore = @"Evil";
    
    
    // load the guesses counter from the user's chosen value
    self.guessesCounter = [[defaults stringForKey:@"guesses"] intValue];
    
    // we produce the correct number of blanks
    self.outputText = [[NSMutableArray alloc] init];
    
    // set up the array which the user sees (the hyphens)
    for(int counter = 0; counter < ([[defaults objectForKey:@"length"] intValue]); counter++)
    {
        [self.outputText addObject:@"- "];
    }
    
    // make the array into a string
    self.answerLabel.text = [self.outputText componentsJoinedByString:@""];
    
    // we redraw the interface to fit landscape if a new game is called in landscape
    UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        [self redrawLandscape];
    
    
    [self.gameplay load: defaults];
}

- (void)letterLabelCreate:(UILabel *)letterLabel withIndex: (int)i 
{
    
    // programmatically create one of the available letter labels and add it to the view
    letterLabel.text = [NSString stringWithFormat: @"%c", (int)('A' + i )];
    letterLabel.textColor = [UIColor whiteColor];
    letterLabel.textAlignment   = UITextAlignmentCenter;
    letterLabel.font = [UIFont systemFontOfSize:14];
    letterLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:letterLabel];
    
    // set the next letter to be further to the right
    self.letterSpawnX += 25;
    
    // add letter to array for checking if it has been guessed during the game
    [self.lettersArray insertObject:letterLabel atIndex:i];
}

- (IBAction)updateText:(id)sender
{
    
    // if it is the first guess of the game, we remove the instructions
    if(self.guessesLabel.text == @"Guess A Letter!")
        self.guessesLabel.text = [NSString stringWithFormat:@"Guesses Left: %d", self.guessesCounter];
    
    // if there is already a letter, we only select the latest letter entered
    if([self.textField.text length] > 1) 
    {
        
        BOOL flag = NO;
        NSString *newOutput = [self.textField.text substringFromIndex:[self.textField.text length] -1];
        
        // we display the new character in string form
        self.textField.text = newOutput;
        
        // we create the char version to be passed to the check function
        char guess = [[newOutput uppercaseString] characterAtIndex:0];
        
        NSArray * answer = [self.gameplay check:guess];
        
        // see where to update the string being displayed
        for (int i = 0; i < [answer count]; i++)
        {
            if([answer objectAtIndex:i] == [NSNumber numberWithInt:1])
            {
                [self.outputText replaceObjectAtIndex:(i) withObject:[NSString stringWithFormat: @"%c", toupper(guess)]];
                flag = YES;
            }
            
        }  
        
        
        // if the user guessed correctly
        if(flag == YES)
        {
            //[self.outputText replaceObjectAtIndex:(answer -1) withObject:[NSString stringWithFormat: @"%c", guess]];
            self.answerLabel.text = [self.outputText componentsJoinedByString:@""];
            
            // alert the user that they've won
            if([[self.gameplay.chosenWord uppercaseString] isEqualToString:[self.answerLabel.text uppercaseString]])
                [self gameOver];
        }
        
        // they guessed wrong, just display the old string
        else
        {
            for(UILabel *s in self.lettersArray)
            {
                
                if(guess == [s.text characterAtIndex:0])
                {
                    
                    // updates guesses fields
                    self.guessesCounter--;
                    self.guessesScore++;
                    self.guessesLabel.text = [NSString stringWithFormat:@"Guesses Left: %d", self.guessesCounter];
                    
                    // send the gameOver message if there are no remaining guesses
                    if(self.guessesCounter == 0)
                    {
                        [self.gameplay  gameWillEnd];
                        [self gameOver];
                    }
                    
                    // break out to prevent bug where multiple matches are found depending on chosenWord
                    break;
                }
            }
            
            self.answerLabel.text = [self.outputText componentsJoinedByString:@""];
        }
        
        // checks if letter is an available letter guess
        [self checkForLetter];
        
        
        // we clear the text field
        self.textField.text = [NSString stringWithFormat:(@"_")];
    }
    
    // if textField is blank, we need not delete previous data, but show it as a blank field (this happens if the user manually deletes)
    else if([self.textField.text length] == 0){
        NSString *newOutput = [NSString stringWithFormat:(@"_") ];
        // both fields are set to "_".  There is no letter to check
        self.textField.text = newOutput;
    }
    
}

-(void)checkForLetter 
{
    
    // this block of code checks if the entered letter is on the screen
    for (UILabel *s in self.lettersArray) {
        
        // we use index[0] to avoid issues with exact string values, only the first char exists for our purposes
        if([[self.textField.text uppercaseString] characterAtIndex:0] == [s.text characterAtIndex:0]) {
            
            // if found, we change the guessed letter to an underscore so the user knows not to guess it again.  This underscore also allows it to not be found by other methods which see if a letter can be guessed
            s.text = @"_";
        }
        
    }
    
}


-(void)gameOver
{
    
    // create our history object so we can record history data after gameOver alerts appear
    self.history = [[History alloc] init];
    
    // our case for losers
    if(self.guessesCounter == 0)
    {
        
        // displays an alert popup to the loser
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Game Over"
                              message:[NSString stringWithFormat:@"Your Word Was %@", self.gameplay.chosenWord]
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"New game", @"Options", nil];
        [alert show];
    }
    
    // our case for winners
    else 
    {
        
        // sets the game to won
        self.gameWon = @"Won on";
        
        // displays an alert popup to the winner
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"You Won!"
                              message:[NSString stringWithFormat:@"You Guessed %@ Correctly!", self.gameplay.chosenWord]
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"New game", @"Options", nil];
        [alert show];
        
    }
    
    // add the result of our game to history
    [self.history update:self.guessesScore withGameWon:self.gameWon andGameplay:self.gameplayScore andWord: self.gameplay.chosenWord];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    
    
    // when the user accepts the dialog we begin a new game
    if(buttonIndex == 0)
    {
        
        [self newGame: nil];
    }
    
    // or they may go straight to options to choose different settings
    if(buttonIndex == 1)
    {
        
        [self newGame: nil];
        [self showInfo:nil];
    }
    
}


@end
