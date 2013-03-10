//
//  NSRob.m
//  Project2_5
//
//  Created by Buffalo Hird on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSRob.h"

@implementation NSRob

@synthesize eyes = _eyes;

- (int)gradeProjectTwo:(NSObject *)project 
{
    if(project.superclass == @"Buff&Duff")
        return 100; // percent
    else 
        return 99; // percent
    
}

@end
