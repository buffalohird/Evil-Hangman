//
//  Project2LogicTests.h
//  Project2LogicTests
//
//  Created by Buffalo Hird on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "History.h"
#import "GoodGameplay.h"
#import "EvilGameplay.h"

@interface Project2LogicTests : SenTestCase

@property (strong, nonatomic) id<GameplayDelegate> gameplay;
@property (strong, nonatomic) History *history;

@end
