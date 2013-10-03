//
//  FeedThreeCell.m
//  Coffeed
//
//  Created by Maxime Pontoire on 03/10/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "FeedThreeCell.h"

@implementation FeedThreeCell
@synthesize titre, source, resume, date;

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

@end
