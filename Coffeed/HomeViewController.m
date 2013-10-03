
//
//  HomeViewController.m
//  Coffeed
//
//  Created by Maxime Pontoire on 19/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize accessToken;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    photoTitles = [[NSMutableArray alloc] init];
    photoSmallImageData = [[NSMutableArray alloc] init];
    photoURLsLargeImage = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view.
    imageBack = [UIImage imageNamed:@"home_background.png"];
    [self searchFlickrPhotos];
    [backgroundImage setAlpha:0.0f];
    [signInButton setHidden:TRUE];
}

-(void)viewWillAppear:(BOOL)animated {
    [self revealLogo];
}

- (void)viewDidAppear:(BOOL)animated
{
    [signInButton setHidden:TRUE];
    // try and load an existing access token from disk
    self.accessToken = [[PersistanceManager sharedPersistanceManager] getValueKey:accessTokenKey];
    
    // check if we have a valid access token before continuing otherwise obtain a token
    if (self.accessToken != nil) {
        [self displayHome];
    } else {
        [signInButton setHidden:FALSE];
    }
}



- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)extractImage:(UIImage *)image {
    float x = (image.size.width - self.view.frame.size.width*2 ) /2;
    float y = (image.size.height - self.view.frame.size.height*2 ) /2;
    x = x > 0 ? x : 0;
    y = y > 0 ? y : 0;
    CGRect rect = CGRectMake(x,y,self.view.frame.size.width*2,self.view.frame.size.height*2);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    
    return [UIImage imageWithCGImage:imageRef];
}

-(void)retrievePosition {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 10 mr
    
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0)
    {
        [locationManager startUpdatingLocation];
    } else {
        if ([CLLocationManager locationServicesEnabled] != NO && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
            [locationManager startUpdatingLocation];
        }
    }
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (newLocation == nil) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Information"
                                                          message:@"Votre localisation semble indisponible"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    } else {
        [locationManager stopUpdatingLocation];
        [self searchFlickrPhotos:@"iPhone" latitude:(float)newLocation.coordinate.latitude longitude:(float)newLocation.coordinate.longitude];
    }
}



#pragma mark -
#pragma mark Private Methods

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // Create a dictionary from the JSON string
	NSDictionary *results = [jsonString JSONValue];
	
    // Build an array from the dictionary for easy access to each entry
	NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    if ([photos count] == 0) {
        NSLog(@"No Photo");
    }
    
    // Loop through each entry in the dictionary...
	for (NSDictionary *photo in photos)
    {
        //if ([[photo objectForKey:@"ispublic"] intValue] == 1) {
        // Get title of the image
        NSString *title = [photo objectForKey:@"title"];
        
        // Save the title to the photo titles array
        [photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
        
        // Build the URL to where the image is stored (see the Flickr API)
        // In the format http://farmX.static.flickr.com/server/id/secret
        // Notice the "_s" which requests a "small" image 75 x 75 pixels
        NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        //NSLog(@"photoURLString: %@", photoURLString);
        
        // The performance (scrolling) of the table will be much better if we
        // build an array of the image data here, and then add this data as
        // the cell.image value (see cellForRowAtIndexPath:)
        //[photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
        
        // Build and save the URL to the large image so we can zoom
        // in on the image if requested
        
        photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_b.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        [photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];
        
        //NSLog(@"photoURLsLargeImage: %@\n\n", photoURLString);
        // }
	}
    
    if ([photoURLsLargeImage count] > 0) {
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            int x = arc4random() % ([photoURLsLargeImage count]-1);
            NSLog(@"Index %i:",x);
            NSURL *url = [photoURLsLargeImage objectAtIndex:x];
            NSData *data = nil;
            if (url != nil) {
                data = [[NSData alloc] initWithContentsOfURL:url];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if ( data == nil || [data length] == 9218) {
                    return;
                } else {
                    imageBack = [self extractImage:[UIImage imageWithData:data]];
                    [backgroundImage setImage:imageBack];
                    [self revealFlickr];
                }
            });
        });
    }
}

