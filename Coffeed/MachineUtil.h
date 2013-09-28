//
//  MachineUtil.h
//  Coffeed
//
//  Created by Maxime Pontoire on 19/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <arpa/inet.h>
#import "Reachability.h"
#import "Constantes.h"

@interface MachineUtil : NSObject

+(NSString*)machineName;

+(BOOL)isNetworkActivated;

+(BOOL)isNetworkEnabled;

+(BOOL)isAPIReachable;

@end
