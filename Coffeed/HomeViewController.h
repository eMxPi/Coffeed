//
//  HomeViewController.h
//  Coffeed
//
//  Created by Maxime Pontoire on 19/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "MachineUtil.h"
#import "Constantes.h"

@interface HomeViewController : UIViewController <UIGestureRecognizerDelegate, FeedViewControllerDelegate, CLLocationManagerDelegate> {
    
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIImageView *coffeedImage;
    IBOutlet UIView *coffeedImageView;
    UIImage *imageBack;
    FeedViewController *feedViewController;
    CLLocationManager *locationManager;
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)searchFlickrPhotos:(NSString *)text latitude:(float) lat longitude:(float)lng;
- (IBAction)signInPressed:(id)sender;

@end
