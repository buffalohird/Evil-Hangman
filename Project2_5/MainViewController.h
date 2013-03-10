//
//  MainViewController.h
//  Project2_5
//
//  Created by Ansel Duff on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"
#import "GoodGameplay.h"
#import "EvilGameplay.h"
#import "History.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) int guessesCounter;
@property (weak, nonatomic) IBOutlet UILabel *guessesLabel;
@property (nonatomic) int letterSpawnX;
@property (strong, nonatomic) NSMutableArray *lettersArray;
@property (strong, nonatomic) NSMutableArray *outputText;
@property (strong, nonatomic) id<GameplayDelegate> gameplay;
@property (strong, nonatomic) History *history;
@property (nonatomic) int guessesScore;
@property (strong, nonatomic) NSString *gameplayScore;
@property (strong, nonatomic) NSString *gameWon; 
@property (weak, nonatomic) IBOutlet UINavigationBar *gameNavBar;


- (IBAction)showInfo:(id)sender;
- (void) redrawLandscape;
- (void) redrawPortrait;
- (IBAction)newGame: (id)sender;
- (IBAction)updateText:(id)sender;
- (void)checkForLetter;
- (void)letterLabelCreate:(UILabel *)letterLabel withIndex: (int)i;
- (void)gameOver;
@end

