//
//  FeedlyUtils.m
//  Coffeed
//
//  Created by CDS Transporteur on 30/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "FeedlyUtils.h"

@implementation FeedlyUtils

+(NSString *)getToken {
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/auth?client_id=%s&redirect_uri=http://localhost&response_type=code&scope=https://cloud.feedly.com/subscriptions&provider=google",clientId];
    NSMutableURLRequest *requete = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [requete setHTTPMethod:@"GET"];
    [requete setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [requete setHTTPBody:[[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding]];
    //In case of error
    NSError *error;
    NSURLResponse *response;
    NSData *result = [NSURLConnection sendSynchronousRequest:requete returningResponse:&response error:&error];
    NSLog(@"error = %@",error);
    NSLog(@"response = %@",response);
    NSLog(@"result = %@",result);
    
    NSString *stringXML = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"stringXML = %@",stringXML);
    return stringXML;
}

+(NSString *)refreshToken {
    
    [self getToken];
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/token?client_id=%s&code=%s&client_secret=%s&redirect_uri=http://localhost&grant_type=authorization_code&response_type=code&scope=https://cloud.feedly.com/subscriptions",clientId,code,clientSecret];
    NSMutableURLRequest *requete = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [requete setHTTPMethod:@"POST"];
    [requete setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [requete setHTTPBody:[[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding]];
    //In case of error
    NSError *error;
    NSURLResponse *response;
    NSData *result = [NSURLConnection sendSynchronousRequest:requete returningResponse:&response error:&error];
    NSLog(@"error = %@",error);
    NSLog(@"response = %@",response);
    NSLog(@"result = %@",result);
    
    NSString *stringXML = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"stringXML = %@",stringXML);
    return stringXML;
}

@end
