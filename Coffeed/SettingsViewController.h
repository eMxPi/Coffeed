//
//  SettingsViewController.h
//  Coffeed
//
//  Created by Maxime Pontoire on 24/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate;
@interface SettingsViewController : UIViewController <UIGestureRecognizerDelegate> {
    id<SettingsViewControllerDelegate>__unsafe_unretained delegate;
    IBOutlet UIButton *menuButton;
    UIImage *imageBack;
    IBOutlet UIImageView *backgroundImage;
    
}
@property (nonatomic, unsafe_unretained) id<SettingsViewControllerDelegate>delegate;
@property (nonatomic, retain) UIImage *imageBack;
- (IBAction)menuPressed:(id)sender;

@end

@protocol SettingsViewControllerDelegate
-(void)retourMenuPressed;
@required
@end