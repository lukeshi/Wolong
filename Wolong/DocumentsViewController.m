//
//  DocumentsViewController.m
//  Wolong
//
//  Created by Luke Shi on 5/1/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import "DocumentsViewController.h"
#import "DocumentListViewController.h"
#import "DocumentViewController.h"

@interface DocumentsViewController ()

@end

@implementation DocumentsViewController

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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"我的文档";
        cell.imageView.image = [UIImage imageNamed:@"shoebox"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"收到的文档";
        cell.imageView.image = [UIImage imageNamed:@"download"];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"发出的文档";
        cell.imageView.image = [UIImage imageNamed:@"upload"];
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"我的收藏";
        cell.imageView.image = [UIImage imageNamed:@"star"];
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"新建/读入文档";
        cell.imageView.image = [UIImage imageNamed:@"notepad"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < 4) {
        DocumentListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DocList"];
        if (controller != nil) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            controller.title = cell.textLabel.text;
            [self.navigationController pushViewController:controller animated:YES];
        }
    } else {
        [self addDocAction:tableView];
    }
}

- (IBAction)addDocAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Load Document From"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"新空白文档",
                                                                      @"从相册读入",
                                                                      @"从DropBox读入",
                                                                      @"从Google Drive读入",
                                                                      @"从百度云读入",
                                                                      nil];
    actionSheet.tag = 1;
    actionSheet.title = @"新建/读入文档";
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            DocumentViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
            if (controller != nil) {
                controller.title = @"新文档";
                controller.hidesBottomBarWhenPushed = YES;
                controller.newDoc = YES;
                
                [self.navigationController pushViewController:controller animated:YES];
            }
        } else if (buttonIndex == 1) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    DocumentListViewController *controller = [segue destinationViewController];
    controller.title = cell.textLabel.text;
}
*/

//

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    // Dismiss the image selection, hide the picker and show the image view with the picked image
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    DocumentViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
    if (controller != nil) {
        controller.title = @"图片文档";
        controller.hidesBottomBarWhenPushed = YES;
        controller.imageDoc = image;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
