//
//  SettingsViewController.m
//  Coffeed
//
//  Created by Maxime Pontoire on 24/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize delegate, imageBack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [backgroundImage setImage:imageBack];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuPressed:)];
    left.delegate = self;
    [left setDirection:UISwipeGestureRecognizerDirectionLeft];
    [menuButton addGestureRecognizer:left];
    
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuPressed:)];
    right.delegate = self;
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [menuButton addGestureRecognizer:right];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuPressed:(id)sender {
    [delegate retourMenuPressed];
}
@end
