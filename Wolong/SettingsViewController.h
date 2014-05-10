//
//  SettingsViewController.h
//  Wolong
//
//  Created by Luke Shi on 4/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    __weak IBOutlet UIImageView *photoView;
}

@end
