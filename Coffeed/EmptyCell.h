//
//  EmptyCell.h
//  Coffeed
//
//  Created by Maxime Pontoire on 22/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyCell : UITableViewCell {
    IBOutlet UILabel *message;
}
@property (strong, nonatomic) IBOutlet UILabel *message;

@end
