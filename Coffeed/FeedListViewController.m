//
//  FeedListViewController.m
//  Coffeed
//
//  Created by Maxime Pontoire on 25/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "FeedListViewController.h"

@interface FeedListViewController ()

@end

@implementation FeedListViewController
@synthesize delegate, dateLabel, helloTitle, counterFeedText, listButton, imageButton, imageBack;

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
    // Reglages
    feedView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *downReglages = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(revealFeed)];
    downReglages.delegate = self;
    [downReglages setDirection:UISwipeGestureRecognizerDirectionUp];
    [feedView addGestureRecognizer:downReglages];
    
    feedView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *upReglages = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideFeed)];
    upReglages.delegate = self;
    [upReglages setDirection:UISwipeGestureRecognizerDirectionDown];
    [feedView addGestureRecognizer:upReglages];
    
    
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuPressed:)];
    left.delegate = self;
    [left setDirection:UISwipeGestureRecognizerDirectionLeft];
    [menuButton addGestureRecognizer:left];
    
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuPressed:)];
    right.delegate = self;
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [menuButton addGestureRecognizer:right];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayCorrection:) name:@"displayFeed" object:nil];
    
    
    isDeployed = FALSE;
    isList = TRUE;
    
    [self changeButton];
    
    // Bouchon
    feedSource = [[NSMutableArray alloc] init];
    Feed *feed1 = [[Feed alloc] init];
    feed1.titre = @"GTA Online : démarrage";
    feed1.source = @"Veendesign";
    feed1.date = @"1367539068016";
    feed1.resume = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit";
    feed1.content = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    [feedSource addObject:feed1];
    Feed *feed2 = [[Feed alloc] init];
    feed2.titre = @"JF Coppé quitte la politique";
    feed2.source = @"Le Monde";
    feed2.date = @"1380287153000";
    feed2.resume = @"Lorem 2 ipsum dolor sit amet, consectetur adipisicing elit";
    feed2.content = @"Lorem 2 ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\r\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    [feedSource addObject:feed2];
    [feedTableView reloadData];
    
    [backgroundImage setImage:imageBack];
    [contentScrollView setDelegate:self];
    imageBlurred = [imageBack stackBlur:5.0];
    imageBlurredStrong = [imageBack stackBlur:15.0];
    
    
}

-(void)makeScrollView {
    
    if (!emptyView) {
        if ([MachineUtil isHighSize]) {
            emptyView = [[self storyboard] instantiateViewControllerWithIdentifier:@"emptyViewController"];
        } else {
            emptyView = [[self storyboard] instantiateViewControllerWithIdentifier:@"emptyViewController"];
        }
    }
    [emptyView.view setFrame:CGRectMake(0, 0, 320, 350)];
    [contentScrollView addSubview:emptyView.view];
    
    if (!resumeViewController) {
        if ([MachineUtil isHighSize]) {
            resumeViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"resumeViewController"];
        } else {
            resumeViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"resumeViewController"];
        }
    }
    [resumeViewController.view setFrame:CGRectMake(0, 350, 320, 116)];
    [resumeViewController.helloText setText:@"Hello Maxime,"];
    [resumeViewController.unreadText setText:[self makeFeedText]];
    [contentScrollView addSubview:resumeViewController.view];
    
    /*if (!dayView) {
        if ([MachineUtil isHighSize]) {
            dayView = [[self storyboard] instantiateViewControllerWithIdentifier:@"dayViewController"];
        } else {
            dayView = [[self storyboard] instantiateViewControllerWithIdentifier:@"dayViewController"];
        }
    }
    [dayView.view setFrame:CGRectMake(0, 466, 320, 44)];
    [dayView.dayLabel setText:@"Today"];
    [contentScrollView addSubview:dayView.view];*/
    
    // Reformat Table Feed with Day
    [self formatFeedTable];
    if (!tableFeedView) {
        if ([MachineUtil isHighSize]) {
            tableFeedView = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedTableViewController"];
        } else {
            tableFeedView = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedTableViewController"];
        }
    }
    [tableFeedView.view setFrame:CGRectMake(0, 466, 320, 523)];
    tableFeedView.feedSource = feedSource;
    [contentScrollView addSubview:tableFeedView.view];
    contentScrollView.contentSize = CGSizeMake(320, 999);
}

-(void)formatFeedTable {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<[feedSource count]; i++) {
        Feed *feed = [feedSource objectAtIndex:i];
        [array addObject:feed];
    }
    feedSource = array;
}

