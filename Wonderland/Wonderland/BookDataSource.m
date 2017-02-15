//
//  BookDataSource.m
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/26/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "BookDataSource.h"
#import "Paginator.h"
#import "OnePageViewController.h"

@implementation BookDataSource

- (instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        _paginator = [[Paginator alloc] initWithFont:[UIFont fontWithName:@"Times New Roman" size:18.0]];
    }
    
    return self;
}

- (OnePageViewController *)loadPage:(NSInteger)page pageViewController:(UIPageViewController *)controller
{
    if (page < 1 || ![_paginator pageAvailable:page])
    {
        return nil;
    }
    
    OnePageViewController *result;
    
    if (controller.storyboard != nil)
    {
        result = [controller.storyboard instantiateViewControllerWithIdentifier:@"OnePage"];
        result.paginator = _paginator;
        result.pageNumber = page;
    }
    
    return result;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
    viewControllerAfterViewController:(UIViewController *)viewController
{
    UIViewController *result;
    
    if ([viewController isKindOfClass:[OnePageViewController class]])
    {
        OnePageViewController *pageController = (OnePageViewController *)viewController;
        NSInteger pageNumberAfter = pageController.pageNumber + 1;
        result = [self loadPage:pageNumberAfter pageViewController:pageViewController];
    }
    
    return result;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
    viewControllerBeforeViewController:(UIViewController *)viewController
{
    UIViewController *result;
    
    if ([viewController isKindOfClass:[OnePageViewController class]])
    {
        OnePageViewController *pageController = (OnePageViewController *)viewController;
        NSInteger pageNumberBefore = pageController.pageNumber - 1;
        result = [self loadPage:pageNumberBefore pageViewController:pageViewController];
    }
    
    return result;
}

@end
