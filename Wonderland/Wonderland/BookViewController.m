//
//  BookViewController.m
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/26/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "BookViewController.h"
#import "BookDataSource.h"
#import "Paginator.h"

@interface BookViewController ()

@end

@implementation BookViewController

- (BookDataSource *)bookDataSource
{
    static BookDataSource *bookDataSource;
    
    if (bookDataSource == nil)
    {
        bookDataSource = [[BookDataSource alloc] init];
    }
    
    return bookDataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *textURL = [[NSBundle mainBundle] URLForResource:@"Alice" withExtension:@"txt"];
    [self bookDataSource].paginator.bookText = [NSString stringWithContentsOfURL:textURL encoding:NSUTF8StringEncoding error:nil];
    
    self.dataSource = [self bookDataSource];
    
    OnePageViewController *firstPage = [[self bookDataSource] loadPage:1 pageViewController:self];
    
    [self setViewControllers:@[firstPage] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self adaptViewsToTraitCollection:self.traitCollection];
}

- (void)adaptViewsToTraitCollection:(UITraitCollection *)traits
{
    BOOL compactWidth = self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact;
    
    CGFloat fontSize = compactWidth ? 14.0 : 18.0;
    
    Paginator *paginator = self.bookDataSource.paginator;
    UIFont *currentFont = paginator.font;
    
    if (currentFont.pointSize != fontSize)
    {
        paginator.font = [currentFont fontWithSize:fontSize];
    }
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
    withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    [self adaptViewsToTraitCollection:newCollection];
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
