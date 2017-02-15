//
//  CharacterTableViewController.h
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/22/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterTableViewController : UITableViewController

@property (nonatomic, retain) NSArray<NSDictionary<NSString*, NSString*>*> *tableData;

@end
