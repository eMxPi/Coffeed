
#define FlickrAPIKey "9ec9cb53fca78af9878123868d398d81"//
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
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self revealLogo];
}



- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
        if ([[photo objectForKey:@"ispublic"] intValue] == 1) {
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
        }
	}
    
    if ([photoURLsLargeImage count] > 0) {
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            int x = arc4random() % ([photoURLsLargeImage count]-1);
            NSLog(@"Index %i:",(x-1));
            NSURL *url = [photoURLsLargeImage objectAtIndex:(x-1)];
            NSData *data = nil;
            if (url != nil) {
                data = [[NSData alloc] initWithContentsOfURL:url];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if ( data == nil || [data length] == 9218) {
                    return;
                } else {
                    UIImage* newImage = [UIImage imageWithData:data];
                    //newImage = [self imageWithImage:newImage scaledToSize:CGSizeMake(320, 568)];
                    imageBack = newImage;
                    [backgroundImage setImage:newImage];
                }
            });
        });
    }
    
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
	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%s&bbox=%f,%f,%f,%f&per_page=25&format=json&nojsoncallback=1", FlickrAPIKey, minLon, minLat, maxLon, maxLat];
    //NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&api_key=%s&gallery_id=%s&per_page=25&format=json&nojsoncallback=1", FlickrAPIKey, cubaGallery];
    
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
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&api_key=%s&gallery_id=%s&per_page=25&format=json&nojsoncallback=1", FlickrAPIKey, cubaGallery];
    
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
    [UIView setAnimationDuration:5.0];
    [UIView setAnimationDelegate:self];
    [coffeedImageView setAlpha:1.0f];
    //[UIView setAnimationWillStartSelector: @selector(displayImage)];
    [coffeedImageView setFrame:CGRectMake(95, 129, coffeedImageView.frame.size.width, coffeedImageView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)displayImage {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInPressed:(id)sender {
    if ([MachineUtil isNetworkActivated]) {
        if (!feedViewController) {
            if ([[MachineUtil machineName] isEqualToString:@"iPhone5,2"] || [[MachineUtil machineName] isEqualToString:@"iPhone6,2"]) {
                feedViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedViewController"];
            } else {
                feedViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedViewController"];
            }
        }
        feedViewController.delegate = self;
        feedViewController.imageBack = imageBack;
        [feedViewController.view setFrame:CGRectMake(0, 0, feedViewController.view.frame.size.width, feedViewController.view.frame.size.height)];
        [self.view addSubview:feedViewController.view];
    }
}

#pragma mark FeedViewController
-(void)fermerPressed {
    if (feedViewController) {
        [feedViewController.view removeFromSuperview];
        feedViewController = nil;
        [feedViewController.view setFrame:CGRectMake(0, -1500, feedViewController.view.frame.size.width, feedViewController.view.frame.size.height)];
    }
}
@end
