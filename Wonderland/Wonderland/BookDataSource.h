//
//  BookDataSource.h
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/26/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Paginator, OnePageViewController;

@interface BookDataSource : NSObject <UIPageViewControllerDataSource>

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@property (nonatomic, retain) Paginator *paginator;

- (OnePageViewController *)loadPage:(NSInteger)page pageViewController:(UIPageViewController *)controller;

@end
