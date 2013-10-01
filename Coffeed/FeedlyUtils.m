//
//  FeedlyUtils.m
//  Coffeed
//
//  Created by CDS Transporteur on 30/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "FeedlyUtils.h"

@implementation FeedlyUtils

+(NSString *)getCode {
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/auth?client_id=%@&redirect_uri=http://localhost&response_type=code&scope=https://cloud.feedly.com/subscriptions&provider=google",clientId];
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
    NSLog(@"JSON = %@",stringXML);
    return stringXML;
}

@end
