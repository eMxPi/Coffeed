//
//  MachineUtil.m
//  Coffeed
//
//  Created by Maxime Pontoire on 19/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "sys/utsname.h"
#import "MachineUtil.h"

@implementation MachineUtil

/**
 * Retourne le type de device
 */
+(NSString*)machineName {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}
+(BOOL)isHighSize {
    return ([[self machineName] isEqualToString:@"iPhone5,1"]  || [[self machineName] isEqualToString:@"iPhone5,2"]
        || [[self machineName] isEqualToString:@"iPhone5,3"] || [[self machineName] isEqualToString:@"iPhone5,4"]
            || [[self machineName] isEqualToString:@"iPhone6,2"] || [[self machineName] isEqualToString:@"iPhone6,2"]|| [[self machineName] isEqualToString:@"iPod5,1"]);
}

+(BOOL)isNetworkActivated {
    return ([self isNetworkEnabled] && [self isAPIReachable]);
}


+(BOOL)isNetworkEnabled
{
    struct sockaddr_in address;
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
    address.sin_port = htons(8080);
    address.sin_addr.s_addr = inet_addr(urlGoogle);
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    Reachability *reach2 = [Reachability reachabilityWithAddress:&address];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    NetworkStatus net2 = [reach2 currentReachabilityStatus];
    return (networkStatus != NotReachable && net2 != NotReachable);
}

+(BOOL)isAPIReachable {
    struct sockaddr_in address;
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
    address.sin_port = htons(8080);
    address.sin_addr.s_addr = inet_addr(urlGoogle);
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    Reachability *reach2 = [Reachability reachabilityWithAddress:&address];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    NetworkStatus net2 = [reach2 currentReachabilityStatus];
    return (networkStatus != NotReachable && net2 != NotReachable);
    
}

@end
