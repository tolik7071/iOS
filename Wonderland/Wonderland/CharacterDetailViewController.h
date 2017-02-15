//
//  CharacterDetailViewController.h
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/22/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kNameKey;
extern NSString *kImageKey;
extern NSString *kDescriptionKey;

@interface CharacterDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView* imageView;
@property (nonatomic, weak) IBOutlet UITextView* descriptionView;

@property (nonatomic, retain) NSDictionary<NSString*, NSString*> *characterInfo;

@end
