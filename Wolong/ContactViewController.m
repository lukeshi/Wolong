//
//  ContactViewController.m
//  Wolong
//
//  Created by Luke Shi on 4/4/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import "ContactViewController.h"
#import "ChatViewController.h"
#import "ContactsViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

@synthesize photo, name;
@synthesize type;

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
    
    if (type == 0) {
        self.navigationItem.title = @"群组资料";
    } else {
        self.navigationItem.title = @"联系人资料";
    }
    
    photoView.image = photo;
    nameLabel.text = name;
    
    if (type == 1) {
        self.navigationItem.rightBarButtonItem = nil;
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
    if (type == 0)
        return 4;
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (type == 0) {
        if (section == 2)
            return 2;
        if (section == 3)
            return 20;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
        
        if (type == 0) {
            cell.textLabel.text = @"群组建立时间";
        } else {
            cell.textLabel.text = @"建立联系时间";
        }
        cell.detailTextLabel.text = @"10/20/2013";
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];

        cell.textLabel.text = @"发信息";
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.layer.borderWidth = 4.0f;
        cell.layer.borderColor = [[UIColor whiteColor] CGColor];
        cell.backgroundColor = [UIColor colorWithRed:32.0/255.0 green:158.0/255.0 blue:187.0/255.0 alpha:1.0];
    } else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat: @"群组%d", (int)indexPath.row+1];
        cell.detailTextLabel.text = @"加入时间: 12/12/2013";
        cell.imageView.image = [UIImage imageNamed: [NSString stringWithFormat: @"group%d", (int)(indexPath.row+3)%5+1] ];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat: @"成员%d", (int)indexPath.row+1];
        cell.detailTextLabel.text = @"加入时间: 12/10/2013";
        cell.imageView.image = [UIImage imageNamed: [NSString stringWithFormat: @"user%d", (int)indexPath.row%6+1] ];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3)
        return 1;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1) {
        ChatViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Chat"];
        if (controller != nil) {
            controller.userId = 6;
            [self.navigationController pushViewController:controller animated:YES];
        }
    } else if (indexPath.section >= 2) {
        ContactViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Contact"];
        if (controller != nil) {
            controller.type = indexPath.section - 2;
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            controller.name = cell.textLabel.text;
            controller.photo = cell.imageView.image;
            
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
}
*/

- (IBAction)addMemberAction:(id)sender
{
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactsNav"];
    if (navController != nil) {
        ContactsViewController *controller = (ContactsViewController *)navController.topViewController;
        if (controller != nil) {
            controller.navigationItem.title = @"增加群组成员";
            controller.mode = 1;
        }
        [self presentViewController: navController animated:YES completion:nil];
    }
}

@end
