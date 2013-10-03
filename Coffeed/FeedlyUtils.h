//
//  FeedlyUtils.h
//  Coffeed
//
<<<<<<< HEAD
//  Created by Maxime Pontoire on 30/09/13.
=======
<<<<<<< HEAD
//  Created by CDS Transporteur on 30/09/13.
=======
//  Created by Maxime Pontoire on 30/09/13.
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constantes.h"
<<<<<<< HEAD
#import "PersistanceManager.h"
#import "SBJSON.h"
#import "Feed.h"
#import "Abonnement.h"

=======

<<<<<<< HEAD
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
@interface FeedlyUtils : NSObject {
    NSString *accesToken;
}

+(NSString *)getCode;

+(NSString *)getToken:(NSString *)token;

<<<<<<< HEAD
+(NSString *)refreshToken;

+(BOOL)hasToRefresh;

+(NSString *)getProfile;

+(NSString *)getAbonnements;

+(NSString *)getEntriesForAbonnement:(NSString *)idAbonnement;

+(void)saveToken:(NSString *)output;

+(NSMutableArray *)parseAbonnement:(NSString *)output;

+(NSMutableArray *)parseFeed:(NSString *)output;
=======
+(NSString *)refreshToken:(NSString *)token;
=======
@interface FeedlyUtils : NSObject

+(NSString *)getToken;

+(NSString *)refreshToken;
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442

@end
