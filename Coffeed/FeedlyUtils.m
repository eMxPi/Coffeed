//
//  FeedlyUtils.m
//  Coffeed
//
<<<<<<< HEAD
//  Created by CDS Transporteur on 30/09/13.
=======
//  Created by Maxime Pontoire on 30/09/13.
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "FeedlyUtils.h"

@implementation FeedlyUtils

<<<<<<< HEAD
+(NSString *)getCode {
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/auth?client_id=%@&redirect_uri=http://localhost&response_type=code&scope=https://cloud.feedly.com/subscriptions&provider=google",clientId];
=======
+(NSString *)getToken {
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/auth?client_id=%s&redirect_uri=http://localhost&response_type=code&scope=https://cloud.feedly.com/subscriptions&provider=google",clientId];
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
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

<<<<<<< HEAD
+(NSString *)getToken:(NSString *)token {
    /*NSString *code = nil;
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/token?code=%@&client_id=%@&client_secret=%@&redirect_uri=%@&state=%@&grant_type=%@",
                           
                           token, clientId, clientSecret, @"http://localhost", @"token", @"authorization_code"];
    
    
    
    NSData *postData = [@"{}" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = postData;
    
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            
            // handle error
            
        } else {
            
            NSString *code = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"==>>>>>>>>>>Token ,%@", code);
        }
        
    }];*/
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/token?client_id=%@&code=%@&client_secret=%@&redirect_uri=http://localhost&grant_type=authorization_code&state=grant",clientId,token,clientSecret];
    NSMutableURLRequest *requete = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [requete setHTTPMethod:@"POST"];
    [requete setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [requete setHTTPBody:[[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding]];
    //In case of error
    NSError *error;
    NSURLResponse *response;
    NSData *result = [NSURLConnection sendSynchronousRequest:requete returningResponse:&response error:&error];
    NSLog(@"error = %@",error);
    NSLog(@"response = %@",response);
    NSLog(@"result = %@",result);
    
    NSString *stringXML = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"JSON = %@",stringXML);
    return stringXML;
}


+(NSString *)refreshToken:(NSString *)token
{
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/token?client_id=%@&code=%@&client_secret=%@&redirect_uri=http://localhost&grant_type=authorization_code&response_type=code&scope=https://cloud.feedly.com/subscriptions",clientId,token,clientSecret];
=======
+(NSString *)refreshToken {
    
    [self getToken];
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/token?client_id=%s&code=%s&client_secret=%s&redirect_uri=http://localhost&grant_type=authorization_code&response_type=code&scope=https://cloud.feedly.com/subscriptions",clientId,code,clientSecret];
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
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
<<<<<<< HEAD
    NSLog(@"JSON = %@",stringXML);
=======
    NSLog(@"stringXML = %@",stringXML);
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
    return stringXML;
}

@end
