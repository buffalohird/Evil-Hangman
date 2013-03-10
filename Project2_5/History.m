//
//  History.m
//  Project2_5
//
//  Created by Buffalo Hird on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "History.h"

@implementation History

@synthesize highScores = _highScores;
@synthesize storage = _storage;

-(NSString *)load
{
    // connect to filepath and fill array with contents
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"highscores.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        // if not in documents, create a blank array
        self.highScores = [[NSMutableArray alloc] init ];
    }
    else 
        // fill array with contents of high scores
        self.highScores = [NSMutableArray arrayWithContentsOfFile:path];
    
    
    //path = [documentsDirectory stringByAppendingPathComponent:@"highscores.plist"];
    return path;
    
    
}

-(void)update:(int)guessesScore withGameWon:(NSString *)gameWon andGameplay: (id) gameplayScore andWord:(NSString *)word
{
    // recreate our path string from the path string passed by the loading of history
    NSString *path = [NSString stringWithString:[self load]];
    
    // corner case to keep history list to only ten items
    if([self.highScores count] > 9)
    {
        // remove the oldest item from the array
        [self.highScores removeObjectAtIndex:0];
        
        // create a temporary second array to add new list to
        NSMutableArray *tempHistoryArray = [NSMutableArray arrayWithArray:self.highScores];
        int i = 0;
        
        // for each remaining score in memory, add it to the temp list starting with the index 0 (ending at index 8)
        for(NSArray *s in self.highScores)
        {
            [tempHistoryArray insertObject:s atIndex:i];
            i++;
        }
        
        // transfer this new data over to the history array, which now has space for the tenth item
        [self.highScores arrayByAddingObjectsFromArray:tempHistoryArray];
    }
    
    // corner case for proper pluralization of guesses
    NSString *guessesScoreString = [NSString alloc];
    if(guessesScore == 1)
        guessesScoreString = [NSString stringWithFormat: @"%d Try", guessesScore];
    else
        guessesScoreString = [NSString stringWithFormat: @"%d Tries", guessesScore];

    
    self.storage = [[NSArray alloc] initWithObjects:guessesScoreString, gameWon, gameplayScore, word, nil];
    
    // add the new score to the history array
    [self.highScores addObject:self.storage];
    
    // write the updated string to the file path
    [self.highScores writeToFile:path atomically:YES];
    
    
}





// method for development purposes, in case we want to clear out the high scores list.
-(void)clear
{
    // recreate our path string from the path string passed by the loading of history
    NSString *path = [NSString stringWithString:[self load]];
    
    // empty the high scores list to be written to file
    [self.highScores removeAllObjects];
    
    // write the empty array to disk
    [self.highScores writeToFile:path atomically:YES];
}



@end
