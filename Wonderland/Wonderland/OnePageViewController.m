//
//  OnePageViewController.m
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/26/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "OnePageViewController.h"
#import "Paginator.h"
#import "OnePageView.h"

@interface OnePageViewController ()

@end

@implementation OnePageViewController

//- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    
//    if (self != nil)
//    {
//        _pageNumber = 1;
//    }
//    
//    return self;
//}

- (NSInteger)pageNumber
{
    if (_pageNumber == 0)
    {
        _pageNumber = 1;
    }
    
    return _pageNumber;
}

- (void)loadPageContent
{
    if (self.textView != nil && self.paginator != nil)
    {
        self.paginator.viewSize = self.textView.bounds.size;
        
        if (![self.paginator pageAvailable:self.pageNumber])
        {
            self.pageNumber = self.paginator.lastKnownPage;
        }
        
        self.textView.fontAttrs = self.paginator.fontAttrs;
        self.textView.text = [self.paginator textForPage:self.pageNumber];
    }
    
    self.pageLabel.text = [NSString stringWithFormat:@"Page %d", self.pageNumber];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self loadPageContent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
