//
//  CanvasView.h
//  Wolong
//
//  Created by Luke Shi on 5/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasView : UIView
{
    UIColor *strokeColor;
}

- (void)reset;
- (void)clear;

@end
