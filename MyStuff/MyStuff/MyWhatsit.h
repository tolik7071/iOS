//
//  MyWhatsit.h
//  MyStuff
//
//  Created by Anatoliy Goodz on 6/16/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *WhatsitDidChangeNotification;

@interface MyWhatsit : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic, setter=setImage:, getter=image) UIImage *image;

- (instancetype)initWithName:(NSString *)aName;
- (instancetype)initWithName:(NSString *)aName location:(NSString *)aLocation/* NS_DESIGNATED_INITIALIZER*/;

@end
