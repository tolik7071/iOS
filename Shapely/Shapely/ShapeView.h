//
//  ShapeView.h
//  Shapely
//
//  Created by Anatoliy Goodz on 8/11/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShapeSelector)
{
    Square,
    Rectangle,
    Circle,
    Oval,
    Triangle,
    Star
};

@interface ShapeView : UIView

@property (nonatomic, assign, readonly) CGFloat strokeWidth;
@property (nonatomic, assign/*, readonly*/) ShapeSelector shape;
@property (nonatomic, copy) UIColor *color;
@property (nonatomic, readonly) UIBezierPath *path;

//- (instancetype)initWithShape:(ShapeSelector)shape;

@end
