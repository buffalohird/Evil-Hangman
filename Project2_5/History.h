//
//  History.h
//  Project2_5
//
//  Created by Buffalo Hird on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject

@property (strong, nonatomic) NSMutableArray *highScores;
@property (strong, nonatomic) NSArray *storage;

-(NSString *)load;
-(void)update:(int)guessesScore withGameWon:(NSString *)gameWon andGameplay:(id)gameplayScore andWord:(NSString *)word;
-(void)clear;



@end
