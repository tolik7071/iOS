//
//  ShapeFactory.m
//  Shapely
//
//  Created by Anatoliy Goodz on 10/6/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ShapeFactory.h"

@implementation ShapeFactory

- (NSString *)nibNameForShape:(ShapeSelector)shape
{
    NSString *result = (shape == Rectangle || shape == Oval)
        ? @"RectangleShape" : @"SquareShape";
    return result;
}

- (ShapeView *)loadShape:(ShapeSelector)shape inViewController:(UIViewController *)viewController
{
    NSDictionary *placeholders = @{ @"viewController" : viewController };
    NSDictionary * options = @{ UINibExternalObjects : placeholders };
    
    [[NSBundle mainBundle] loadNibNamed:[self nibNameForShape:shape]
        owner:self options:options];
    assert(self.view != nil);
    
    self.view.shape = shape;
    [self.dblTapGesture requireGestureRecognizerToFail:self.trplTapGesture];
    
    return self.view;
}

@end
