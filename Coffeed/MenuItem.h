//
//  MenuItem.h
//  Coffeed
//
//  Created by Maxime Pontoire on 24/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject {
    NSString *text;
    UIImage *image;
    BOOL isHome;
    BOOL isLater;
    BOOL isDisconnect;
    BOOL isSettings;
    BOOL isSubscribe;
}
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) BOOL isHome;
@property (nonatomic) BOOL isLater;
@property (nonatomic) BOOL isDisconnect;
@property (nonatomic) BOOL isSettings;
@property (nonatomic) BOOL isSubscribe;

@end
