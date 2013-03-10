//
//  FlipsideViewController.h
//  Project2_5
//
//  Created by Ansel Duff on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameplayDelegate.h"
#import "HistoryViewController.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *guesses;
@property (weak, nonatomic) IBOutlet UILabel *length;
@property (weak, nonatomic) IBOutlet UIStepper *guessesStepper;
@property (weak, nonatomic) IBOutlet UIStepper *lengthStepper;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hangmanMode;


- (IBAction)done:(id)sender;
- (IBAction)history:(id)sender;
- (IBAction)lengthIncrement:(id)sender;
- (IBAction)guessesIncrement:(id)sender;
- (IBAction)hangmanModeChange:(id)sender;

@end
