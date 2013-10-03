//
//  FeedListViewController.m
//  Coffeed
//
//  Created by Maxime Pontoire on 25/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "FeedListViewController.h"

@interface FeedListViewController ()

@end

@implementation FeedListViewController
@synthesize delegate, dateLabel, helloTitle, counterFeedText, listButton, imageButton, imageBack, subscriptionsSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Reglages
    feedView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *downReglages = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(revealFeed)];
    downReglages.delegate = self;
    [downReglages setDirection:UISwipeGestureRecognizerDirectionUp];
    [feedView addGestureRecognizer:downReglages];
    
    feedView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *upReglages = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideFeed)];
    upReglages.delegate = self;
    [upReglages setDirection:UISwipeGestureRecognizerDirectionDown];
    [feedView addGestureRecognizer:upReglages];
    
    
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuPressed:)];
    left.delegate = self;
    [left setDirection:UISwipeGestureRecognizerDirectionLeft];
    [menuButton addGestureRecognizer:left];
    
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuPressed:)];
    right.delegate = self;
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [menuButton addGestureRecognizer:right];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayFeed:) name:@"displayFeed" object:nil];
    
    
    isDeployed = FALSE;
    isList = TRUE;
    [barreImage setAlpha:0.0];
    
    [self changeButton];
    
    // Bouchon
    /*feedSource = [[NSMutableArray alloc] init];
     Feed *feed1 = [[Feed alloc] init];
     feed1.id = @"343FR4231";
     feed1.titre = @"GTA Online : démarrage";
     feed1.source = @"Veendesign";
     feed1.date = @"1367539068016";
     feed1.resume = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit";
     feed1.content = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
     [feedSource addObject:feed1];
     Feed *feed2 = [[Feed alloc] init];
     feed2.id = @"ZZERE-34";
     feed2.titre = @"JF Coppé quitte la politique";
     feed2.source = @"Le Monde";
     feed2.date = @"1380287153000";
     feed2.resume = @"Lorem 2 ipsum dolor sit amet, consectetur adipisicing elit";
     feed2.content = @"Lorem 2 ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
     [feedSource addObject:feed2];
     Feed *feed3 = [[Feed alloc] init];
     feed3.id = @"WDER-34";
     feed3.titre = @"Coffeed, prenez un café";
     feed3.source = @"Coffeed";
     feed3.date = @"1380529045000";
     feed3.resume = @"Une superbe application";
     feed3.content = @"Lorem 3 ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
     [feedSource addObject:feed3];*/
    [feedTableView reloadData];
    
    [backgroundImage setImage:imageBack];
    [contentScrollView setDelegate:self];
    
    //Blurring images
    imageBlurredArray = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        [imageBlurredArray addObject:[imageBack stackBlur:i*5]];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    feedSource = [self retrieveFeeds];
    [self parseFeedText];
    [self makeScrollView];
}

-(NSMutableArray *)retrieveFeeds {
    NSMutableArray *feeds = nil;
    if (subscriptionsSource != nil && [subscriptionsSource count] > 0) {
        feeds = [[NSMutableArray alloc] init];
        for (int i=0;i<[subscriptionsSource count];i++) {
            Abonnement *abo = [subscriptionsSource objectAtIndex:i];
            [feeds addObjectsFromArray:[FeedlyUtils parseFeed:[FeedlyUtils getEntriesForAbonnement:abo.id]]];
        }
    }
    return feeds;
}

-(void)makeScrollView {
    if (!emptyView) {
        if ([MachineUtil isHighSize]) {
            emptyView = [[self storyboard] instantiateViewControllerWithIdentifier:@"emptyViewController"];
        } else {
            emptyView = [[self storyboard] instantiateViewControllerWithIdentifier:@"emptyViewController"];
        }
    }
    [emptyView.view setFrame:CGRectMake(0, 0, 320, 320)];
    [contentScrollView addSubview:emptyView.view];
    
    if (!resumeViewController) {
        if ([MachineUtil isHighSize]) {
            resumeViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"resumeViewController"];
        } else {
            resumeViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"resumeViewController"];
        }
    }
    [resumeViewController.view setFrame:CGRectMake(0, 340, 320, 165)];
    [resumeViewController.helloText setText:[NSString stringWithFormat:@"Hello %@,",[[PersistanceManager sharedPersistanceManager] getValueKey:nameTokenKey]]];
    [resumeViewController.unreadText setText:[self makeFeedText]];
    [contentScrollView addSubview:resumeViewController.view];
    
    if (feedSource == nil || [feedSource count] == 0) {
        contentScrollView.contentSize = CGSizeMake(320, 485);
    } else {
        feedSourceParsed =[self formatFeedTable];
        if (!tableFeedView) {
            if ([MachineUtil isHighSize]) {
                tableFeedView = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedTableViewController"];
            } else {
                tableFeedView = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedTableViewController"];
            }
        }
        [tableFeedView.view setFrame:CGRectMake(0, 484, 320, 523)];
        tableFeedView.feedSource = feedSourceParsed;
        [tableFeedView.feedTableView reloadData];
        [contentScrollView addSubview:tableFeedView.view];
        contentScrollView.contentSize = CGSizeMake(320, 1008);
    }
}

