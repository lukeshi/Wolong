//
//  DocumentListViewController.m
//  Wolong
//
//  Created by Luke Shi on 4/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import "DocumentListViewController.h"
#import "DocumentViewController.h"
#import "UIViewController+ModalCheck.h"
#import "NewDocumentViewController.h"

@interface DocumentListViewController ()

@end

@implementation DocumentListViewController

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
    
    rows = 4;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self isPresentedAsModal]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                               target:self
                                                                                               action:@selector(dismissAction:)];
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
    return 26;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *docName = (UILabel *)[cell viewWithTag:1];
    docName.text = [NSString stringWithFormat:@"%c文档-%d", (char)('A'+indexPath.section), (int)indexPath.row+1];
    
    UILabel *dateNtype = (UILabel *)[cell viewWithTag:2];
    dateNtype.text = [NSString stringWithFormat:@"12/%d/2013", (int)indexPath.row+1];
    
    UILabel *brief = (UILabel *)[cell viewWithTag:3];
    brief.text = @"当一切做好了准备，按照上述的要求广播了两天之后，出人预料的情况仍没有发生。如前所述，一切立足于公开，一切立足于出现最坏的情况，但使人迷惑不解的是一直没有收听到林彪抵达莫斯科的任何消息。苏联和世界舆论竟如此平静，这是怎么一回事？是林彪没有到莫斯科，还是在玩弄什么花招？就当时中苏的紧张关系而言，苏联绝不会缄口不言，不会放弃这一大做文章的时机。这葫芦里到底卖的是什么药？";
    
    UIImageView *iconView = (UIImageView *)[cell viewWithTag:10];
    iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"filetype%d", (int)(indexPath.row+rows)%4+1]];
    
    //CGRect rect = brief.frame;
    //brief.frame = CGRectMake(rect.origin.x, rect.origin.y, tableView.frame.size.width-100, rect.size.height);
    
    return cell;
}

#define HEADER_HEIGHT 20.0

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, HEADER_HEIGHT)];
    headerView.backgroundColor = [UIColor colorWithRed:0.83 green:0.86 blue:0.89 alpha:1.0];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, tableView.frame.size.width-20, HEADER_HEIGHT-2)];
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:13];
    headerLabel.text = [NSString stringWithFormat: @"%c", (char)('A'+section)];
    [headerView addSubview:headerLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADER_HEIGHT;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexTitles = [NSMutableArray arrayWithCapacity:26];
    for (int i = 0; i < 26; i++) {
        [indexTitles addObject: [NSString stringWithFormat: @"%c", 'A'+i]];
    }
    return indexTitles;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DocumentViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
    if (controller != nil) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        UILabel *name = (UILabel *)[cell viewWithTag:1];
        controller.title = name.text;
        controller.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:controller animated:YES];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    UILabel *name = (UILabel *)[cell viewWithTag:1];
    
    DocumentViewController *controller = [segue destinationViewController];
    controller.title = name.text;
    controller.hidesBottomBarWhenPushed = YES;
}
*/

//

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            UINavigationController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NewDocNav"];
            if (controller != nil) {
                //controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }
        } else if (buttonIndex == 1) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    } else if (actionSheet.tag == 2) {
        /*
        if (buttonIndex == 3) {
            self.navigationItem.title = @"我的收藏";
            rows = 2;
        } else {
            self.navigationItem.title = @"我的文档";
            rows = 4;
        }
        [self.tableView reloadData];
        */
    }
}

- (IBAction)addDocAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Document From"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"创建新文档",
                                                                      @"从相册读入",
                                                                      @"从DropBox读入",
                                                                      @"从Google Drive读入",
                                                                      @"从百度云读入",
                                                                      nil];
    actionSheet.tag = 1;
    actionSheet.title = @"增加文档";
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)optionAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"按文档名排序",
                                                                      @"按时间排序",
                                                                      @"按类型排序",
                                                                      nil];
    actionSheet.tag = 2;
    actionSheet.title = nil;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

//

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    // Dismiss the image selection, hide the picker and show the image view with the picked image
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
