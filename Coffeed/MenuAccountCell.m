//
//  MenuAccountCell.m
//  Coffeed
//
//  Created by Maxime Pontoire on 24/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "MenuAccountCell.h"

@implementation MenuAccountCell
@synthesize name, imageProfil;

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
