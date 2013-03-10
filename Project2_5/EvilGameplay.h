//
//  EvilHangman.h
//  Project2_5
//
//  Created by Buffalo Hird on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameplayDelegate.h"

@interface EvilGameplay : NSObject <GameplayDelegate, UITextFieldDelegate>

- (NSMutableArray *)finalCheck:(UTF8Char*)checker withGuess: (char)guess;

@end
