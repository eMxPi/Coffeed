//
//  FeedTableViewController.h
//  Coffeed
//
//  Created by Maxime Pontoire on 28/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleViewController.h"
#import "EmptyCell.h"
#import "FeedCell.h"
#import "Feed.h"
#import "MachineUtil.h"
#import "DayCell.h"
#import "Feed.h"

@interface FeedTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ArticleViewControllerDelegate> {
    ArticleViewController *articleView;
    
}
@property (nonatomic, retain) IBOutlet UITableView *feedTableView;
@property (nonatomic, retain) NSMutableArray *feedSource;

@end
