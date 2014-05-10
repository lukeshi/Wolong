//
//  ChatViewController.h
//  Wolong
//
//  Created by Luke Shi on 4/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmergeView.h"

@interface ChatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UITextFieldDelegate>
{
    __weak IBOutlet UITableView *myTableView;
    __weak IBOutlet UIView *inputView;
    __weak IBOutlet UITextField *inputField;
    __weak IBOutlet UIButton *inputButton;
    
    EmergeView *emergeView;
    
    NSMutableArray *newMsgs;
}

@property (nonatomic) NSInteger userId;

@end
