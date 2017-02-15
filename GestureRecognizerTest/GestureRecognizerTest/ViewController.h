//
//  ViewController.h
//  GestureRecognizerTest
//
//  Created by Anatoliy Goodz on 2/29/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
- (IBAction)displayGestureForTapRecognizer:(UITapGestureRecognizer *)aRecognizer;

@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panRecognizer;
- (IBAction)showGestureForPanRecognizer:(UIPanGestureRecognizer *)aRecognizer;

@property (nonatomic, strong) IBOutlet UIPinchGestureRecognizer *pinchRecognizer;
- (IBAction)showGestureForPinchRecognizer:(UIPinchGestureRecognizer *)aRecognizer;

@end

