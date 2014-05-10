//
//  MessagesViewController.m
//  Wolong
//
//  Created by Luke Shi on 4/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import "MessagesViewController.h"
#import "ChatViewController.h"

@interface MessagesViewController ()

@end

@implementation MessagesViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *name = (UILabel *)[cell viewWithTag:1];
    name.text = [NSString stringWithFormat:@"朋友%d", (int)(indexPath.row+1)];
    
    UILabel *msg = (UILabel *)[cell viewWithTag:2];
    msg.text = [NSString stringWithFormat:@"信息%d: 麦金利山是这车上九成以上乘客的目标，快到的时候，大家的兴奋程度也渐渐开始增长。开车时候天气很沉闷，雨水串串，周围一片灰蒙蒙。云低低地压在树上，竟让我闷得难以透气。几小时的行车，人倦怠，视觉也开始疲劳，天却开始渐渐放晴。很快，窗外蓝天白云，原野变得极其广阔。当乘客们纷纷出到露天看台时，列车忽然开始减速。还以为是有人要上下车，耳边却传来列车员兴奋的声音.", (int)indexPath.row+1];
    
    UIImageView *photoView = (UIImageView *)[cell viewWithTag:10];
    photoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"user%d", (int)indexPath.row%6+1]];
    
    return cell;
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    UILabel *name = (UILabel *)[cell viewWithTag:1];
    
    ChatViewController *controller = [segue destinationViewController];
    controller.title = name.text;
    controller.userId = indexPath.row%6 + 1;
    controller.hidesBottomBarWhenPushed = YES;
}

//

- (IBAction)newChatAction:(id)sender
{
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactsNav"];
    if (navController != nil) {
        [self presentViewController: navController animated:YES completion:nil];
    }
}


@end
