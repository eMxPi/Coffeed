//
//  ResumeViewController.m
//  Coffeed
//
//  Created by Maxime Pontoire on 28/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "ResumeViewController.h"

@interface ResumeViewController ()

@end

@implementation ResumeViewController
@synthesize helloText, unreadText;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
}

@end
