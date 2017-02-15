//
//  MyWhatsit.m
//  MyStuff
//
//  Created by Anatoliy Goodz on 6/16/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "MyWhatsit.h"

NSString *kNameKey = @"name";
NSString *kLocationKey = @"location";

@interface MyWhatsit () {
    UIImage * _image;
}

@end

NSString *WhatsitDidChangeNotification = @"MyWhatsitDidChange";

@implementation MyWhatsit

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    _name = [aDecoder decodeObjectForKey:kNameKey];
    _location = [aDecoder decodeObjectForKey:kLocationKey];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:kNameKey];
    [aCoder encodeObject:_location forKey:kLocationKey];
}

- (instancetype)initWithName:(NSString *)aName {
    return [self initWithName:aName location:@""];
}

- (instancetype)initWithName:(NSString *)aName location:(NSString *)aLocation {
    self = [super init];
    
    if (self != nil) {
        _name = [aName copy];
        _location = [aLocation copy];
    }
    
    return self;
}

- (void)postDidChangeNotification {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:WhatsitDidChangeNotification object:self];
}

- (void)setName:(NSString *)name {
    _name = name;
    [self postDidChangeNotification];
}

- (void)setLocation:(NSString *)location {
    _location = location;
    [self postDidChangeNotification];
}

- (UIImage *)image {
    UIImage *result;
    
    if (_image != nil) {
        result = _image;
    }
    else {
        result = [UIImage imageNamed:@"camera"];
    }
    
    return result;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self postDidChangeNotification];
}

@end
