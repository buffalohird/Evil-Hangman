//
//  Project2LogicTests.m
//  Project2LogicTests
//
//  Created by Buffalo Hird on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Project2LogicTests.h"

@implementation Project2LogicTests

@synthesize gameplay = _gameplay;
@synthesize history = _history;

- (void)setUp
{
    [super setUp];
    
    [self.history load];
    
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testGoodLoadWord
{
    
    self.gameplay = [[GoodGameplay alloc] init];
    
    // set default values
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"3" forKey:@"length"];
    [defaultValues setObject:@"5" forKey:@"guesses"];
    [defaultValues setObject:@"1" forKey:@"hangmanMode"];
    
    // register default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // see if 0 is returned (e.g. proper words are found)
    STAssertTrue([self.gameplay load:defaults] == 0,@"Loading good gameplay returned no chosen word" );
    
}

- (void)testGoodCheck
{
    self.gameplay = [[GoodGameplay alloc] init];
    
    // set default values
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"3" forKey:@"length"];
    [defaultValues setObject:@"5" forKey:@"guesses"];
    [defaultValues setObject:@"1" forKey:@"hangmanMode"];
    
    // register default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // load model
    [self.gameplay load: defaults];
    
    // simulate a randomly picked word
    self.gameplay.chosenWord = @"son";
    
    // test whether the first letters of check and chosenWord are met with 1, signifying that they do in fact match
    STAssertTrue([[self.gameplay check:@"s"] objectAtIndex:0] == [NSNumber numberWithInt:1],@"Loading good gameplay incorrectly determined guess' correctness" );
    
}

- (void)testGoodChosenWord
{
    self.gameplay = [[GoodGameplay alloc] init];
    
    // set default values
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"3" forKey:@"length"];
    [defaultValues setObject:@"5" forKey:@"guesses"];
    [defaultValues setObject:@"1" forKey:@"hangmanMode"];
    
    // register default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    // load the model
    [self.gameplay load: defaults];
    
    // check whether a specific word is chosen for good hangman
    STAssertTrue(self.gameplay.chosenWord != nil,@"Loading good gameplay chosen word fails to occur" );
    
}

- (void)testEvilLoadWord
{
    
    self.gameplay = [[EvilGameplay alloc] init];
    
    // set default values
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"3" forKey:@"length"];
    [defaultValues setObject:@"5" forKey:@"guesses"];
    [defaultValues setObject:@"1" forKey:@"hangmanMode"];
    
    // register default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // see if 0 is returned (e.g. proper words are found)
    STAssertTrue([self.gameplay load: defaults] == 0,@"Loading evil gameplay returned no words" );
    
}

- (void)testEvilGameWillEnd
{
    
    self.gameplay = [[EvilGameplay alloc] init];
    
    // set default values
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"3" forKey:@"length"];
    [defaultValues setObject:@"5" forKey:@"guesses"];
    [defaultValues setObject:@"1" forKey:@"hangmanMode"];
    
    // register default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // load model
    [self.gameplay load: defaults];
    
    //simulate calling of end-of-game tidying method which commits to word
    [self.gameplay gameWillEnd];
    
    // see if a word is commited to
    STAssertTrue(self.gameplay.chosenWord != nil,@"Ending evil gameplay returns no pseudorandomly chosen word" );
    
}

- (void)testEvilWordsArray
{
    self.gameplay = [[EvilGameplay alloc] init];
    
    // set default values
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"3" forKey:@"length"];
    [defaultValues setObject:@"5" forKey:@"guesses"];
    [defaultValues setObject:@"1" forKey:@"hangmanMode"];
    
    // register default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // load model
    [self.gameplay load: defaults];
    
    // check if loaded array of guessable words was filled
    STAssertTrue(self.gameplay.wordsArray != nil,@"Loading evil gameplay gives no array of possible words" );
    
}

- (void)testEvilCheck
{
    self.gameplay = [[EvilGameplay alloc] init];
    
    // set default values
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"3" forKey:@"length"];
    [defaultValues setObject:@"5" forKey:@"guesses"];
    [defaultValues setObject:@"1" forKey:@"hangmanMode"];
    
    // register default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self.gameplay load: defaults];
    STAssertTrue([[self.gameplay check:@"s"] != nil,@"Loading evil gameplay did not return an array" );
                  
                  }
                  
                  - (void)testHistoryLoad
    {
        
        self.history = [[History alloc] init];
        [self.history load];
        
        STAssertTrue(self.history.highScores != nil, @"Loading history did not return a string detailing a filepath" );
        
    }
                  
                  - (void)testHistoryUpdate
    {
        self.history = [[History alloc] init];
        [self.history update:3 withGameWon:@"Won" andGameplay:@"Good Man"];
        
        STAssertTrue([[self.history.highScores objectAtIndex:0] isEqualToString: [NSString stringWithFormat:@"3 Guesses  Won Good Man"]], @"setting high score failed");
    }
                  
                  - (void)testHistoryClear
    {
        self.history = [[History alloc] init];
        [self.history clear];
        
        STAssertTrue([self.history.highScores count] == 0, @"history unsuccessfully cleared" );
        
        
    }
                  @end
