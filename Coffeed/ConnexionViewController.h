//
//  ConnexionViewController.h
//  Coffeed
//
//  Created by Maxime Pontoire on 01/10/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConnexionControllerDelegate;
@interface ConnexionViewController : UIViewController <UIWebViewDelegate> {
    id<ConnexionControllerDelegate>__unsafe_unretained delegate;
    IBOutlet UIWebView *webview;
}

@property (nonatomic, unsafe_unretained) id<ConnexionControllerDelegate>delegate;
@property (nonatomic, retain) NSString *html;

@end


@protocol ConnexionControllerDelegate
-(void)returnToken:(NSString *)token;
@required
@end
