//
//  ShapeFactory.h
//  Shapely
//
//  Created by Anatoliy Goodz on 10/6/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShapeView.h"

@class ShapeView;
@class UITapGestureRecognizer;

@interface ShapeFactory : NSObject

@property (nonatomic) IBOutlet ShapeView *view;
@property (nonatomic) IBOutlet UITapGestureRecognizer *dblTapGesture;
@property (nonatomic) IBOutlet UITapGestureRecognizer *trplTapGesture;

- (NSString *)nibNameForShape:(ShapeSelector)shape;
- (ShapeView *)loadShape:(ShapeSelector)shape inViewController:(UIViewController *)viewController;

@end
