//
//  ViewController.m
//  TableViewTest
//
//  Created by Anatoliy Goodz on 2/4/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ViewController.h"

@interface NSIndexPath (Private)

- (NSString *)stringRepresentation;

@end

@implementation NSIndexPath (Private)

- (NSString *)stringRepresentation
{
    NSMutableString *result = [NSMutableString new];
    
    for (NSUInteger position = 0; position < self.length; ++position)
    {
        if (position > 0)
        {
            [result appendString:@"."];
        }
        
        [result appendFormat:@"%lu", (unsigned long)[self indexAtPosition:position]];
    }
    
    return result;
}

@end

#pragma mark -

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *newCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    newCell.textLabel.text = [indexPath stringRepresentation];
    return newCell;
}

#pragma mark - Add/Delete record -

- (IBAction)addRecord:(id)sender
{
    NSLog(@"%@", sender);
}

- (IBAction)deleteRecord:(id)sender
{
    NSLog(@"%@", sender);
}

@end
