//
//  MyView.m
//  Ex1
//
//  Created by Anatoliy Goodz on 12/31/15.
//  Copyright (c) 2015 smk.private. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(context);
    
    {
        CGPathRef path = CGPathCreateWithRect(self.bounds, NULL);
        if (path != NULL)
        {
            CGContextSetFillColorWithColor(context, [self.backgroundColor CGColor]);
            CGContextAddPath(context, path);
            CGContextFillPath(context);
            
            CGPathRelease(path);
        }
        
        CGContextSetStrokeColorWithColor(context, [[UIColor yellowColor] CGColor]);
        CGRect rect = CGRectInset(self.bounds, 10, 10);
        CGContextSetLineWidth(context, 5);
        CGContextStrokeRect(context, rect);
    }
    
    UIGraphicsPopContext();
}

- (void)changeBackgroundColor
{
    CGFloat red = (CGFloat)(arc4random() % 100) / 100.0;
    CGFloat green = (CGFloat)(arc4random() % 100) / 100.0;
    CGFloat blue = (CGFloat)(arc4random() % 100) / 100.0;
    
    self.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self changeBackgroundColor];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
