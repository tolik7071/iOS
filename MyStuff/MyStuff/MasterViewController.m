//
//  MasterViewController.m
//  MyStuff
//
//  Created by Anatoliy Goodz on 6/15/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MyWhatsit.h"

@interface MasterViewController ()

@property (strong, nonatomic, getter=things) NSMutableArray<MyWhatsit *> *things;

@end

@implementation MasterViewController

- (void)dealloc
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}

- (NSMutableArray<MyWhatsit *> *)things
{
    if (_things == nil)
    {
        _things = [[NSMutableArray alloc] initWithObjects:
           [[MyWhatsit alloc] initWithName:@"Gort" location:@"den"],
           [[MyWhatsit alloc] initWithName:@"Disappearing TARDIS mug" location:@"kitchen"],
           [[MyWhatsit alloc] initWithName:@"Robot USB drive" location:@"office"],
           [[MyWhatsit alloc] initWithName:@"Sad Robot USB hub" location:@"office"],
           [[MyWhatsit alloc] initWithName:@"Solar Powered Bunny" location:@"office"],
           nil];
    }
    
    return _things;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)
        [[self.splitViewController.viewControllers lastObject] topViewController];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(whatsitDidChange:)
                               name:WhatsitDidChangeNotification
                             object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    [self.things insertObject:[[MyWhatsit alloc] initWithName:@"Some name"] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MyWhatsit *thing = self.things[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:thing];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

- (void)whatsitDidChange:(NSNotification *)aNotification {
    if ([[aNotification object] isKindOfClass:[MyWhatsit class]]) {
        for (int i = 0; i < self.things.count; ++i) {
            MyWhatsit *thing = [self.things objectAtIndex:i];
            
            if (thing == [aNotification object]) {
                NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
                [self.tableView reloadRowsAtIndexPaths:@[path]
                    withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.things.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    MyWhatsit *thing = self.things[indexPath.row];
    cell.textLabel.text = thing.name;
    cell.detailTextLabel.text = thing.location;
    cell.imageView.image = thing.image;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView
    canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.things removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {

    }
}

@end
