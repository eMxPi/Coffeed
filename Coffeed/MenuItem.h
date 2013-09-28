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
    BOOL isProfil;
    BOOL isAdd;
    BOOL isDisconnect;
    BOOL isSettings;
}
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) BOOL isProfil;
@property (nonatomic) BOOL isAdd;
@property (nonatomic) BOOL isDisconnect;
@property (nonatomic) BOOL isSettings;

@end
