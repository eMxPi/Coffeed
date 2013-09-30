//
//  FeedListViewController.h
//  Coffeed
//
//  Created by Maxime Pontoire on 25/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JSON.h"
#import "UIImage+StackBlur.h"
#import "FeedCell.h"
#import "EmptyCell.h"
#import "Feed.h"
#import "Constantes.h"
#import "ArticleViewController.h"
#import "MachineUtil.h"
#import "DayCell.h"
#import "ResumeCell.h"
#import "ContentFeedListCell.h"
#import "EmptyTopCell.h"
#import "DayViewController.h"
#import "FeedTableViewController.h"
#import "ResumeViewController.h"
#import "EmptyViewController.h"
#import "FeedlyUtils.h"

@protocol FeedListViewControllerDelegate;
@interface FeedListViewController : UIViewController <UIGestureRecognizerDelegate, ArticleViewControllerDelegate, UIScrollViewDelegate, NSURLConnectionDelegate> {
    id<FeedListViewControllerDelegate>__unsafe_unretained delegate;
    IBOutlet UIButton *listButton;
    IBOutlet UIButton *imageButton;
    IBOutlet UIView *feedView;
    IBOutlet UITableView *feedTableView;// URL to larger image
    IBOutlet UIImageView *backgroundImage;
    BOOL isDeployed;
    UIImage *imageBack;
    NSMutableArray *feedSource;
    NSMutableArray *feedSourceParsed;
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
    CLLocationManager *locationManager;
    IBOutlet UIView *resumeView;
    BOOL isList;
    IBOutlet UIButton *menuButton;
    ArticleViewController *articleView;
    IBOutlet UIScrollView *contentScrollView;
    DayViewController *dayView;
    FeedTableViewController *tableFeedView;
    ResumeViewController *resumeViewController;
    EmptyViewController *emptyView;
    NSMutableArray *imageBlurredArray;
    NSMutableData *myData;
}
@property (nonatomic, unsafe_unretained) id<FeedListViewControllerDelegate>delegate;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *counterFeedText;
@property (strong, nonatomic) IBOutlet UILabel *helloTitle;
@property (strong, nonatomic) IBOutlet UIButton *listButton;
@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) UIImage *imageBack;

- (IBAction)menuPressed:(id)sender;
- (IBAction)listPressed:(id)sender;
- (IBAction)imagePressed:(id)sender;
- (IBAction)displayFeedPressed:(id)sender;

@end

@protocol FeedListViewControllerDelegate
-(void)retourMenuFeedPressed;
@required
@end