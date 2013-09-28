//
//  ArticleViewController.h
//  Coffeed
//
//  Created by Maxime Pontoire on 26/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"
#import "ArticleHeaderCell.h"
#import "ArticleImageCell.h"
#import "ArticleTextCell.h"

@protocol ArticleViewControllerDelegate;
@interface ArticleViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate> {
    id<ArticleViewControllerDelegate>__unsafe_unretained delegate;
    IBOutlet UIView *topView;
    IBOutlet UIView *bottomView;
    IBOutlet UITextView *textScrollView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UITableView *articleTableView;
    NSMutableArray *articleSource;
    CGPoint precY;
    BOOL isStart;
    BOOL isAnimated;
}
@property (nonatomic, unsafe_unretained) id<ArticleViewControllerDelegate>delegate;
@property (nonatomic, retain) NSString *titleArticle;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSMutableArray *articleSource;
- (IBAction)backPressed:(id)sender;

@end

@protocol ArticleViewControllerDelegate
-(void)retourArticlePressed;
@required
@end