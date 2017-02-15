//
//  MyView.m
//  GestureRecognizerTest
//
//  Created by Anatoliy Goodz on 2/29/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _scale = 1.0;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self) {
        _scale = 1.0;
    }
    
    return self;
}

- (void)drawRect:(CGRect)aRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    assert(context);
    
    CGContextSaveGState(context);
    
    CGContextScaleCTM(context, self.scale, self.scale);
    
    UIFont *font = [UIFont fontWithName:@"Zapfino" size:50.0f];
    NSDictionary *attributes =
    @{
        NSFontAttributeName : font,
        NSForegroundColorAttributeName : [UIColor blueColor]
    };
    
    CGRect bounds = self.bounds;
    
    CGPoint point = { 0, 0 /*CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)*/ };
    NSString *string = @"Tap";
    
    NSAttributedString *stringWithAttributes = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    [stringWithAttributes drawAtPoint:point];
    
    CGContextRestoreGState(context);
}

@end
