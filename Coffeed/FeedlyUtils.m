//
//  FeedlyUtils.m
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

#import "FeedlyUtils.h"

@implementation FeedlyUtils

<<<<<<< HEAD
+(NSString *)getCode {
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/auth?client_id=%@&redirect_uri=http://localhost&response_type=code&scope=https://cloud.feedly.com/subscriptions&provider=google",clientId];
=======
<<<<<<< HEAD
+(NSString *)getCode {
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/auth?client_id=%@&redirect_uri=http://localhost&response_type=code&scope=https://cloud.feedly.com/subscriptions&provider=google",clientId];
=======
+(NSString *)getToken {
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/auth?client_id=%s&redirect_uri=http://localhost&response_type=code&scope=https://cloud.feedly.com/subscriptions&provider=google",clientId];
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
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
=======
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
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
    
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


<<<<<<< HEAD
+(NSString *)refreshToken
{
    
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/auth/token?client_id=%@&refresh_token=%@&client_secret=%@&grant_type=refresh_token",clientId,[[PersistanceManager sharedPersistanceManager] getValueKey:refreshTokenKey],clientSecret];
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

+(NSString *)getProfile
{
    if ([self hasToRefresh]) {
        [self saveToken:[self refreshToken]];
    }
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/profile"];
    NSMutableURLRequest *requete = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [requete setHTTPMethod:@"GET"];
    NSLog(@"token %@", [[PersistanceManager sharedPersistanceManager] getValueKey:accessTokenKey]);
    [requete setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [requete addValue:[[PersistanceManager sharedPersistanceManager] getValueKey:accessTokenKey] forHTTPHeaderField:@"Authorization"];
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

+(NSString *)getAbonnements
{
    if ([self hasToRefresh]) {
        [self saveToken:[self refreshToken]];
    }
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/subscriptions"];
    NSMutableURLRequest *requete = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [requete setHTTPMethod:@"GET"];
    [requete setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    //NSLog(@"token %@", [[PersistanceManager sharedPersistanceManager] getValueKey:accessTokenKey]);
    [requete addValue:[[PersistanceManager sharedPersistanceManager] getValueKey:accessTokenKey] forHTTPHeaderField:@"Authorization"];
    [requete setHTTPBody:[[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding]];
    //In case of error
    NSError *error;
    NSURLResponse *response;
    NSData *result = [NSURLConnection sendSynchronousRequest:requete returningResponse:&response error:&error];
    NSLog(@"error = %@",error);
    //NSLog(@"response = %@",response);
    //NSLog(@"result = %@",result);
    
    NSString *stringXML = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"JSON = %@",stringXML);
    return stringXML;
}

+(NSString *)getEntriesForAbonnement:(NSString *)idAbonnement {
    if ([self hasToRefresh]) {
        [self saveToken:[self refreshToken]];
    }
    NSString *urlString = [NSString stringWithFormat:@"https://sandbox.feedly.com/v3/streams/contents?streamId=%@",idAbonnement];
    NSMutableURLRequest *requete = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [requete setHTTPMethod:@"GET"];
    [requete setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [requete addValue:[[PersistanceManager sharedPersistanceManager] getValueKey:accessTokenKey] forHTTPHeaderField:@"Authorization"];
=======
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
>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
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
    return stringXML;
}

+(BOOL)hasToRefresh {
    BOOL output = TRUE;
    int date = [[[PersistanceManager sharedPersistanceManager] getValueKey:dateTokenKey] intValue];
    int expires = [[[PersistanceManager sharedPersistanceManager] getValueKey:expiresTokenKey] intValue];
    double currentDate = round([[NSDate date] timeIntervalSince1970]);
    if (date+expires < currentDate) {
        output = FALSE;
    }
    return output;
}

+(void)saveToken:(NSString *)output {
    NSString *date = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    output = [output stringByReplacingOccurrencesOfString:@"{" withString:@""];
    output = [output stringByReplacingOccurrencesOfString:@"}" withString:@""];
    output = [output stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSArray *jsonObjects = [output componentsSeparatedByString:@","];
    for (int i=0;i<[jsonObjects count];i++) {
        NSString *str = [jsonObjects objectAtIndex:i];
        NSArray *array = [str componentsSeparatedByString: @":"];
        if ([[array objectAtIndex:0] isEqualToString:@"access_token"]) {
            [[PersistanceManager sharedPersistanceManager] saveValue:[array objectAtIndex:1] Key:accessTokenKey];
        } else if ([[array objectAtIndex:0] isEqualToString:@"expires_in"]) {
            [[PersistanceManager sharedPersistanceManager] saveValue:[array objectAtIndex:1] Key:expiresTokenKey];
        }
    }
    [[PersistanceManager sharedPersistanceManager] saveValue:date Key:dateTokenKey];
}

+(NSMutableArray *)parseAbonnement:(NSString *)output {
    NSMutableArray *arrayOut = [[NSMutableArray alloc] init];
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSArray *jsonObjects = [jsonParser objectWithString:output];
    for (NSDictionary *dict in jsonObjects) {
        //name, number, address, fullAddress, lat, lng, bonus, open, bikes, slots, total, detail, displayed
        Abonnement *current = [[Abonnement alloc] init];
        [arrayOut addObject:current];
    }
    return arrayOut;
}

+(NSMutableArray *)parseFeed:(NSString *)output {
    NSMutableArray *arrayOut = [[NSMutableArray alloc] init];
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSArray *jsonObjects = [jsonParser objectWithString:output];
    for (NSDictionary *dict in jsonObjects) {
        //name, number, address, fullAddress, lat, lng, bonus, open, bikes, slots, total, detail, displayed
        Feed *current = [[Feed alloc] init];
        [arrayOut addObject:current];
    }
    return arrayOut;
}

=======
<<<<<<< HEAD
    NSLog(@"JSON = %@",stringXML);
=======
    NSLog(@"stringXML = %@",stringXML);
>>>>>>> ffeea90565904719e0cc4f0f70f9b9df4b16a7d0
    return stringXML;
}

>>>>>>> b1a0f7a4f2baefd2e7caf3a522427a2dc0487442
@end
