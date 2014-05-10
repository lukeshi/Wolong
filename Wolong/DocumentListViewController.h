//
//  DocumentListViewController.h
//  Wolong
//
//  Created by Luke Shi on 4/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentListViewController : UITableViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    __weak IBOutlet UIBarButtonItem *addButtonItem;
    NSInteger rows;
}

- (IBAction)addDocAction:(id)sender;

@end
