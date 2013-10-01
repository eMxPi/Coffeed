//
//  Feed.h
//  Coffeed
//
//  Created by Maxime Pontoire on 22/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject {
    NSString *titre;
    NSString *source;
    NSString *resume;
    NSString *content;
    NSString *date;
    NSString *url;
    BOOL isDay;
    NSString *id;
}
@property (nonatomic, retain) NSString *titre;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSString *resume;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *id;
@property (nonatomic) BOOL isDay;

@end
