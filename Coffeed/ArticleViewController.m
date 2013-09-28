//
//  ArticleViewController.m
//  Coffeed
//
//  Created by Maxime Pontoire on 26/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController
@synthesize delegate, titleArticle, text, articleSource;

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
    [articleTableView setDelegate:self];
    [articleTableView setDataSource:self];
    
    self.view.userInteractionEnabled = YES;
    articleTableView.userInteractionEnabled = YES;
    topView.userInteractionEnabled = YES;
    bottomView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *downReglages = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(revealBar)];
    downReglages.delegate = self;
    [downReglages setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:downReglages];
    [articleTableView addGestureRecognizer:downReglages];
    [topView addGestureRecognizer:downReglages];
    [bottomView addGestureRecognizer:downReglages];
    
    UISwipeGestureRecognizer *upReglages = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideBar)];
    upReglages.delegate = self;
    [upReglages setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:upReglages];
    [articleTableView addGestureRecognizer:upReglages];
    [topView addGestureRecognizer:upReglages];
    [bottomView addGestureRecognizer:upReglages];
    
    UISwipeGestureRecognizer *leftReglages = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(retourSwipe)];
    leftReglages.delegate = self;
    [leftReglages setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:leftReglages];
    [articleTableView addGestureRecognizer:leftReglages];
    [topView addGestureRecognizer:leftReglages];
    [bottomView addGestureRecognizer:leftReglages];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    precY = articleTableView.contentOffset;
    isStart = TRUE;
    isAnimated = FALSE;
}

-(void)retourSwipe {
    [delegate retourArticlePressed];
}

- (IBAction)backPressed:(id)sender {
    [delegate retourArticlePressed];
}

-(void)revealBar {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAnimate)];
    [UIView setAnimationDidStopSelector:@selector(endAnimate)];
    [topView setFrame:CGRectMake(0, 20, topView.frame.size.width, topView.frame.size.height)];
    [articleTableView setFrame:CGRectMake(0, 65, articleTableView.frame.size.width, articleTableView.frame.size.height)];
    [bottomView setFrame:CGRectMake(0, 523, bottomView.frame.size.width, bottomView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)hideBar {
    isStart = FALSE;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAnimate)];
    [UIView setAnimationDidStopSelector:@selector(endAnimate)];
    [topView setFrame:CGRectMake(0, -70, topView.frame.size.width, topView.frame.size.height)];
    [articleTableView setFrame:CGRectMake(0, 20, articleTableView.frame.size.width, articleTableView.frame.size.height)];
    [bottomView setFrame:CGRectMake(0, 1136, bottomView.frame.size.width, bottomView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)startAnimate {
    isAnimated = TRUE;
}

-(void)endAnimate {
    isAnimated = FALSE;
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
    [dateFormat setDateFormat:@"MM/dd/yyyy HH:mm"];
    dateOut = [dateFormat stringFromDate:now];
    return dateOut;
}

#pragma mark Table view methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == articleTableView) {
        return 400;
    } else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == articleTableView) {
        return 70;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *cellHeaderIdentifier = @"headerCell";
    ArticleHeaderCell *headerCell = [articleTableView dequeueReusableCellWithIdentifier:cellHeaderIdentifier];
    if (headerCell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ArticleHeaderCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[ArticleHeaderCell class]])
            {
                headerCell = (ArticleHeaderCell *)currentObject;
                break;
            }
        }
    }
    
    Feed *feed = [articleSource objectAtIndex:0];
    [headerCell.titre setText:feed.titre];
    [headerCell.source setText:feed.source];
    [headerCell.date setText:[self formatDate:feed.date]];
    return headerCell;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellArticleIdentifier = @"articleCell";
    ArticleTextCell *cellArticle = [tableView dequeueReusableCellWithIdentifier:cellArticleIdentifier];
    if (cellArticle == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ArticleTextCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[ArticleTextCell class]])
            {
                cellArticle = (ArticleTextCell *)currentObject;
                break;
            }
        }
    }
    Feed *feed = [articleSource objectAtIndex:0];
    [cellArticle.text setText:feed.content];
    [cellArticle.text sizeToFit];
    return cellArticle;
}

#pragma mark scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint currentOffset = scrollView.contentOffset;
    
    if (currentOffset.y > precY.y)
    {
        // Downward
        if (!isAnimated) {
            [self hideBar];
        }
    }
    else
    {
        // Upward
        //if (currentOffset.y > 0) {
        if (!isAnimated || isStart) {
            [self revealBar];
        }
        //}
    }
    precY = currentOffset;
}
@end
