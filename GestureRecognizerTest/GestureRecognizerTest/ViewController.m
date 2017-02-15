//
//  ViewController.m
//  GestureRecognizerTest
//
//  Created by Anatoliy Goodz on 2/29/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawString:(NSString *)aString atPoint:(CGPoint)aPoint
{
    
}

#pragma mark - Actions for Gesture Recognizers

- (IBAction)displayGestureForTapRecognizer:(UITapGestureRecognizer *)aRecognizer
{

}

- (IBAction)showGestureForPanRecognizer:(UIPanGestureRecognizer *)aRecognizer
{
//    NSLog(@"%d", [aRecognizer state]);
}

- (IBAction)showGestureForPinchRecognizer:(UIPinchGestureRecognizer *)aRecognizer
{
    if ([aRecognizer state] == UIGestureRecognizerStateChanged)
    {
        NSLog(@"%f", [aRecognizer scale]);
        [(MyView *)self.view setScale:[aRecognizer scale]];
        [self.view setNeedsDisplay];
    }
}

@end
