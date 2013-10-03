//
//  FeedlyUtils.h
//  Coffeed
//
//  Created by Maxime Pontoire on 30/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constantes.h"
#import "PersistanceManager.h"
#import "SBJSON.h"
#import "Feed.h"
#import "Abonnement.h"

@interface FeedlyUtils : NSObject {
    NSString *accesToken;
}

+(NSString *)getCode;

+(NSString *)getToken:(NSString *)token;

+(NSString *)refreshToken;

+(BOOL)hasToRefresh;

+(NSString *)getProfile;

+(NSString *)getAbonnements;

+(NSString *)getEntriesForAbonnement:(NSString *)idAbonnement;

+(void)saveToken:(NSString *)output;

+(NSMutableArray *)parseAbonnement:(NSString *)output;

+(NSMutableArray *)parseFeed:(NSString *)output;

@end
