//
//  FeedViewController.m
//  Coffeed
//
//  Created by Maxime Pontoire on 19/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "FeedViewController.h"


@interface FeedViewController ()

@end

@implementation FeedViewController
@synthesize delegate, imageBack, feedSource, subscriptionsSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [menuTableView setDataSource:self];
    [menuTableView setDelegate:self];
    
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
    
    // Menu left
    [darkView setAlpha:0.6f];
    UIImage *newIma=[imageBack stackBlur:15.0];
    [backgroundMenuImage setImage:newIma];
    
    isDeployed = FALSE;
    isMenuDisplayed = FALSE;
    isImage = FALSE;
    
    // Bouchon
    /*feedSource = [[NSMutableArray alloc] init];
    Feed *feed1 = [[Feed alloc] init];
    feed1.titre = @"GTA Online : démarrage";
    feed1.source = @"Veendesign";
    feed1.resume = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit";
    [feedSource addObject:feed1];
    Feed *feed2 = [[Feed alloc] init];
    feed2.titre = @"JF Coppé quitte la politique";
    feed2.source = @"Le Monde";
    feed2.resume = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit";
    [feedSource addObject:feed2];
    [feedTableView reloadData];*/
    
    menuSource = [[NSMutableArray alloc] init];
    
    // Fake Profil item
    MenuItem *home = [[MenuItem alloc] init];
    home.text = @"Home";
    home.image = [UIImage imageNamed:@"menu_ic_home_on.png"];
    home.isLater = FALSE;
    home.isHome = TRUE;
    home.isDisconnect = FALSE;
    home.isSettings = FALSE;
    [menuSource addObject:home];
    
    // ADD item
    MenuItem *add = [[MenuItem alloc] init];
    add.text = @"Saved For Later";
<<<<<<< HEAD
    add.image = [UIImage imageNamed:@"menu_ic_saved_off.png"];
    add.isLater = TRUE;
    add.isHome = FALSE;
=======
<<<<<<< HEAD
    add.image = [UIImage imageNamed:@"menu_ic_saved_off.png"];
    add.isLater = TRUE;
    add.isHome = FALSE;
=======
    add.image = [UIImage imageNamed:@"menu_ic_add.png"];
    add.isAdd = TRUE;
    add.isProfil = FALSE;
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
    add.isDisconnect = FALSE;
    add.isSettings = FALSE;
    add.isSubscribe = FALSE;
    [menuSource addObject:add];
    
    
    // Suscribe item
    MenuItem *suscribe = [[MenuItem alloc] init];
    suscribe.text = @"Subscriptions";
    suscribe.image = [UIImage imageNamed:@"menu_ic_subscriptions_off.png"];
    suscribe.isLater = FALSE;
    suscribe.isHome = FALSE;
    suscribe.isDisconnect = FALSE;
    suscribe.isSettings = FALSE;
    suscribe.isSubscribe = TRUE;
    [menuSource addObject:suscribe];
    
    // Settings item
    MenuItem *settings = [[MenuItem alloc] init];
    settings.text = @"Settings";
    settings.image = [UIImage imageNamed:@"menu_ic_settings_off.png"];
    settings.isLater = FALSE;
    settings.isHome = FALSE;
    settings.isDisconnect = FALSE;
    settings.isSettings = TRUE;
    settings.isSubscribe = FALSE;
    [menuSource addObject:settings];
    // Disconnect item
    MenuItem *disconnect = [[MenuItem alloc] init];
    disconnect.text = @"Logout";
    disconnect.image = [UIImage imageNamed:@"menu_ic_logout_off.png"];
    disconnect.isLater = FALSE;
    disconnect.isHome = FALSE;
    disconnect.isDisconnect = TRUE;
    disconnect.isSettings = FALSE;
    disconnect.isSubscribe = FALSE;
    [menuSource addObject:disconnect];
    [menuTableView reloadData];
    
    // Charge vue profil par défaut
    if (!feedListViewController) {
        if ([MachineUtil isHighSize]) {
            feedListViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedListViewController"];
        } else {
            feedListViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedListViewController"];
        }
    }
    feedListViewController.delegate = self;
    feedListViewController.imageBack = imageBack;
    feedListViewController.subscriptionsSource = subscriptionsSource;
    [feedListViewController.view setFrame:CGRectMake(0, 0, feedListViewController.view.frame.size.width, feedListViewController.view.frame.size.height)];
    [rightView addSubview:feedListViewController.view];
    
}