-(void)changeButton {
    if (isList) {
        [listButton setImage:[UIImage imageNamed:@"navbar_liste_on.png"] forState:UIControlStateNormal];
        [imageButton setImage:[UIImage imageNamed:@"navbar_image_off.png"] forState:UIControlStateNormal];
    } else {
        [listButton setImage:[UIImage imageNamed:@"navbar_liste_off.png"] forState:UIControlStateNormal];
        [imageButton setImage:[UIImage imageNamed:@"navbar_image_on.png"] forState:UIControlStateNormal];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    // Notice that I am hard-coding the search tag at this point (@"iPhone")
    [self parseFeedText];
    [self retrievePosition];
    [self makeScrollView];
}


-(void)revealFeed {
    isDeployed = TRUE;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector: @selector(hideResume)];
    [UIView setAnimationDidStopSelector: @selector(blurImage)];
    [feedView setFrame:CGRectMake(0, 58, feedView.frame.size.width, feedView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)hideFeed {
    isDeployed = FALSE;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector: @selector(revealResume)];
    [feedView setFrame:CGRectMake(0, 535, feedView.frame.size.width, feedView.frame.size.height)];
    [UIView commitAnimations];
}
-(void)hideResume {
    [resumeView setHidden:TRUE];
}

-(void)revealResume {
    // TODO count Feed
    [self parseFeedText];
    [resumeView setHidden:FALSE];
    [self unBlurImage];
}

-(void)parseFeedText {
    [counterFeedText setText:[self makeFeedText]];
}

-(NSString *)makeFeedText {
    NSString *output = @"no new item.";
    
    if (feedSource && [feedSource count] > 0) {
        if ([feedSource count] == 1) {
            output = @"1 new item.";
        } else {
            output = [NSString stringWithFormat:@"%i new items.", [feedSource count]];
        }
    }
    return output;
}

-(void)blurImage {
    UIImage *newIma=[imageBack stackBlur:15.0];
    [backgroundImage setImage:newIma];
}

-(void)unBlurImage {
    [backgroundImage setImage:imageBack];
}

-(void)retrievePosition {
    if ([CLLocationManager locationServicesEnabled] != NO && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        [locationManager startUpdatingLocation];
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
            
            NSLog(@"photoURLString: %@", photoURLString);
            
            // The performance (scrolling) of the table will be much better if we
            // build an array of the image data here, and then add this data as
            // the cell.image value (see cellForRowAtIndexPath:)
            [photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
            
            // Build and save the URL to the large image so we can zoom
            // in on the image if requested
            
            photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            
            [photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];
            
            NSLog(@"photoURLsLareImage: %@\n\n", photoURLString);
        }
	}
    
    if ([photoURLsLargeImage count] > 0) {
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData *data = [[NSData alloc] initWithContentsOfURL:[photoURLsLargeImage objectAtIndex:0]];
            if ( data == nil ) {
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage* newImage = [UIImage imageWithData:data];
                imageBack = newImage;
                if (isDeployed) {
                    UIImage *newIma=[newImage stackBlur:15.0];
                    [backgroundImage setImage:newIma];
                } else {
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
    float minLat = lat > 0 ? lat - buffer : lat + buffer;
    float maxLat = lat > 0 ? lat + buffer : lat - buffer;
    float minLon = lng > 0 ? lng - buffer : lng + buffer;
    float maxLon = lng > 0 ? lng + buffer : lng - buffer;
    // Build the string to call the Flickr API
	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%s&bbox=%f,%f,%f,%f&per_page=1&format=json&nojsoncallback=1", FlickrAPIKey, minLon, minLat, maxLon, maxLat];
    
    // Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuPressed:(id)sender {
    [delegate retourMenuFeedPressed];
}

- (IBAction)listPressed:(id)sender {
    isList = TRUE;
    [self changeButton];
}

- (IBAction)imagePressed:(id)sender {
    isList = FALSE;
    [self changeButton];
}

- (IBAction)displayFeedPressed:(id)sender {
    [self revealFeed];
}

-(void)displayCorrection:(NSNotification *)notification {
    
    NSDictionary *dict = [notification userInfo];
    int index = [[dict objectForKey:@"feed"] intValue];
    Feed *feed = [feedSource objectAtIndex:index];
    
    if ([MachineUtil isNetworkActivated]) {
        if (!articleView) {
            if ([MachineUtil isHighSize]) {
                articleView = [[self storyboard] instantiateViewControllerWithIdentifier:@"articleViewController"];
            } else {
                articleView = [[self storyboard] instantiateViewControllerWithIdentifier:@"articleViewController"];
            }
        }
        articleView.delegate = self;
        NSMutableArray *articleSource = [[NSMutableArray alloc] init];
        [articleSource addObject:feed];
        articleView.articleSource = articleSource;
        articleView.titleArticle = feed.titre;
        articleView.text = feed.content;
        [articleView.view setFrame:CGRectMake(320, 0, articleView.view.frame.size.width, articleView.view.frame.size.height)];
        [self.view addSubview:articleView.view];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        [articleView.view setFrame:CGRectMake(0, 0, articleView.view.frame.size.width, articleView.view.frame.size.height)];
        [UIView commitAnimations];
    }
}

#pragma mark ArticleViewController
-(void)retourArticlePressed {
    if (articleView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(removeArticle)];
        [articleView.view setFrame:CGRectMake(320, 0, articleView.view.frame.size.width, articleView.view.frame.size.height)];
        [UIView commitAnimations];
    }
    [self makeScrollView];
}

-(void)removeArticle {
    [articleView.view removeFromSuperview];
    articleView = nil;
    [articleView.view setFrame:CGRectMake(0, -1500, articleView.view.frame.size.width, articleView.view.frame.size.height)];
}

#pragma mark scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint currentOffset = scrollView.contentOffset;
    if (currentOffset.y > 50) {
        [backgroundImage setImage:imageBlurred];
    } else if (currentOffset.y > 420) {
        [backgroundImage setImage:imageBlurredStrong];
    } else {
        [backgroundImage setImage:imageBack];
    }
}

@end
