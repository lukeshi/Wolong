//
//  EmergeView.m
//  ETP2012
//
//  Created by Shi Luke on 12-4-16.
//  Copyright (c) 2012年 OpenConcept Systems, Inc. All rights reserved.
//

#import "EmergeView.h"

@implementation EmergeView

- (id)initWithView:(UIView *)view
{
    self = [super initWithView:view];
    self.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark-white"]];
	
	// Set custom view mode
	self.mode = MBProgressHUDModeCustomView;
	self.delegate = self;
    
    return self;
}

- (void) show: (NSString *)message
{
    self.labelText = message;
	
	[super show:YES];
	[super hide:YES afterDelay:2];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