-(void)viewWillAppear:(BOOL)animated {
    // Notice that I am hard-coding the search tag at this point (@"iPhone")
    [self parseFeedText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [countFeedText setText:[self makeFeedText]];
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

- (IBAction)menuPressed:(id)sender {
    if (!isMenuDisplayed) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        //[UIView setAnimationWillStartSelector: @selector(hideResume)];
        //[UIView setAnimationDidStopSelector: @selector(blurImage)];
        [rightView setFrame:CGRectMake(240, 112, rightView.frame.size.width, rightView.frame.size.height-reduceSizeView)];
        [rightView setClipsToBounds:TRUE];
        [UIView commitAnimations];
        isMenuDisplayed = TRUE;
        
    } else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        //[UIView setAnimationWillStartSelector: @selector(hideResume)];
        //[UIView setAnimationDidStopSelector: @selector(blurImage)];
        [rightView setFrame:CGRectMake(0, 0, rightView.frame.size.width, rightView.frame.size.height+reduceSizeView)];
        [UIView commitAnimations];
        isMenuDisplayed = FALSE;
    }
}

-(UIImageView*)circleImage:(UIImage*)image {
    image = [self imageWithImage:image scaledToSize:CGSizeMake(24, 24)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.layer.cornerRadius = image.size.width / 2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imageView.layer.borderWidth = 1.0;
    return imageView;
}

-(UIImageView*)circleImageView:(UIImageView*)imageView {
    UIImage *image = [UIImage imageNamed:@"profil.png"];
    imageView.layer.cornerRadius = image.size.width / 2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imageView.layer.borderWidth = 1.0;
    [imageView setFrame:CGRectMake(0, 0, 24, 24)];
    [imageView setClipsToBounds:YES];
    return imageView;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark Table view methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == menuTableView) {
        return 40;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == menuTableView) {
        return menuSource.count > 0 ? menuSource.count : 1;
    } else {
        return 0;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellMenuIdentifier = @"menuAccountCell";
    MenuAccountCell *cellMenu = [tableView dequeueReusableCellWithIdentifier:cellMenuIdentifier];
    if (cellMenu == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MenuAccountCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[MenuAccountCell class]])
            {
                cellMenu = (MenuAccountCell *)currentObject;
                break;
            }
        }
    }
    NSString *cellEmptyIdentifier = @"emptyCell";
    EmptyCell *cellEmpty = [tableView dequeueReusableCellWithIdentifier:cellEmptyIdentifier];
    if (cellEmpty == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EmptyCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[EmptyCell class]])
            {
                cellEmpty = (EmptyCell *)currentObject;
                break;
            }
        }
    }
    NSString *cellIdentifier = @"feedCell";
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FeedCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[FeedCell class]])
            {
                cell = (FeedCell *)currentObject;
                break;
            }
        }
    }
    if (menuSource != nil && [menuSource count] > 0) {
        cellMenu.name.adjustsFontSizeToFitWidth = YES;
        MenuItem *item = [menuSource objectAtIndex:indexPath.row];
        [cellMenu.name setText:item.text];
        [cellMenu.imageProfil setImage:item.image];
        return cellMenu;
    } else {
        
        cellEmpty.message.adjustsFontSizeToFitWidth = YES;
        [cellEmpty.message setText:@"Empty"];
        return cellEmpty;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == menuTableView) {
        isMenuDisplayed = FALSE;
        MenuItem *item = [menuSource objectAtIndex:indexPath.row];
        
        if (item.isSettings) {
            if ([MachineUtil isNetworkActivated]) {
                if (feedListViewController) {
                    [feedListViewController.view removeFromSuperview];
                    feedListViewController = nil;
                    [feedListViewController.view setFrame:CGRectMake(0, -1500, feedListViewController.view.frame.size.width, feedListViewController.view.frame.size.height)];
                }
                if (!settingsViewController) {
                    if ([MachineUtil isHighSize]) {
                        settingsViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"settingsViewController"];
                    } else {
                        settingsViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"settingsViewController"];
                    }
                }
                settingsViewController.delegate = self;
                settingsViewController.imageBack = imageBack;
                [settingsViewController.view setFrame:CGRectMake(0, 0, settingsViewController.view.frame.size.width, settingsViewController.view.frame.size.height)];
                [rightView addSubview:settingsViewController.view];
            }
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationDelegate:self];
            [rightView setFrame:CGRectMake(0, 0, rightView.frame.size.width, rightView.frame.size.height+reduceSizeView)];
            [UIView commitAnimations];
        } else if (item.isHome) {
            if (settingsViewController) {
                [settingsViewController.view removeFromSuperview];
                settingsViewController = nil;
                [settingsViewController.view setFrame:CGRectMake(0, -1500, settingsViewController.view.frame.size.width, settingsViewController.view.frame.size.height)];
            }
            if ([MachineUtil isNetworkActivated]) {
                if (!feedListViewController) {
                    if ([MachineUtil isHighSize]) {
                        feedListViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedListViewController"];
                    } else {
                        feedListViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedListViewController"];
                    }
                }
                feedListViewController.delegate = self;
                feedListViewController.imageBack = imageBack;
                feedListViewController.subscriptionsSource = subscriptionsSource;
                [feedListViewController.view setFrame:CGRectMake(0, 0, feedListViewController.view.frame.size.width, feedListViewController.view.frame.size.height)];
                [rightView addSubview:feedListViewController.view];
            }
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationDelegate:self];
            [rightView setFrame:CGRectMake(0, 0, rightView.frame.size.width, rightView.frame.size.height+reduceSizeView)];
            [UIView commitAnimations];
        } else if (item.isDisconnect) {
            
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Disconnect ?"
                                                              message:@"Do you really want to disconnect ?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:@"OK", nil];
            [message show];
        }
        [self changeImageMenu:indexPath.row];
        [menuTableView reloadData];
    }
}

