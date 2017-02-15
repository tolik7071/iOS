//
//  TouchyView.m
//  Touchy
//
//  Created by Anatoliy Goodz on 6/14/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "TouchyView.h"

@interface TouchyView ()

@end

@implementation TouchyView

- (void)drawRect:(CGRect)rect {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    [[UIColor blackColor] set];
    CGContextFillRect(currentContext, rect);
    
    UIBezierPath *path;
    
    if ([self touchPoints].count > 1) {
        for (NSValue *value in [self touchPoints]) {
            CGPoint point = [value CGPointValue];
            
            if (path != nil) {
                [path addLineToPoint:point];
            }
            else {
                path = [UIBezierPath bezierPath];
                [path moveToPoint:point];
            }
        }
        
        if ([self touchPoints].count > 2) {
            if (path != nil) {
                [path closePath];
            }
        }
    }
    
    if (path != nil) {
        [[UIColor lightGrayColor] set];
        
        path.lineWidth = 6.0;
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        
        [path stroke];
    }
    
    NSInteger touchNumber = 0;
    
    NSDictionary *fontAttributes = @{
        NSFontAttributeName : [UIFont boldSystemFontOfSize:180],
        NSForegroundColorAttributeName : [UIColor yellowColor]
    };
    
    for (NSValue *value in [self touchPoints]) {
        CGPoint point = [value CGPointValue];
        
        NSString *text = [NSString stringWithFormat:@"%d", ++touchNumber];
        CGSize size = [text sizeWithAttributes:fontAttributes];
        CGPoint textCorner = CGPointMake(point.x - size.width / 2.0,
            point.y - size.height / 2.0);
        
        [text drawAtPoint:textCorner withAttributes:fontAttributes];
    }
}

- (NSMutableArray<NSValue *> *)touchPoints {
    static NSMutableArray<NSValue *> *sPoints;
    
    if (sPoints == nil) {
        sPoints = [NSMutableArray new];
    }
    
    return sPoints;
}

- (void)updateTouches:(NSSet *)touches {
    if (touches.count == 0) {
        return;
    }
    
    [touches enumerateObjectsUsingBlock:^(id  _Nonnull element, BOOL * _Nonnull stop) {
        if ([element isKindOfClass:[UITouch class]]) {
            switch ([(UITouch *)element phase]) {
                case UITouchPhaseBegan:
                case UITouchPhaseMoved:
                case UITouchPhaseStationary:
                    [[self touchPoints] addObject:[NSValue valueWithCGPoint:[(UITouch *)element locationInView:self]]];
                    break;
                    
                default:
                    break;
            }
        }
    }];
    
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"%s", __FUNCTION__);
    
    [self updateTouches:[event allTouches]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"%s", __FUNCTION__);
    
    [self updateTouches:[event allTouches]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"%s", __FUNCTION__);
    
    [self updateTouches:[event allTouches]];
}

- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"%s", __FUNCTION__);
    
    [self updateTouches:[event allTouches]];
}

@end
