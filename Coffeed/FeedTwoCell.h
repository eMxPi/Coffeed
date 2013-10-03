//
//  FeedTwoCell.h
//  Coffeed
//
//  Created by Maxime Pontoire on 03/10/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTwoCell : UITableViewCell {
    IBOutlet UILabel *source;
    IBOutlet UILabel *titre;
    IBOutlet UILabel *resume;
    IBOutlet UILabel *date;
    
}
@property (nonatomic, retain) IBOutlet UILabel *source;
@property (nonatomic, retain) IBOutlet UILabel *titre;
@property (nonatomic, retain) IBOutlet UILabel *resume;
@property (nonatomic, retain) IBOutlet UILabel *date;

@end
