//
//  PersistanceManager.m
//  Coffeed
//
//  Created by Maxime Pontoire on 01/10/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import "PersistanceManager.h"

@implementation PersistanceManager
static PersistanceManager *persistanceManager = nil;

#pragma mark -
#pragma mark init part

+ (PersistanceManager *) sharedPersistanceManager{
	if (persistanceManager == nil) {
		persistanceManager = [[PersistanceManager alloc] init];
	}
	return persistanceManager;
}

#pragma mark - generic save - get key
-(void)saveValue:(NSString *)sValue Key:(NSString*)sKey{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sValue forKey:sKey];
    [defaults synchronize];
}
-(NSString *)getValueKey:(NSString*)sKey{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:sKey];
}

@end
