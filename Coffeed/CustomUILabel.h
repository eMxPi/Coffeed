//
//  CustomUILabel.h
//  Coffeed
//
//  Created by Maxime Pontoire on 30/09/13.
//  Copyright (c) 2013 Coffeed Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface CustomUILabel : UILabel
{
    CGFloat characterSpacing;
}

@property CGFloat characterSpacing;

@end
