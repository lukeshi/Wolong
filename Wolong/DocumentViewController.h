//
//  DocumentViewController.h
//  Wolong
//
//  Created by Luke Shi on 4/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "EmergeView.h"
#import "CanvasView.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface DocumentViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate, UIAlertViewDelegate,
                                        MFMailComposeViewControllerDelegate, UINavigationControllerDelegate,
                                        UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UIDocumentInteractionControllerDelegate>
{
    __weak IBOutlet UIToolbar *toolbar;
    
    __weak IBOutlet UITextField *inputField;
    
    __weak IBOutlet UIWebView *contentView;
    __weak IBOutlet UIImageView *imgContentView;
    
    __weak IBOutlet UIImageView *stampView;
    __weak IBOutlet UIImageView *voiceView;
    __weak IBOutlet UIImageView *noteView;
    __weak IBOutlet UIImageView *scratchView;
    __weak IBOutlet UIImageView *picView;
    
    __weak IBOutlet UIImageView *picPopView;
    __weak IBOutlet UITextView *notePopView;
    __weak IBOutlet UILabel *stampPopView;
    
    NSString *content;
    
    EmergeView *emergeView;
    
    //CFURLRef		soundFileURLRef;
    //SystemSoundID	soundFileObject;
    
    NSInteger mode;
    
    __weak IBOutlet UIBarButtonItem *modeButton;
    
    __weak IBOutlet UIBarButtonItem *inputTextButton;
    __weak IBOutlet UIBarButtonItem *scratchButton;
    __weak IBOutlet UIBarButtonItem *voiceButton;
    __weak IBOutlet UIBarButtonItem *noteButton;
    __weak IBOutlet UIBarButtonItem *picButton;
    __weak IBOutlet UIBarButtonItem *stampButton;
    
    __weak IBOutlet CanvasView *canvas;
}

@property (nonatomic, assign) BOOL newDoc;
@property (nonatomic, assign) NSInteger mode;

@property (nonatomic, strong) UIDocumentInteractionController *dc;
@property (nonatomic, strong) UIImage *imageDoc;

@end
