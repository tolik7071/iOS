//
//  ViewController.m
//  Shapely
//
//  Created by Anatoliy Goodz on 8/11/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ViewController.h"
#import "ShapeView.h"
#import "ShapeFactory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIColor *)rundomColor
{
    static NSArray<UIColor *> *colors;
    
    if (colors == nil)
    {
        colors =
        @[
            [UIColor redColor],
            [UIColor blueColor],
            [UIColor greenColor],
            [UIColor yellowColor],
            [UIColor purpleColor],
            [UIColor grayColor],
            [UIColor orangeColor],
            [UIColor whiteColor],
            [UIColor brownColor]
        ];
    }
    
    return colors[arc4random_uniform((u_int32_t)colors.count)];
}

- (IBAction)addShape:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]])
    {
        ShapeFactory *factory = [ShapeFactory new];
        ShapeView *shapeView = [factory loadShape:(ShapeSelector)[(UIButton *)sender tag]
            inViewController:self];
        //[[ShapeView alloc] initWithShape:(ShapeSelector)[(UIButton *)sender tag]];
        
        shapeView.color = [self rundomColor];
        [self.view addSubview:shapeView];
        
        CGRect safeRect = CGRectInset(self.view.bounds
                                      , shapeView.frame.size.width
                                      , shapeView.frame.size.height);
        
        CGPoint randomCenter = safeRect.origin;
        
        randomCenter.x += arc4random_uniform((UInt32)safeRect.size.width);
        randomCenter.y += arc4random_uniform((UInt32)safeRect.size.height);
        shapeView.center = [(UIButton *)sender center];
        [UIView animateWithDuration:0.5 animations:^{
            shapeView.center = randomCenter;
            shapeView.transform = CGAffineTransformIdentity;
        }];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]
            initWithTarget:self action:@selector(moveShape:)];
        panRecognizer.maximumNumberOfTouches = 1;
        [shapeView addGestureRecognizer:panRecognizer];
        
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
            initWithTarget:self action:@selector(resizeShape:)];
        [shapeView addGestureRecognizer:pinchRecognizer];
        
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(changeColor:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        [shapeView addGestureRecognizer:doubleTapRecognizer];
        
        UITapGestureRecognizer *tripleTapRecognizer = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(sendShapeToBack:)];
        tripleTapRecognizer.numberOfTapsRequired = 3;
        [shapeView addGestureRecognizer:tripleTapRecognizer];
        
        [doubleTapRecognizer requireGestureRecognizerToFail:tripleTapRecognizer];
    }
}

- (IBAction)moveShape:(UIPanGestureRecognizer*)recognizer
{
    if (![recognizer.view isKindOfClass:[ShapeView class]])
    {
        return;
    }
    
    CGPoint dragDelta = [recognizer translationInView:recognizer.view.superview];
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            recognizer.view.transform = CGAffineTransformMakeTranslation(dragDelta.x, dragDelta.y);
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            recognizer.view.transform = CGAffineTransformIdentity;
            recognizer.view.frame = CGRectOffset(recognizer.view.frame, dragDelta.x, dragDelta.y);
            break;
        }
            
        default:
        {
            recognizer.view.transform = CGAffineTransformIdentity;
        }
    }
}

- (IBAction)resizeShape:(UIPinchGestureRecognizer *)recognizer
{
    if (![recognizer.view isKindOfClass:[ShapeView class]])
    {
        return;
    }
    
    CGFloat pinchScale = recognizer.scale;
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            recognizer.view.transform = CGAffineTransformMakeScale(pinchScale, pinchScale);
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            recognizer.view.transform = CGAffineTransformIdentity;
            CGRect frame = recognizer.view.frame;
            CGFloat xDelta = frame.size.width * pinchScale - frame.size.width;
            CGFloat yDelta = frame.size.height * pinchScale - frame.size.height;
            frame.size.width += xDelta;
            frame.size.height += yDelta;
            frame.origin.x -= xDelta / 2.0;
            frame.origin.y -= yDelta / 2.0;
            recognizer.view.frame = frame;
            [recognizer.view setNeedsDisplay];
            
            break;
        }
            
        default:
        {
            recognizer.view.transform = CGAffineTransformIdentity;
        }
    }
}

- (IBAction)changeColor:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        ShapeView *shapeView = (ShapeView *)recognizer.view;
        shapeView.color = [self rundomColor];
        [shapeView setNeedsDisplay];
    }
}

- (IBAction)sendShapeToBack:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [self.view sendSubviewToBack:recognizer.view];
    }
}

@end
