//
//  ChatViewController.m
//  Wolong
//
//  Created by Luke Shi on 4/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageTableViewCell.h"
#import "DocumentViewController.h"
#import "DocumentListViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

@synthesize userId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    
    inputField.returnKeyType = UIReturnKeySend;
    
    emergeView = [[EmergeView alloc] initWithView:self.view];
    [self.view addSubview:emergeView];
    
    [self registerForKeyboardNotifications];
    
    newMsgs = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShown:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    NSValue* value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [self moveViewsUp: keyboardSize.height];
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    //
}

- (void) resetViews
{
    inputField.text = @"";
    
    myTableView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height-inputView.frame.size.height-1);
    inputView.frame = CGRectMake(0.0, self.view.frame.size.height-inputView.frame.size.height,
                                 self.view.frame.size.width, inputView.frame.size.height);
    [self.view endEditing:YES];
}

- (void) moveViewsUp: (CGFloat) height
{
    myTableView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height-height-inputView.frame.size.height-1);
    inputView.frame = CGRectMake(0.0, self.view.frame.size.height-height-inputView.frame.size.height,
                                 self.view.frame.size.width, inputView.frame.size.height);
    [myTableView scrollRectToVisible:CGRectMake(0, myTableView.contentSize.height - myTableView.bounds.size.height,
                                                myTableView.bounds.size.width, myTableView.bounds.size.height) animated:YES];
}

#pragma mark - Table view data source

#define TOTAL_FAKE  16

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return TOTAL_FAKE + newMsgs.count;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = @"Message";
    
    return cell;
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    CGSize size = [@"Hello"
                   sizeWithFont:[UIFont systemFontOfSize:13]
                   constrainedToSize:CGSizeMake(200, CGFLOAT_MAX)
                   lineBreakMode:NSLineBreakByWordWrapping];
    */
    
    NSString *text = @"The text that I want to wrap in a table cell.";
    UIFont *font = [UIFont systemFontOfSize:13.0];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){200.0, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return MAX(size.height+30, 66);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (userId % 2 == 0) {
        cell.female = YES;
    }
    
    if (indexPath.row < TOTAL_FAKE) {
        if (indexPath.row % 2 == 0) {
            [cell setMsg:[NSString stringWithFormat:@"Document %d.doc", (int)indexPath.row+1]
              isResponse:NO
                   photo:[UIImage imageNamed: [NSString stringWithFormat: @"user%ld", (long)userId] ] ];
        } else {
            [cell setMsg:[NSString stringWithFormat:@"Presenation %d.ppt", (int)indexPath.row+1]  isResponse:YES photo:[UIImage imageNamed:@"user7"]];
        }
    } else {
        NSString *msg = [newMsgs objectAtIndex:indexPath.row-TOTAL_FAKE];
        [cell setMsg: msg isResponse:YES photo:[UIImage imageNamed:@"user7"]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"DocumentNav"];
    if (navController != nil) {
        DocumentViewController *controller = (DocumentViewController *)navController.topViewController;
        controller.mode = 1;
        [self presentViewController: navController animated:YES completion:nil];
    }
    */
    
    DocumentViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
    if (controller != nil) {
        controller.mode = 1;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"DocListNav"];
            if (navController != nil) {
                DocumentListViewController *controller = (DocumentListViewController *)navController.topViewController;
                controller.navigationItem.title = @"我的文档";
                [self presentViewController: navController animated:YES completion:nil];
            }
        }
    }
}

- (IBAction)getDocAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Get Document"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"从我的文档读入",
                                                                      @"从相册读入",
                                                                      @"从DropBox读入",
                                                                      @"从Google Drive读入",
                                                                      @"从百度云读入",
                                                                      nil];
    actionSheet.tag = 1;
    actionSheet.title = @"读入文档";
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

//

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [newMsgs addObject:textField.text];
    [textField resignFirstResponder];
    [myTableView reloadData];
    [self resetViews];
    return YES;
}

//

- (IBAction)photoAction:(id)sender
{
    //
}

- (IBAction)favoriteAction:(id)sender
{
    [emergeView show: @"收藏成功"];
}

- (IBAction)voiceAction:(id)sender
{
    if (inputField.enabled) {
        [self resetViews];
        inputField.text = @"Hold To Talk";
        inputField.enabled = NO;
        inputField.backgroundColor = [UIColor lightGrayColor];
        inputField.textAlignment = NSTextAlignmentCenter;
        [inputButton setBackgroundImage:[UIImage imageNamed:@"paw"] forState:UIControlStateNormal];
    } else {
        inputField.text = @"";
        inputField.enabled = YES;
        inputField.backgroundColor = [UIColor whiteColor];
        inputField.textAlignment = NSTextAlignmentLeft;
        [inputButton setBackgroundImage:[UIImage imageNamed:@"microphone"] forState:UIControlStateNormal];
    }
}

@end
