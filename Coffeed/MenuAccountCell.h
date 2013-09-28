//
//  MenuAccountCell.h
//  Coffeed
//
//  Created by Maxime Pontoire on 24/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuAccountCell : UITableViewCell {
    IBOutlet UILabel *name;
    IBOutlet UIImageView *imageProfil;
}
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *imageProfil;

@end
