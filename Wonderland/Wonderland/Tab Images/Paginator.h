//
//  Paginator.h
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/26/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Paginator : NSObject

@property (nonatomic, retain) NSString *bookText;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) NSDictionary<NSString*, id> *fontAttrs;
@property (nonatomic) NSInteger lastKnownPage;
@property (nonatomic) CGSize viewSize;

- (instancetype)initWithFont:(UIFont *)font;

- (BOOL)pageAvailable:(NSInteger)page;
- (NSString *)textForPage:(NSInteger)page;

@end
