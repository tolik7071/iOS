//
//  DialView.m
//  Leveler
//
//  Created by Anatoliy Goodz on 10/8/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "DialView.h"

@implementation DialView

- (CGFloat)innerDialInset
{
    return (10.0 / 100.0);
}

- (UIColor *)dialColor
{
    return [UIColor colorWithHue:(208.0 / 360.0)
                      saturation:(44.0 / 100.0)
                      brightness:(90.0 / 100.0)
                           alpha:(50.0 / 100.0)];
}

- (CGFloat)quadrantTickInset
{
    return (8.0 / 100.0);
}

- (CGFloat)quadrantFontSizeRatio
{
    return (72.0 / 670.0);
}

- (CGFloat)majorTickInset
{
    return (5.0 / 100.0);
}

- (CGFloat)majorFontSizeRatio
{
    return (48.0 / 670.0);
}

- (CGFloat)minorTickInset
{
    return (2.5 / 100.0);
}

- (CGFloat)tickWidth
{
    return 4.0;
}

- (UIColor *)tickColor
{
    return [UIColor whiteColor];
}

- (NSInteger)circleDegrees
{
    return 360;
}

- (NSInteger)quadrantTickDegrees
{
    return 90;
}

- (NSInteger)majorTickDegrees
{
    return 30;
}

- (NSInteger)minorTickDegrees
{
    return 3;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self != nil)
    {
        self.clearsContextBeforeDrawing = YES;
        self.opaque = NO;
    }
    
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    return [super initWithCoder:aDecoder];
//}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = self.bounds;
    CGFloat radius = bounds.size.height / 2.0;
    
    CGContextSaveGState(context);
    
    UIBezierPath *dial = [UIBezierPath bezierPathWithOvalInRect:bounds];
    
    [self.dialColor setFill];
    [dial fill];
    
    CGRect innerBounds = CGRectInset(bounds, radius * self.innerDialInset,
                                     radius * self.innerDialInset);
    
    dial = [UIBezierPath bezierPathWithOvalInRect:innerBounds];
    
    [[UIColor clearColor] setFill];
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    [dial fill];
    
    CGContextRestoreGState(context);
    
    CGContextTranslateCTM(context,radius,radius);
    
    CGPoint topCenter = { 0.0, -radius };
    
    CGFloat tickAngle = self.minorTickDegrees * (M_PI / 180.0);
    CGAffineTransform rotation = CGAffineTransformMakeRotation(tickAngle);
    
    [self.tickColor set];
    
    CGContextSetLineWidth(context, self.tickWidth);
    
    for (NSInteger angle = 0; angle < self.circleDegrees; angle += self.minorTickDegrees)
    {
        CGFloat tickLength = .0, labelSize = .0;
        
        if (angle % self.quadrantTickDegrees == 0)
        {
            tickLength = ceil(bounds.size.height * self.quadrantTickInset);
            labelSize = ceil(bounds.size.height * self.quadrantFontSizeRatio);
        }
        else if (angle % self.majorTickDegrees == 0)
        {
            tickLength = ceil(bounds.size.height * self.majorTickDegrees);
            labelSize = ceil(bounds.size.height * self.majorFontSizeRatio);
        }
        else
        {
            tickLength = ceil(bounds.size.height * self.minorTickInset);
        }
        
        CGPoint points[] = { topCenter, { topCenter.x, topCenter.y + tickLength} };
        
        CGContextStrokeLineSegments(context, points, 2);
        
        CGFloat size = labelSize;
        if (size != .0)
        {
            NSString *labelText = [NSString stringWithFormat:@"%ld", (long)angle];
            NSDictionary *labelAttrs = @{ NSFontAttributeName : [UIFont systemFontOfSize:size],
                                          NSForegroundColorAttributeName : self.tickColor };
            CGSize textSize = [labelText sizeWithAttributes:labelAttrs];
            CGPoint textOrigin = points[1];
            textOrigin.x -= floor(textSize.width / 2.0);
            [labelText drawAtPoint:textOrigin withAttributes:labelAttrs];
        }
        
        CGContextConcatCTM(context, rotation);
    }
}

@end
