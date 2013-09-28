//
//  FeedViewController.h
//  Coffeed
//
//  Created by Maxime Pontoire on 19/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "UIImage+StackBlur.h"
#import "FeedCell.h"
#import "EmptyCell.h"
#import "Feed.h"
#import "Constantes.h"
#import "MenuAccountCell.h"
#import "MenuItem.h"
#import "SettingsViewController.h"
#import "MachineUtil.h"
#import "FeedListViewController.h"

@protocol FeedViewControllerDelegate;
@interface FeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, SettingsViewControllerDelegate, FeedListViewControllerDelegate>
{
    id<FeedViewControllerDelegate>__unsafe_unretained delegate;
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIView *feedView;
    IBOutlet UITableView *feedTableView;
    IBOutlet UIView *darkView;
    NSMutableArray *feedSource;
    NSMutableArray *menuSource;
    IBOutlet UIView *rightView;
    BOOL isDeployed;
    UIImage *imageBack;
    IBOutlet UIView *resumeView;
    IBOutlet UILabel *countFeedText;
    IBOutlet UIImageView *backgroundMenuImage;
    IBOutlet UITableView *menuTableView;
    SettingsViewController *settingsViewController;
    FeedListViewController *feedListViewController;
    BOOL isMenuDisplayed;
    BOOL isImage;
}

@property (nonatomic, unsafe_unretained) id<FeedViewControllerDelegate>delegate;
@property (nonatomic, retain) UIImage *imageBack;

- (IBAction)menuPressed:(id)sender;

@end

@protocol FeedViewControllerDelegate
-(void)fermerPressed;
@required
@end