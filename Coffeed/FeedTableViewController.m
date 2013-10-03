//
//  FeedTableViewController.m
//  Coffeed
//
//  Created by Maxime Pontoire on 28/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "FeedTableViewController.h"

@interface FeedTableViewController ()

@end

@implementation FeedTableViewController
@synthesize feedTableView, feedSource;

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
	// Do any additional setup after loading the view.
    [feedTableView setDelegate:self];
    [feedTableView setDataSource:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [feedTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == feedTableView) {
        if (feedSource && [feedSource count] > 0) {
            Feed *feed = [feedSource objectAtIndex:indexPath.row];
            if (feed.isDay) {
<<<<<<< HEAD
                return 25;
            } else {
                if ([feed.titre length] <= 31) {
                    return 75;
                } else if ([feed.titre length] <= 62) {
                    return 88;
                } else {
                    return 102;
                }
=======
<<<<<<< HEAD
                return 25;
            } else {
                return 75;
=======
                return 44;
            } else {
                return 70;
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
            }
        } else {
            return 70;
        }
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == feedTableView) {
        if (feedSource) {
            return feedSource.count > 0 ? feedSource.count : 1;
        } else {
            return 1;
        }
    } else {
        return 0;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellEmptyIdentifier = @"emptyCell";
    EmptyCell *cellEmpty = [tableView dequeueReusableCellWithIdentifier:cellEmptyIdentifier];
    if (cellEmpty == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EmptyCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[EmptyCell class]])
            {
                cellEmpty = (EmptyCell *)currentObject;
                break;
            }
        }
    }
    NSString *cellIdentifier = @"feedCell";
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FeedCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[FeedCell class]])
            {
                cell = (FeedCell *)currentObject;
                break;
            }
        }
    }
    NSString *cellTwoIdentifier = @"feedTwoCell";
    FeedTwoCell *cellTwo = [tableView dequeueReusableCellWithIdentifier:cellTwoIdentifier];
    if (cellTwo == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FeedTwoCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[FeedTwoCell class]])
            {
                cellTwo = (FeedTwoCell *)currentObject;
                break;
            }
        }
    }
    NSString *cellThreeIdentifier = @"feedThreeCell";
    FeedThreeCell *cellThree = [tableView dequeueReusableCellWithIdentifier:cellThreeIdentifier];
    if (cellThree == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FeedThreeCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[FeedThreeCell class]])
            {
                cellThree = (FeedThreeCell *)currentObject;
                break;
            }
        }
    }
    NSString *cellDayIdentifier = @"dayCell";
    DayCell *cellDay = [tableView dequeueReusableCellWithIdentifier:cellDayIdentifier];
    if (cellDay == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DayCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[DayCell class]])
            {
                cellDay = (DayCell *)currentObject;
                break;
            }
        }
    }
    if (feedSource != nil && [feedSource count] > 0) {
        Feed *feed = [feedSource objectAtIndex:indexPath.row];
        if (feed.isDay) {
            [cellDay.dayLabel setText:feed.titre];
            cellDay.dayLabel.adjustsFontSizeToFitWidth = YES;
            return  cellDay;
        } else {
<<<<<<< HEAD
            if ([feed.titre length] <= 31) {
                [cell.titre setText:feed.titre];
                [cell.resume setText:feed.resume];
                [cell.source setText:feed.source];
                [cell.date setText:[self formatDate:feed.date]];
                return cell;
            } else if ([feed.titre length] <= 62) {
                [cellTwo.titre setText:feed.titre];
                [cellTwo.resume setText:feed.resume];
                [cellTwo.source setText:feed.source];
                [cellTwo.date setText:[self formatDate:feed.date]];
                return cellTwo;
            } else {
                [cellThree.titre setText:feed.titre];
                [cellThree.resume setText:feed.resume];
                [cellThree.source setText:feed.source];
                [cellThree.date setText:[self formatDate:feed.date]];
                return cellThree;
            }
=======
            cell.titre.adjustsFontSizeToFitWidth = YES;
            cell.resume.adjustsFontSizeToFitWidth = YES;
            cell.source.adjustsFontSizeToFitWidth = YES;
            cell.date.adjustsFontSizeToFitWidth = YES;
            [cell.titre setText:feed.titre];
            [cell.resume setText:feed.resume];
            [cell.source setText:feed.source];
            [cell.date setText:[self formatDate:feed.date]];
            return cell;
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
        }
    } else {
        cellEmpty.message.adjustsFontSizeToFitWidth = YES;
        [cellEmpty.message setText:@"All read, enjoy your coffee!"];
        return cellEmpty;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*Feed *feed = [feedSource objectAtIndex:indexPath.row];
     
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
     [articleView.view setFrame:CGRectMake(320, 0, articleView.view.frame.size.width, articleView.view.frame.size.height)];
     [self.view addSubview:articleView.view];
     [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:1.0];
     [UIView setAnimationDelegate:self];
     [articleView.view setFrame:CGRectMake(0, 0, articleView.view.frame.size.width, articleView.view.frame.size.height)];
     [UIView commitAnimations];
     }*/
    Feed *feed = [feedSource objectAtIndex:indexPath.row];
    if (!feed.isDay) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:feed.id forKey:@"feed"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"displayFeed" object:nil userInfo:userInfo];
    }
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
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
    [dateFormat setDateFormat:@"HH:mm"];
    dateOut = [dateFormat stringFromDate:now];
    return dateOut;
<<<<<<< HEAD
=======
=======
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
}


#pragma mark ArticleViewController
-(void)retourArticlePressed:(NSString *)id{
    if (articleView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(removeArticle)];
        [articleView.view setFrame:CGRectMake(320, 0, articleView.view.frame.size.width, articleView.view.frame.size.height)];
        [UIView commitAnimations];
    }
}

-(void)removeArticle {
    [articleView.view removeFromSuperview];
    articleView = nil;
    [articleView.view setFrame:CGRectMake(0, -1500, articleView.view.frame.size.width, articleView.view.frame.size.height)];
}

@end
