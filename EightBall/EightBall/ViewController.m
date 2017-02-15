//
//  ViewController.m
//  EightBall
//
//  Created by Anatoliy Goodz on 6/13/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<NSString *> *)answers {
    return @[
        @"YES",
        @"NO",
        @"MAYBE",
        @"I DON'T KNOW",
        @"TRY AGAIN SOON",
        @"READ THE MANUAL"
    ];
}

- (void)fadeFortune {
    [UIView animateWithDuration:0.75 animations:^{
        self.textView.alpha = 0.0;
    }];
}

- (void)newFortune {
    NSUInteger randomIndex = (NSUInteger)(arc4random_uniform((NSUInteger)([self answers].count)));
    
    NSAttributedString *attributedString = self.textView.attributedText;
    NSRange range = NSMakeRange(0, self.textView.text.length);
    NSDictionary<NSString *, id> * attributes =
        [attributedString attributesAtIndex:0 effectiveRange:&range];
    
    NSAttributedString *newAttributedString = [[NSAttributedString alloc]
        initWithString:[self answers][randomIndex] attributes:attributes];
    [self.textView setAttributedText:newAttributedString];
    
    [UIView animateWithDuration:2.0 animations:^{
        self.textView.alpha = 1.0;
    }];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self fadeFortune];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self newFortune];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self newFortune];
    }
}

@end
