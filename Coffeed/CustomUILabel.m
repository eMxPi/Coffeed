//
//  CustomUILabel.m
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

#import "CustomUILabel.h"

@implementation CustomUILabel
@synthesize characterSpacing;

- (void)drawTextInRect:(CGRect)rect
{
    characterSpacing = 2;
    if (characterSpacing)
    {
        // Drawing code
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSelectFont (context, [self.font.fontName cStringUsingEncoding:NSASCIIStringEncoding], self.font.pointSize, kCGEncodingMacRoman);
        CGContextSetCharacterSpacing(context, characterSpacing);
        CGContextSetFillColorWithColor(context, [self.textColor CGColor]);
        CGAffineTransform myTextTransform = CGAffineTransformScale(CGAffineTransformIdentity, 1.f, -1.f );
        CGContextSetTextMatrix (context, myTextTransform);
        
        CGGlyph glyphs[self.text.length];
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.font.fontName, self.font.pointSize, NULL);
        CTFontGetGlyphsForCharacters(fontRef, (const unichar*)[self.text cStringUsingEncoding:NSUnicodeStringEncoding], glyphs, self.text.length);
        float centeredY = (self.font.pointSize + (self.frame.size.height- self.font.pointSize)/2)-2;
        CGContextShowGlyphsAtPoint(context, rect.origin.x, centeredY, (const CGGlyph *)glyphs, self.text.length);
        CFRelease(fontRef);
    }
    else
    {
        // no character spacing provided so do normal drawing
        [super drawTextInRect:rect];
    }
}

@end
