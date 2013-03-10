//
//  GoodGameplay.m
//  Project2_5
//
//  Created by Buffalo Hird on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GoodGameplay.h"

@implementation GoodGameplay

@synthesize chosenWord = _chosenWord;
@synthesize response = _response;
@synthesize wordsArray = _wordsArray;

- (NSArray *)check:(char)guess
{
    // turn the randomely chosen word into a c string (array of chars)
    const char * cString = [self.chosenWord UTF8String];
    
    self.response = [[NSMutableArray alloc] initWithCapacity:strlen(cString)];
    
    // iterate thru, look for matches against the user's guess
    for(int i = 0; i < strlen(cString); i++)
    {
        // user guessed corrently
        if((guess == toupper(cString[i])) || (guess == tolower(cString[i])))
            [self.response insertObject:[NSNumber numberWithInt:1] atIndex:i];
        // or incorrectly
        else
            [self.response insertObject:[NSNumber numberWithInt:0] atIndex:i];
    }
    
    return self.response;
    
}

- (int)load: (NSUserDefaults *)defaults
{
    // removes all words to begin new game
    [self.wordsArray removeAllObjects];
    
    // load the dictionary from our plist
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    
    // iterates through the dictionary and finds the longest word to determine the maximum length the user can set under options
    NSString *longestWord = @"";
    for(NSString *str in words)
    {
        // replace the current 'king of length' if a longer word is found
        if([str length] > [longestWord length])
        {
            longestWord = str;
        }
    }
    
    // add this length to defaults
    [defaults setObject:[NSString stringWithFormat:@"%d", [longestWord length]] forKey:@"longestWord"];
    [defaults synchronize];  
    
    // iterate through the words, and match any of the length specified by the user
    for (NSString *word in words)
    {
        // match
        if([word length] ==  [[defaults objectForKey:@"length"] intValue])
        {
            // add to our wordsArray
            [self.wordsArray addObject:word];
        }
    }
    
    // corner case for if no words of suitable length exist (shouldn't happen in final version)
    if([self.wordsArray count] != 0) 
    {
        // randomely pick a word, 'store' it
        int random = (arc4random() % [self.wordsArray count]);
        self.chosenWord = [self.wordsArray objectAtIndex:random];
        return 0;
    }
    
    return 1;
    
}

- (void)gameWillEnd
{
    //  no tidying required in good mode
}

@end
