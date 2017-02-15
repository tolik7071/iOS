//
//  OnePageView.m
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/26/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "OnePageView.h"

@implementation OnePageView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    
//    if (self != nil)
//    {
//        [self addObserver:self forKeyPath:@"text"
//                  options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
//                  context:NULL];
//    }
//    
//    return self;
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object change:(NSDictionary<NSString *,id> *)change
//                       context:(void *)context
//{
//    if ([keyPath isEqual:@"text"])
//    {
//        [self setNeedsDisplay];
//    }
//}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self.text drawInRect:self.bounds withAttributes:self.fontAttrs];
}

- (void)setText:(NSString *)newValue
{
    if (_text != newValue)
    {
        _text = newValue;
        [self setNeedsDisplay];
    }
}

@end
