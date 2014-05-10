//
//  ContactsViewController.m
//  Wolong
//
//  Created by Luke Shi on 4/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactViewController.h"
#import "ChatViewController.h"
#import "UIViewController+ModalCheck.h"
#import "AddContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

@synthesize mode;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self isPresentedAsModal]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                              target:self
                                                                                              action:@selector(dismissAction:)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                               target:self
                                                                                               action:@selector(doneAction:)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 27;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
        return 3;
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    if ([self isPresentedAsModal]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    UILabel *name = (UILabel *)[cell viewWithTag:1];
    if (indexPath.section == 0) {
        name.text = [NSString stringWithFormat:@"群组-%d", (int)indexPath.row+1];
    } else {
        name.text = [NSString stringWithFormat:@"%c朋友-%d", (char)('A'+indexPath.section-1), (int)indexPath.row+1];
    }
    
    UIImageView *photoView = (UIImageView *)[cell viewWithTag:10];
    if (indexPath.section == 0) {
        photoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"group%d", (int)indexPath.row+1]];
    } else {
        photoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"user%d", (int)(indexPath.row+indexPath.section)%6+1]];
    }
    
    return cell;
}

#define HEADER_HEIGHT 20.0

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, HEADER_HEIGHT)];
    headerView.backgroundColor = [UIColor colorWithRed:0.83 green:0.86 blue:0.89 alpha:1.0];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, tableView.frame.size.width-20, HEADER_HEIGHT)];
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:13];
    
    if (section == 0) {
        headerLabel.text = @"群组";
    } else {
        headerLabel.text = [NSString stringWithFormat: @"%c", (char)('A'+section-1)];
    }
    
    [headerView addSubview:headerLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADER_HEIGHT;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexTitles = [NSMutableArray arrayWithCapacity:27];
    [indexTitles addObject: @""];
    for (int i = 0; i < 26; i++) {
        [indexTitles addObject: [NSString stringWithFormat: @"%c", 'A'+i]];
    }
    return indexTitles;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self isPresentedAsModal]) {
        if (cell.accessoryType == UITableViewCellAccessoryNone) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        ContactViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Contact"];
        if (controller != nil) {
            controller.type = indexPath.section;
            controller.hidesBottomBarWhenPushed = YES;
            
            UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
            UIImageView *photoView = (UIImageView *)[cell viewWithTag:10];

            controller.name = nameLabel.text;
            controller.photo = photoView.image;
            
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    AddContactsViewController *controller = [segue destinationViewController];
    controller.hidesBottomBarWhenPushed = YES;
}
*/

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneAction:(id)sender {
    if (mode == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    ChatViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Chat"];
    if (controller != nil) {
        controller.userId = 6;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (IBAction)addContactAction:(id)sender {
    UINavigationController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddContactNav"];
    if (controller != nil) {
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
}

@end
