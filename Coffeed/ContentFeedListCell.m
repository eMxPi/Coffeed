//
//  ContentFeedListCell.m
//  Coffeed
//
//  Created by Maxime Pontoire on 28/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "ContentFeedListCell.h"

@implementation ContentFeedListCell
@synthesize feedTableView, feedSource;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark Table view methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == feedTableView) {
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
    if (tableView == feedTableView) {
        return feedSource.count > 0 ? feedSource.count : 1;
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
    if (feedSource != nil && [feedSource count] > 0) {
        cell.titre.adjustsFontSizeToFitWidth = YES;
        cell.resume.adjustsFontSizeToFitWidth = YES;
        cell.source.adjustsFontSizeToFitWidth = YES;
        Feed *feed = [feedSource objectAtIndex:indexPath.row];
        [cell.titre setText:feed.titre];
        [cell.resume setText:feed.resume];
        [cell.source setText:feed.source];
        return cell;
    } else {
        cellEmpty.message.adjustsFontSizeToFitWidth = YES;
        [cellEmpty.message setText:@"All read, enjoy your coffee!"];
        return cellEmpty;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:indexPath.row] forKey:@"feed"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"displayFeed" object:nil userInfo:userInfo];
    
}


#pragma mark ArticleViewController
-(void)retourArticlePressed {
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
