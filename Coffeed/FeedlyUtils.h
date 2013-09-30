//
//  FeedlyUtils.h
//  Coffeed
//
//  Created by CDS Transporteur on 30/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constantes.h"

@interface FeedlyUtils : NSObject

+(NSString *)getToken;

+(NSString *)refreshToken;

@end
