//
//  ViewController.m
//  Leveler
//
//  Created by Anatoliy Goodz on 10/8/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ViewController.h"
#import "DialView.h"

@interface ViewController ()
{
    UIImage* _handImage;
}

@property (nonatomic, retain) DialView *dialView;
@property (nonatomic, retain) UIImageView *needleView;

@end

@implementation ViewController

- (UIImage *)handImage
{
    if (_handImage == nil)
    {
        _handImage = [UIImage imageNamed:@"hand"];
    }
    
    return _handImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dialView = [[DialView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
    [self.view addSubview:self.dialView];
    
    self.needleView = [[UIImageView alloc] initWithImage:[self handImage]];
    self.needleView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view insertSubview:self.needleView aboveSubview:self.dialView];
    
    [self adaptInterface];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self positionDialViews];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context)
            {
                [self positionDialViews];
            }
        completion:nil];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)adaptInterface
{
    if (self.angleLabel != nil)
    {
        CGFloat fontSize = 90.0;
        
        if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact)
        {
            fontSize = 60.0;
        }
        
        self.angleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
}

- (void)positionDialViews
{
    CGRect viewBounds = self.view.bounds;
    CGRect labelFrame = self.angleLabel.frame;
    
    CGFloat topEdge = ceil(CGRectGetMaxY(labelFrame) + labelFrame.size.height / 3.0);
    CGFloat dialRadius = CGRectGetMaxY(viewBounds) - topEdge;
    CGFloat dialHeight = dialRadius * 2.0;
    
    self.dialView.transform = CGAffineTransformIdentity;
    self.dialView.frame = CGRectMake(0.0, 0.0, dialHeight, dialHeight);
    self.dialView.center = CGPointMake(CGRectGetMidX(viewBounds), CGRectGetMaxY(viewBounds));
    
    [self.dialView setNeedsDisplay];
    
    CGSize needleSize = self.needleView.image.size;
    CGFloat needleScale = dialRadius / needleSize.height;
    CGRect needleFrame = CGRectMake(0.0, 0.0,
                                    needleSize.width * needleScale,
                                    needleSize.height * needleScale);
    needleFrame.origin.x = CGRectGetMidX(viewBounds) - needleFrame.size.width / 2.0;
    needleFrame.origin.y = CGRectGetMaxY(viewBounds) - needleFrame.size.height;
    self.needleView.frame = CGRectIntegral(needleFrame);
}

@end