-(NSString *)formatDate:(NSString *)timestamp {
    NSString *dateOut = @"";
    NSDate *now = nil;
    if (timestamp == nil || [timestamp isEqualToString:@""]) {
        now = [NSDate date];
    } else {
        double time = [timestamp doubleValue];
        time = time /1000;
        now = [NSDate dateWithTimeIntervalSince1970:time];
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    dateOut = [dateFormat stringFromDate:now];
    return dateOut;
}

-(NSMutableArray *)formatFeedTable {
    // Sort
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    feedSource = [NSMutableArray arrayWithArray:[feedSource sortedArrayUsingDescriptors:sortDescriptors]];
    
    // populata
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *today = [self formatDate:nil];
    NSString *precDate = @"";
    for (int i=0; i<[feedSource count]; i++) {
        Feed *feed = [feedSource objectAtIndex:i];
        NSString *currentDate = [self formatDate:feed.date];
        if (![currentDate isEqualToString:precDate]) {
            Feed *feedTitre = [[Feed alloc] init];
            if ([currentDate isEqualToString:today]) {
                feedTitre.isDay = TRUE;
                feedTitre.titre = @"TODAY";
            } else {
                feedTitre.isDay = TRUE;
                feedTitre.titre = currentDate;
            }
            feedTitre.titre = [self formatDay:feedTitre.titre];
            [array addObject:feedTitre];
        }
        [array addObject:feed];
    }
    return array;
}

-(NSString *)formatDay:(NSString *)string {
    NSMutableArray *bufferTemp = [[NSMutableArray alloc] init];
    for (int i = 0; i < [string length]; i++) {
        [bufferTemp addObject:[NSString stringWithFormat:@"%C", [string characterAtIndex:i]]];
    }
    return [bufferTemp componentsJoinedByString:@" "];
}

-(void)changeButton {
    if (isList) {
        [listButton setImage:[UIImage imageNamed:@"navbar_liste_on.png"] forState:UIControlStateNormal];
        [imageButton setImage:[UIImage imageNamed:@"navbar_image_off.png"] forState:UIControlStateNormal];
    } else {
        [listButton setImage:[UIImage imageNamed:@"navbar_liste_off.png"] forState:UIControlStateNormal];
        [imageButton setImage:[UIImage imageNamed:@"navbar_image_on.png"] forState:UIControlStateNormal];
    }
}


-(void)revealFeed {
    isDeployed = TRUE;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector: @selector(hideResume)];
    [UIView setAnimationDidStopSelector: @selector(blurImage)];
    [feedView setFrame:CGRectMake(0, 58, feedView.frame.size.width, feedView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)hideFeed {
    isDeployed = FALSE;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector: @selector(revealResume)];
    [feedView setFrame:CGRectMake(0, 535, feedView.frame.size.width, feedView.frame.size.height)];
    [UIView commitAnimations];
}
-(void)hideResume {
    [resumeView setHidden:TRUE];
}

-(void)revealResume {
    // TODO count Feed
    [self parseFeedText];
    [resumeView setHidden:FALSE];
    [self unBlurImage];
}

-(void)parseFeedText {
    [counterFeedText setText:[self makeFeedText]];
}

-(NSString *)makeFeedText {
    NSString *output = @"no new item.";
    
    if (feedSource && [feedSource count] > 0) {
        if ([feedSource count] == 1) {
            output = @"1 new item.";
        } else {
            output = [NSString stringWithFormat:@"%i new items.", [feedSource count]];
        }
    }
    return output;
}

-(void)blurImage {
    UIImage *newIma=[imageBack stackBlur:15.0];
    [backgroundImage setImage:newIma];
}

-(void)unBlurImage {
    [backgroundImage setImage:imageBack];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuPressed:(id)sender {
    [delegate retourMenuFeedPressed];
}

- (IBAction)listPressed:(id)sender {
    isList = TRUE;
    [self changeButton];
}

- (IBAction)imagePressed:(id)sender {
    isList = FALSE;
    [self changeButton];
}

- (IBAction)displayFeedPressed:(id)sender {
    [self revealFeed];
}

-(void)displayFeed:(NSNotification *)notification {
    
    Feed *feed = [self getFeedFromId:[[notification userInfo] objectForKey:@"feed"]];
    
    if ([MachineUtil isNetworkActivated]) {
        if (!articleView) {
            if ([MachineUtil isHighSize]) {
                articleView = [[self storyboard] instantiateViewControllerWithIdentifier:@"articleViewController"];
            } else {
                articleView = [[self storyboard] instantiateViewControllerWithIdentifier:@"articleViewController"];
            }
        }
        articleView.delegate = self;
        NSMutableArray *articleSource = [[NSMutableArray alloc] init];
        [articleSource addObject:feed];
        articleView.articleSource = articleSource;
        articleView.titleArticle = feed.titre;
        articleView.text = feed.content;
        articleView.id = feed.id;
        [articleView.view setFrame:CGRectMake(320, 0, articleView.view.frame.size.width, articleView.view.frame.size.height)];
        [self.view addSubview:articleView.view];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        [articleView.view setFrame:CGRectMake(0, 0, articleView.view.frame.size.width, articleView.view.frame.size.height)];
        [UIView commitAnimations];
    }
}

-(Feed *)getFeedFromId:(NSString *)id {
    Feed *feed = nil;
    for (int i=0;i<[feedSource count];i++) {
        Feed *currentFeed = [feedSource objectAtIndex:i];
        if ([currentFeed.id isEqualToString:id]) {
            feed = currentFeed;
            break;
        }
    }
    return feed;
}

#pragma mark ArticleViewController
-(void)retourArticlePressed:(NSString *)id {
    if (articleView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(removeArticle)];
        [articleView.view setFrame:CGRectMake(320, 0, articleView.view.frame.size.width, articleView.view.frame.size.height)];
        [UIView commitAnimations];
    }
    Feed *feed = [self getFeedFromId:id];
    if (feed != nil) {
        [feedSource removeObject:feed];
    }
    [self makeScrollView];
}

-(void)removeArticle {
    [articleView.view removeFromSuperview];
    articleView = nil;
    [articleView.view setFrame:CGRectMake(0, -1500, articleView.view.frame.size.width, articleView.view.frame.size.height)];
}

#pragma mark scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGPoint currentOffset = scrollView.contentOffset;
    if (currentOffset.y > 21 && currentOffset.y <= 42) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:0]];
        [barreImage setAlpha:0.05];
    } else if (currentOffset.y > 42 && currentOffset.y <= 63) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:1]];
        [barreImage setAlpha:0.1];
    } else if (currentOffset.y > 63 && currentOffset.y <= 84) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:2]];
        [barreImage setAlpha:0.15];
    } else if (currentOffset.y > 105 && currentOffset.y <= 126) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:3]];
        [barreImage setAlpha:0.2];
    } else if (currentOffset.y > 127 && currentOffset.y <= 148) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:4]];
        [barreImage setAlpha:0.25];
    } else if (currentOffset.y > 148 && currentOffset.y <= 160) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:5]];
        [barreImage setAlpha:0.3];
    } else if (currentOffset.y > 160 && currentOffset.y <= 181) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:6]];
        [barreImage setAlpha:0.35];
    } else if (currentOffset.y > 181 && currentOffset.y <= 202) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:7]];
        [barreImage setAlpha:0.4];
    } else if (currentOffset.y > 202 && currentOffset.y <= 244) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:8]];
        [barreImage setAlpha:0.45];
    } else if (currentOffset.y > 244 && currentOffset.y <= 265) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:9]];
        [barreImage setAlpha:0.5];
    } else if (currentOffset.y > 265 && currentOffset.y <= 286) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:10]];
        [barreImage setAlpha:0.55];
    } else if (currentOffset.y > 286 && currentOffset.y <= 307) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:11]];
        [barreImage setAlpha:0.6];
    } else if (currentOffset.y > 307 && currentOffset.y <= 328) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:12]];
        [barreImage setAlpha:0.65];
    } else if (currentOffset.y > 328 && currentOffset.y <= 349) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:13]];
        [barreImage setAlpha:0.7];
    } else if (currentOffset.y > 349 && currentOffset.y <= 370) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:14]];
        [barreImage setAlpha:0.75];
    } else if (currentOffset.y > 370 && currentOffset.y <= 391) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:15]];
        [barreImage setAlpha:0.8];
    } else if (currentOffset.y > 391 && currentOffset.y <= 412) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:16]];
        [barreImage setAlpha:0.85];
    } else if (currentOffset.y > 412 && currentOffset.y <= 433) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:17]];
        [barreImage setAlpha:0.9];
    } else if (currentOffset.y > 433 && currentOffset.y <= 454) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:18]];
        [barreImage setAlpha:0.95];
    } else if (currentOffset.y > 454 && currentOffset.y <= 475) {
        [backgroundImage setImage:[imageBlurredArray objectAtIndex:19]];
        [barreImage setAlpha:1.0];
    } else if (currentOffset.y <= 21) {
        [backgroundImage setImage:imageBack];
        [barreImage setAlpha:0.0];
    }
}

@end
