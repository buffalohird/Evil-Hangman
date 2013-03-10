//
//  EvilGameplay.m
//  Project2_5
//
//  Created by Buffalo Hird on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EvilGameplay.h"

@implementation EvilGameplay

@synthesize chosenWord = _chosenWord;
@synthesize response = _response;
@synthesize wordsArray = _wordsArray;


/*
 * This method is the bulk of Evil Hangman's implementation; it creates the equivilence classes (ECs) 
 * and dodges the user's potential guesses. Here's a brief synopsis of how it works:
 *
 * There is a 'wrapper' array (array of arrays) called evilWrapper which contains all of the equivilence classes.
 * The outermost "for" loop iterates through all of the words in the wordslist (which is decreasing in size each time!)
 * and sorts each word into an EC. If the word doesn't fit into a preexisting EC, we make our own. This is an NSMutableArray
 * where the first object is the 'label' (criteria) for the EC and the other objects are the words themselves in the EC. An example of this
 * label would be "B---" and the EC would consist of all words whose first letter is B. If the word does fit into a preexisting EC, we just
 * add it to said EC. All ECs exist in evilWrapper so that we can search multi-dimensional arrays relatively easily. We then find the largest
 * EC (randomely breaking any ties per the spec) and narrow wordsArray down to all of the words in that EC. Thus we are dodging the user's
 * potential guesses. Simple, right? lawl jk. I know this sounds confusing and I did a bad job at explaining it. If you have any questions,
 * feel free to shoot us an email.
 *
 */

- (NSArray *)check:(char)guess 
{
    
    // the goods of the operation
    NSMutableArray *evilWrapper = [[NSMutableArray alloc] init];
        
    UTF8Char *checker;
    
    // iterate through all possible words
    for(NSString * word in self.wordsArray)
    {
        // if, by some chance, we get a bad word
        if(!word)
            continue;
        
        // there's one possible word, we know the chosenWord
        else if([self.wordsArray count] == 1)
            self.chosenWord = [self.wordsArray objectAtIndex:0];
        
        // this is for the creation/ comparison of our ECs
        NSMutableString *temp= [[NSMutableString alloc] init];
        
        // iterate through the word
        for(int i = 0; i < [word length]; i++)
        {
            // if a char is the same as our guess, then the ith character of our temp string is the guesses character
            if([word characterAtIndex:i] == toupper(guess) || [word characterAtIndex:i] == tolower(guess))
            {
                [temp appendFormat:@"%c", toupper(guess)];
            }
            else
            {
                [temp appendFormat:@"-"];
            }
        }
        
        
        BOOL foundEC = NO;
        
        // iterate through existing ECs and add the word into one if it fits
        for (int j = 0; j < [evilWrapper count]; j++)
        {
            if([temp isEqualToString:[[evilWrapper objectAtIndex:j] objectAtIndex:0]])
            {
                // add it to the jth EC
                foundEC = YES;
                [[evilWrapper objectAtIndex:j] addObject:word];
                break;             
            }
        }
        
        
        // if there was no appropriate preexisting EC
        if(foundEC == NO)
        {
            // create a new EC
            NSMutableArray *EC = [[NSMutableArray alloc] init];
            [EC addObject:temp];
            [EC addObject:word];
            
            // add that EC to our wrapper of ECs (for comparison on the next iteration)
            [evilWrapper addObject:EC];
        }
        
    }
    
    // to see the 'largest' EC
    int ECCounter = [[evilWrapper objectAtIndex:0] count];
    
    // remember the location of the largest EC
    int storage = 0;
    
    // iterate through all the ECs
    for (int k = 0; k < [evilWrapper count]; k++)
    {
        
        // we've found a new max-length EC
        if([[evilWrapper objectAtIndex:k]count] > ECCounter)
        {
            // update our max counter, remember its location
            ECCounter = [[evilWrapper objectAtIndex:k]count];
            storage = k;
        }
        // randomely (well kind of) break any ties between ECs of the same size
        else if ([[evilWrapper objectAtIndex:k]count] == ECCounter)
        {
            int tieBreaker[] = {storage, k};
            int random = arc4random() % 2;
            storage = tieBreaker[random];
            ECCounter = [[evilWrapper objectAtIndex:storage]count];
        }
        
    }
    
    // select the biggest EC for comparison with the user's guess
    checker = [[[evilWrapper objectAtIndex:storage] objectAtIndex:0] UTF8String];
    
    // remove the first object (the label) from the class so now it only contains the proper words
    [[evilWrapper objectAtIndex:storage] removeObjectAtIndex:0];
    
    // replace our wordsArray with the largest (now mofidied) EC
    self.wordsArray = [evilWrapper objectAtIndex:storage];

    // return our response array
    return [self finalCheck:checker withGuess:guess];
}

- (NSMutableArray *)finalCheck:(UTF8Char*)checker withGuess: (char)guess
{
    NSMutableArray * response = [[NSMutableArray alloc] init];
    
    // iterate through the EC and see where it matches our guess (if at all) 
    for(int i = 0; i < strlen(checker); i++)
    {
        
        // the user guessed correctly
        if(guess == toupper(checker[i])  || (guess == tolower(checker[i])))
        {
            [response insertObject:[NSNumber numberWithInt:1] atIndex:i];
            continue;
        }
        // incorrect guess
        else
        {
            [response insertObject:[NSNumber numberWithInt:0] atIndex:i];
        }
    }
    
    return response;
    
}

- (int)load: (NSUserDefaults *)defaults
{
    // removes all words to begin new game
    [self.wordsArray removeAllObjects];
    
    // load the dictionary from our plist
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    
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
        return 0;
    }
    
    return 1;
}

- (void)gameWillEnd
{
    //  commit to a chosen word to display to the user. we can just choose a word randomely from the largest EC (which is now wordsArray)
    int random = arc4random() % ([self.wordsArray count] + 1);
    self.chosenWord = [self.wordsArray objectAtIndex:random];
}


@end
