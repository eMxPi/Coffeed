//
//  Authentification.h
//  Coffeed
//
//  Created by Maxime Pontoire on 01/10/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Authentification : NSObject {
    NSString *identifiant;
    NSString *accessToken;
    NSString *refreshToken;
    NSString *expiresIn;
    NSString *tokenType;
    NSString *plan;
    NSString *state;
}
@property (nonatomic,retain) NSString *identifiant;
@property (nonatomic,retain) NSString *accessToken;
@property (nonatomic,retain) NSString *refreshToken;
@property (nonatomic,retain) NSString *expiresIn;
@property (nonatomic,retain) NSString *tokenType;
@property (nonatomic,retain) NSString *plan;
@property (nonatomic,retain) NSString *state;

@end
