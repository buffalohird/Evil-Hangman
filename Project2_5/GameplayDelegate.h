//
//  GameplayDelegate.h
//  Project2_5
//
//  Created by Buffalo Hird on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameplayDelegate <NSObject>

@property (strong, nonatomic) NSString *chosenWord;
@property (strong, nonatomic) NSMutableArray *response;
@property (strong, nonatomic) NSMutableArray *wordsArray;

- (NSArray*)check:(char)guess;
- (int)load:(NSUserDefaults *)defaults;
- (void)gameWillEnd;

@end