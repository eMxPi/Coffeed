//
//  ArticleHeaderCell.m
//  Coffeed
//
//  Created by CDS Transporteur on 27/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "ArticleHeaderCell.h"

@implementation ArticleHeaderCell
@synthesize source, titre, date;

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
