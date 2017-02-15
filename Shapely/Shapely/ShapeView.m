//
//  ShapeView.m
//  Shapely
//
//  Created by Anatoliy Goodz on 8/11/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

+ (CGRect)initialFrame
{
    return CGRectMake(0.0, 0.0, 100.0, 100.0);
}

+ (CGFloat)alternateHeight
{
    return (100.0 / 2.0);
}

//- (instancetype)initWithShape:(ShapeSelector)shape
//{
//    CGRect frame = [ShapeView initialFrame];
//    
//    if (self.shape == Rectangle || self.shape == Oval)
//    {
//        frame.size.height = [ShapeView alternateHeight];
//    }
//    
//    self = [super initWithFrame:frame];
//    
//    if (self != nil)
//    {
//        _strokeWidth = 8.0;
//        _color = [UIColor whiteColor];
//        _shape = shape;
//        
//        self.opaque = NO;
//        self.backgroundColor = nil;
//        self.clearsContextBeforeDrawing = YES;
//    }
//    
//    return self;
//}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    
//    if (self != nil)
//    {
//        _shape = Square;
//    }
//    
//    return self;
//}

- (UIBezierPath *)path
{
    UIBezierPath *path;

    if (self.shape == Square || self.shape == Rectangle)
    {
        CGRect rect = CGRectInset(self.bounds, self.strokeWidth / 2.0, self.strokeWidth / 2.0);
        path = [UIBezierPath bezierPathWithRect:rect];
    }
    else if (self.shape == Triangle)
    {
        path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds))];
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds))];
        [path addLineToPoint:CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds))];
        
        [path closePath];
    }
    else if (self.shape == Circle || self.shape == Oval)
    {
        path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    }
    else if (self.shape == Star)
    {
        path = [UIBezierPath bezierPath];
        
        CGFloat armRotation = M_PI * 2.0 / 5.0;
        CGFloat angle = armRotation;
        CGFloat distance = self.bounds.size.width * 0.38;
        CGPoint point = { CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds) };
        
        [path moveToPoint:point];
        
        for (int i = 0; i < 5; i++)
        {
            point.x += cos(angle) * distance;
            point.y += sin(angle) * distance;
            [path addLineToPoint:point];
            
            angle -= armRotation;
            
            point.x += cos(angle) * distance;
            point.y += sin(angle) * distance;
            [path addLineToPoint:point];
            
            angle += armRotation * 2.0;
        }
        
        [path closePath];
    }
    else
    {
        NSAssert(NO, @"%lu - Unknoun ID", (long)self.shape);
    }

    path.lineWidth = self.strokeWidth;
    path.lineJoinStyle = kCGLineJoinRound;
    
    return path;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = self.path;
    
    [[[UIColor blackColor] colorWithAlphaComponent:0.4] setFill];
    [path fill];
    
    [self.color setStroke];
    [self.path stroke];
}

@end
