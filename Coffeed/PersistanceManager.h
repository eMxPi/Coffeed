//
//  PersistanceManager.h
//  Coffeed
//
//  Created by Maxime Pontoire on 01/10/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistanceManager : NSObject{
    
}

+ (PersistanceManager *) sharedPersistanceManager;

-(void)saveValue:(NSString *)sValue Key:(NSString*)sKey;
-(NSString *)getValueKey:(NSString*)sKey;

@end
