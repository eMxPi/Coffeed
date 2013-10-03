//
//  Abonnement.h
//  Coffeed
//
//  Created by CDS Transporteur on 03/10/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Abonnement : NSObject {
    NSString *id;
    NSString *titre;
    NSString *siteUrl;
    
}
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *titre;
@property (nonatomic, retain) NSString *siteUrl;

@end
