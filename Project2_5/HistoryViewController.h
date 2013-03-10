//
//  HistoryViewController.h
//  Project2_5
//
//  Created by Buffalo Hird on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "History.h"

@interface HistoryViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) History *history;



@end
