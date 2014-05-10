//
//  EmergeView.h
//  ETP2012
//
//  Created by Shi Luke on 12-4-16.
//  Copyright (c) 2012年 OpenConcept Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface EmergeView : MBProgressHUD <MBProgressHUDDelegate> {
    //UILabel *msgLabel;
}

- (void)show: (NSString *)message;

@end
