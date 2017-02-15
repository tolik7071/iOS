//
//  CharacterDetailViewController.m
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/22/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "CharacterDetailViewController.h"

NSString *kNameKey = @"name";
NSString *kImageKey = @"image";
NSString *kDescriptionKey = @"description";

@interface CharacterDetailViewController ()

@end

@implementation CharacterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.nameLabel.text = self.characterInfo[kNameKey];
    self.imageView.image = [UIImage imageNamed:self.characterInfo[kImageKey]];
    self.descriptionView.text = self.characterInfo[kDescriptionKey];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
