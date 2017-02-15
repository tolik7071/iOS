//
//  FirstViewController.m
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/20/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"info"])
    {
        UIViewController *presented = segue.destinationViewController;
        UIPresentationController  *presentationController = presented.presentationController;
        if (presentationController != nil)
        {
            presentationController.delegate = self;
        }
    }
    else
    {
        [super prepareForSegue:segue sender:sender];
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationFullScreen;
}

- (nullable UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
    UIViewController *presentedVC = controller.presentedViewController;
    UINavigationController *replacementController = [[UINavigationController alloc] initWithRootViewController:presentedVC];
    UINavigationItem *navigationItem = presentedVC.navigationItem;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemDone
        target:self
        action:@selector(dismissInfo:)];
    navigationItem.rightBarButtonItem = doneButton;
    navigationItem.title = @"Author";
    return replacementController;
}

- (IBAction)dismissInfo:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
