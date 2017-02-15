//
//  OnePageViewController.h
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/26/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OnePageView, Paginator;


@interface OnePageViewController : UIViewController

@property (nonatomic, weak) IBOutlet OnePageView *textView;
@property (nonatomic, weak) IBOutlet UILabel *pageLabel;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic, retain) Paginator *paginator;

@end
