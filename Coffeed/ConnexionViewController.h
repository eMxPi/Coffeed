//
//  ConnexionViewController.h
//  Coffeed
//
<<<<<<< HEAD
//  Created by Maxime Pontoire on 01/10/13.
=======
//  Created by CDS Transporteur on 01/10/13.
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
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
