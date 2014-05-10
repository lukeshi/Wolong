//
//  ContactViewController.h
//  Wolong
//
//  Created by Luke Shi on 4/4/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UITableViewController
{
    __weak IBOutlet UIImageView *photoView;
    __weak IBOutlet UILabel *nameLabel;
}

@property (nonatomic, weak) UIImage *photo;
@property (nonatomic, weak) NSString *name;
@property (nonatomic) NSInteger type;

@end
