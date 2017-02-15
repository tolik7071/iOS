//
//  ThingsDocument.h
//  MyStuff
//
//  Created by Anatoliy Goodz on 10/28/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyWhatsit;

@interface ThingsDocument : UIDocument
{
     NSFileWrapper *_fileWrapper;
}

@property (nonatomic, strong) NSString *thingsDocumentName;
@property (nonatomic, strong) NSURL *documentURL;
@property (nonatomic, strong) NSMutableArray<MyWhatsit *> *things;

@end