-(void)revealFlickr {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [backgroundImage setAlpha:1.0f];
    //[UIView setAnimationWillStartSelector: @selector(displayImage)];
    [UIView commitAnimations];
}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
-(void)searchFlickrPhotos:(NSString *)text latitude:(float)lat longitude:(float)lng
{
    float minL = lat - buffer;
    float maxL = lat + buffer;
    float minLat = minL < maxL ? minL : maxL;
    float maxLat = minL < maxL ? maxL : minL;
    
    float minLg = lng - buffer;
    float maxLg = lng + buffer;
    float minLon = minLg < maxLg ? minLg : maxLg;
    float maxLon = minLg < maxLg ? maxLg : minLg;
    // Build the string to call the Flickr API
	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&bbox=%f,%f,%f,%f&per_page=25&format=json&nojsoncallback=1", FlickrAPIKey, minLon, minLat, maxLon, maxLat];
    
    // Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];
    //NSLog(@"url %@", urlString);
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
-(void)searchFlickrPhotos
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&api_key=%@&group_id=%@&per_page=25&format=json&nojsoncallback=1", FlickrAPIKey, yahooGroup];
    
    // Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];
    //NSLog(@"url %@", urlString);
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}


-(void)revealLogo {
    [coffeedImageView setAlpha:0.0f];
    [coffeedImageView setFrame:CGRectMake(95, 326, coffeedImageView.frame.size.width, coffeedImageView.frame.size.height)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    [coffeedImageView setAlpha:1.0f];
    //[UIView setAnimationWillStartSelector: @selector(displayImage)];
    [coffeedImageView setFrame:CGRectMake(95, 129, coffeedImageView.frame.size.width, coffeedImageView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)displayHome {
    if ([MachineUtil isNetworkActivated]) {
        subscriptionsSource = [FeedlyUtils parseAbonnement:[FeedlyUtils getAbonnements]];
        if (!feedViewController) {
            if ([MachineUtil isHighSize]) {
                feedViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedViewController"];
            } else {
                feedViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedViewController"];
            }
        }
        feedViewController.delegate = self;
        feedViewController.imageBack = imageBack;
        feedViewController.subscriptionsSource = subscriptionsSource;
        feedViewController.feedSource = nil;
        [feedViewController.view setFrame:CGRectMake(0, 0, feedViewController.view.frame.size.width, feedViewController.view.frame.size.height)];
        [self.view addSubview:feedViewController.view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInPressed:(id)sender {
    
    // try and load an existing access token from disk
    self.accessToken = [[PersistanceManager sharedPersistanceManager] getValueKey:accessTokenKey];
    
    // check if we have a valid access token before continuing otherwise obtain a token
    if (self.accessToken == nil) {
        [self beginAuthorization];
    }
}

#pragma mark FeedViewController
-(void)fermerPressed {
    if (feedViewController) {
        [feedViewController.view removeFromSuperview];
        feedViewController = nil;
        [feedViewController.view setFrame:CGRectMake(0, -1500, feedViewController.view.frame.size.width, feedViewController.view.frame.size.height)];
    }
    [self disconnect];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark -

-(void)disconnect {
    
    [[PersistanceManager sharedPersistanceManager] saveValue:nil Key:accessTokenKey];
    [[PersistanceManager sharedPersistanceManager] saveValue:nil Key:expiresTokenKey];
    [[PersistanceManager sharedPersistanceManager] saveValue:nil Key:refreshTokenKey];
    [[PersistanceManager sharedPersistanceManager] saveValue:nil Key:dateTokenKey];
}

- (void)saveAccessTokenToDisk:(Authentification *)auth;
{
    NSString *date = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970] ];
    [[PersistanceManager sharedPersistanceManager] saveValue:auth.accessToken Key:accessTokenKey];
    [[PersistanceManager sharedPersistanceManager] saveValue:auth.expiresIn Key:expiresTokenKey];
    [[PersistanceManager sharedPersistanceManager] saveValue:auth.refreshToken Key:refreshTokenKey];
    [[PersistanceManager sharedPersistanceManager] saveValue:date Key:dateTokenKey];
}

- (void)beginAuthorization;
{
    
    if ([MachineUtil isNetworkActivated]) {
        if (!connexionView) {
            if ([MachineUtil isHighSize]) {
                connexionView = [[self storyboard] instantiateViewControllerWithIdentifier:@"connexionViewController"];
            } else {
                connexionView = [[self storyboard] instantiateViewControllerWithIdentifier:@"connexionViewController"];
            }
        }
        connexionView.delegate = self;
        connexionView.html = [FeedlyUtils getCode];
        [connexionView.view setFrame:CGRectMake(0, 0, connexionView.view.frame.size.width, connexionView.view.frame.size.height)];
        [self.view addSubview:connexionView.view];
    }
    
}

#pragma mark ConnexionViewController
-(void)returnToken:(NSString *)token {
    if (connexionView) {
        [connexionView.view removeFromSuperview];
        connexionView = nil;
        [connexionView.view setFrame:CGRectMake(0, -1500, connexionView.view.frame.size.width, connexionView.view.frame.size.height)];
    }
    if (token != nil) {
        NSString *output = [FeedlyUtils getToken:token];
        output = [output stringByReplacingOccurrencesOfString:@"{" withString:@""];
        output = [output stringByReplacingOccurrencesOfString:@"}" withString:@""];
        output = [output stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSArray *jsonObjects = [output componentsSeparatedByString:@","];
        Authentification *current = [[Authentification alloc] init];
        for (int i=0;i<[jsonObjects count];i++) {
            NSString *str = [jsonObjects objectAtIndex:i];
            NSArray *array = [str componentsSeparatedByString: @":"];
            if ([[array objectAtIndex:0] isEqualToString:@"plan"]) {
                current.plan = [array objectAtIndex:1];
            } else if ([[array objectAtIndex:0] isEqualToString:@"id"]) {
                current.identifiant = [array objectAtIndex:1];
            } else if ([[array objectAtIndex:0] isEqualToString:@"access_token"]) {
                current.accessToken = [array objectAtIndex:1];
            } else if ([[array objectAtIndex:0] isEqualToString:@"refresh_token"]) {
                current.refreshToken = [array objectAtIndex:1];
            } else if ([[array objectAtIndex:0] isEqualToString:@"expires_in"]) {
                current.expiresIn = [array objectAtIndex:1];
            } else if ([[array objectAtIndex:0] isEqualToString:@"state"]) {
                current.state = [array objectAtIndex:1];
            } else if ([[array objectAtIndex:0] isEqualToString:@"token_type"]) {
                current.tokenType = [array objectAtIndex:1];
            }
        }
        if (current.accessToken != nil) {
            accessToken = current.accessToken;
            [self saveAccessTokenToDisk:(Authentification*)current];
            NSString *output = [FeedlyUtils getProfile];
            output = [output stringByReplacingOccurrencesOfString:@"{" withString:@""];
            output = [output stringByReplacingOccurrencesOfString:@"}" withString:@""];
            output = [output stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            NSArray *jsonObjects = [output componentsSeparatedByString:@","];
            for (int i=0;i<[jsonObjects count];i++) {
                NSString *str = [jsonObjects objectAtIndex:i];
                NSArray *array = [str componentsSeparatedByString: @":"];
                if ([[array objectAtIndex:0] isEqualToString:@"givenName"]) {
                    [[PersistanceManager sharedPersistanceManager] saveValue:[array objectAtIndex:1] Key:nameTokenKey];
                    break;
                }
            }
            [self displayHome];
        }

    }
}

@end