-(void)changeImageMenu:(int)index {
    for (int i=0; i<[menuSource count]; i++) {
        MenuItem *current = [menuSource objectAtIndex:i];
        if (current.isHome) {
            current.image = [UIImage imageNamed:@"menu_ic_home_off.png"];
            if (index == i) {
                current.image = [UIImage imageNamed:@"menu_ic_home_on.png"];
            }
        } else if (current.isLater) {
            current.image = [UIImage imageNamed:@"menu_ic_saved_off.png"];
            if (index == i) {
                current.image = [UIImage imageNamed:@"menu_ic_saved_on.png"];
<<<<<<< HEAD
            }
        } else if (current.isSettings) {
            current.image = [UIImage imageNamed:@"menu_ic_settings_off.png"];
            if (index == i) {
                current.image = [UIImage imageNamed:@"menu_ic_settings_on.png"];
            }
        } else if (current.isDisconnect) {
            current.image = [UIImage imageNamed:@"menu_ic_logout_off.png"];
            if (index == i) {
                current.image = [UIImage imageNamed:@"menu_ic_logout_on.png"];
            }
        } else if (current.isSubscribe) {
            current.image = [UIImage imageNamed:@"menu_ic_subscriptions_off.png"];
            if (index == i) {
                current.image = [UIImage imageNamed:@"menu_ic_subscriptions_on.png"];
            }
        }
        [menuSource replaceObjectAtIndex:i withObject:current];
    }
}


#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (settingsViewController) {
            [settingsViewController.view removeFromSuperview];
            settingsViewController = nil;
            [settingsViewController.view setFrame:CGRectMake(0, -1500, settingsViewController.view.frame.size.width, settingsViewController.view.frame.size.height)];
        }
        if (feedListViewController) {
            [feedListViewController.view removeFromSuperview];
            feedListViewController = nil;
            [feedListViewController.view setFrame:CGRectMake(0, -1500, feedListViewController.view.frame.size.width, feedListViewController.view.frame.size.height)];
        }
=======
            }
        } else if (current.isSettings) {
            current.image = [UIImage imageNamed:@"menu_ic_settings_off.png"];
            if (index == i) {
                current.image = [UIImage imageNamed:@"menu_ic_settings_on.png"];
            }
        } else if (current.isDisconnect) {
            current.image = [UIImage imageNamed:@"menu_ic_logout_off.png"];
            if (index == i) {
                current.image = [UIImage imageNamed:@"menu_ic_logout_on.png"];
            }
        }
        [menuSource replaceObjectAtIndex:i withObject:current];
    }
}


#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (settingsViewController) {
            [settingsViewController.view removeFromSuperview];
            settingsViewController = nil;
            [settingsViewController.view setFrame:CGRectMake(0, -1500, settingsViewController.view.frame.size.width, settingsViewController.view.frame.size.height)];
        }
        if (feedListViewController) {
            [feedListViewController.view removeFromSuperview];
            feedListViewController = nil;
            [feedListViewController.view setFrame:CGRectMake(0, -1500, feedListViewController.view.frame.size.width, feedListViewController.view.frame.size.height)];
        }
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
        [delegate fermerPressed];
    }
}

#pragma mark SettingsViewController
-(void)retourMenuPressed {
    [self menuPressed:nil];
}


#pragma mark FeedListViewController
-(void)retourMenuFeedPressed {
    [self menuPressed:nil];
}


@end
