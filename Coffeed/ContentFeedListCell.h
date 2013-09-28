//
//  ContentFeedListCell.h
//  Coffeed
//
//  Created by Maxime Pontoire on 28/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyCell.h"
#import "FeedCell.h"
#import "Feed.h"
#import "MachineUtil.h"
#import "ArticleViewController.h"

@interface ContentFeedListCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource, ArticleViewControllerDelegate> {
    ArticleViewController *articleView;
}
@property (nonatomic, retain) IBOutlet UITableView *feedTableView;
@property (nonatomic, retain) NSMutableArray *feedSource;

@end
