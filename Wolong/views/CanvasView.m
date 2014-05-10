//
//  CanvasView.m
//  Wolong
//
//  Created by Luke Shi on 5/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView
{
    UIBezierPath *path; // (3)
}

- (id)initWithCoder:(NSCoder *)aDecoder // (1)
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO]; // (2)
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self reset];
    }
    return self;
}

- (void)reset
{
    path = [UIBezierPath bezierPath];
    [path setLineWidth:2.0];
    strokeColor = [UIColor redColor];
}

- (void)drawRect:(CGRect)rect // (5)
{
    [strokeColor setStroke];
    [path stroke];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path moveToPoint:p];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path addLineToPoint:p]; // (4)
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)clear
{
    strokeColor = [UIColor clearColor];
    [self setNeedsDisplay];
}

//

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
