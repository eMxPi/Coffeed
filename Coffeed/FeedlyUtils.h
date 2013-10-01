//
//  FeedlyUtils.h
//  Coffeed
//
<<<<<<< HEAD
//  Created by CDS Transporteur on 30/09/13.
=======
//  Created by Maxime Pontoire on 30/09/13.
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constantes.h"

<<<<<<< HEAD
@interface FeedlyUtils : NSObject {
    NSString *accesToken;
}

+(NSString *)getCode;

+(NSString *)getToken:(NSString *)token;

+(NSString *)refreshToken:(NSString *)token;
=======
@interface FeedlyUtils : NSObject

+(NSString *)getToken;

+(NSString *)refreshToken;
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0

@end
