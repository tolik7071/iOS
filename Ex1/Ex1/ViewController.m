//
//  ViewController.m
//  Ex1
//
//  Created by Anatoliy Goodz on 12/31/15.
//  Copyright (c) 2015 smk.private. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.view.bounds;
    frame.size.width *= 2.0;
//    frame.size.height *= 2.0;
    
    MyView *view = [[MyView alloc] initWithFrame:frame];
    
    [self.view addSubview:view];
    
//    [(UIScrollView *)(self.view) setPagingEnabled:YES];
    [(UIScrollView *)(self.view) setContentSize:frame.size];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
