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
#import "ConnexionViewController.h"
#import "SBJSON.h"
#import "Authentification.h"
<<<<<<< HEAD
#import "PersistanceManager.h"
#import "Abonnement.h"
=======
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442

@interface HomeViewController : UIViewController <UIGestureRecognizerDelegate, FeedViewControllerDelegate, CLLocationManagerDelegate, ConnexionControllerDelegate> {
    
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIImageView *coffeedImage;
    IBOutlet UIView *coffeedImageView;
    IBOutlet UIButton *signInButton;
    UIImage *imageBack;
    FeedViewController *feedViewController;
    CLLocationManager *locationManager;
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
    ConnexionViewController *connexionView;
<<<<<<< HEAD
    NSMutableArray *subscriptionsSource;
=======
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)searchFlickrPhotos:(NSString *)text latitude:(float) lat longitude:(float)lng;
- (IBAction)signInPressed:(id)sender;

@property (nonatomic, retain) NSString *accessToken;

@end
