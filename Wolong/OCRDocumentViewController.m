//
//  OCRDocumentViewController.m
//  Wolong
//
//  Created by Luke Shi on 4/9/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import "OCRDocumentViewController.h"
#import "DocumentViewController.h"

@interface OCRDocumentViewController ()

@end

@implementation OCRDocumentViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)ocrAction:(id)sender
{
    DocumentViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
    if (controller != nil) {
        controller.title = @"OCR生成文档";
        controller.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
