//
//  ConnexionViewController.m
//  Coffeed
//
//  Created by Maxime Pontoire on 01/10/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "ConnexionViewController.h"

@interface ConnexionViewController ()

@end

@implementation ConnexionViewController
@synthesize delegate, html;

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
    [webview loadHTMLString:html baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark WebView
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *strRequestURL = [[request URL] absoluteString];
    NSLog(@"request %@", strRequestURL);
    if ([strRequestURL rangeOfString:@"code"].location != NSNotFound && [strRequestURL rangeOfString:@"http://localhost/"].location != NSNotFound) {
        
        NSString *token = [strRequestURL substringFromIndex:([strRequestURL rangeOfString:@"code="].location+5)];
        token = [token substringToIndex:[token rangeOfString:@"&state="].location];
        [delegate returnToken:token];
        return FALSE;
    }
        return TRUE;
}

@end
