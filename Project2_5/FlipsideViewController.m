//
//  FlipsideViewController.m
//  Project2_5
//
//  Created by Ansel Duff on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize guesses = _guesses;
@synthesize length = _length;
@synthesize guessesStepper = _guessesStepper;
@synthesize lengthStepper = _lengthStepper;
@synthesize hangmanMode = _hangmanMode;


- (IBAction)lengthIncrement:(id)sender {
    
    // updates textField to match stepper
    self.length.text = [NSString stringWithFormat: @"%.0f", self.lengthStepper.value];
    
    // save value
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.length.text forKey:@"length"];
    [defaults synchronize];    
}

- (IBAction)guessesIncrement:(id)sender {
    
    // updates textField to match stepper
    self.guesses.text = [NSString stringWithFormat: @"%.0f", self.guessesStepper.value];
    
    // save value
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.guesses.text forKey:@"guesses"];
    [defaults synchronize];  
}

- (IBAction)hangmanModeChange:(id)sender {
    
    
    // save value
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%d", self.hangmanMode.selectedSegmentIndex] forKey:@"hangmanMode"];
    [defaults synchronize];  
}

- (IBAction)history:(id)sender {
    HistoryViewController *viewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    viewController.modalTransitionStyle = UIModalPresentationCurrentContext;
    [self presentModalViewController:viewController animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // load saved text into text field
    self.length.text = [defaults stringForKey:@"length"];
    self.guesses.text = [defaults stringForKey:@"guesses"];
    
    // sets stepper values to match that of text fields
    self.lengthStepper.value = [self.length.text floatValue];
    self.guessesStepper.value = [self.guesses.text floatValue];
    
    // load saved game mode into segmented control
    self.hangmanMode.selectedSegmentIndex = [[defaults stringForKey:@"hangmanMode"] intValue];
    
    // limit the length stepper maximum value to the length of the longest word in the plist
    self.lengthStepper.maximumValue =  self.hangmanMode.selectedSegmentIndex = [[defaults stringForKey:@"longestWord"] intValue];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
