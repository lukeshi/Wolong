//
//  DocumentViewController.m
//  Wolong
//
//  Created by Luke Shi on 4/3/14.
//  Copyright (c) 2014 Luke Shi. All rights reserved.
//

#import "DocumentViewController.h"
#import "UIViewController+ModalCheck.h"
#import "DocumentLogViewController.h"

@interface DocumentViewController ()
{
    AVAudioPlayer *myAudioPlayer;
    BOOL playingAudio;
}

@end

@implementation DocumentViewController

@synthesize mode;
@synthesize dc;
@synthesize imageDoc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void) playSound
{
    AudioServicesPlaySystemSound (soundFileObject);
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    inputField.delegate = self;
    
    emergeView = [[EmergeView alloc] initWithView:self.view];
    [self.view addSubview:emergeView];
    
    self.hidesBottomBarWhenPushed = YES;
    
    picPopView.hidden = notePopView.hidden = stampPopView.hidden = YES;
    
    [self loadContent:@""];
    
    UITapGestureRecognizer *noteTapRecon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNoteAction:)];
    noteTapRecon.numberOfTapsRequired = 1;
    [noteView addGestureRecognizer:noteTapRecon];
    
    noteTapRecon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNoteAction:)];
    noteTapRecon.numberOfTapsRequired = 1;
    [notePopView addGestureRecognizer:noteTapRecon];
    
    UITapGestureRecognizer *voiceTapRecon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVoiceAction:)];
    voiceTapRecon.numberOfTapsRequired = 1;
    [voiceView addGestureRecognizer:voiceTapRecon];
    
    UITapGestureRecognizer *picTapRecon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicAction:)];
    picTapRecon.numberOfTapsRequired = 1;
    [picView addGestureRecognizer:picTapRecon];
    
    picTapRecon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePicAction:)];
    picTapRecon.numberOfTapsRequired = 1;
    [picPopView addGestureRecognizer:picTapRecon];
    
    UITapGestureRecognizer *stampTapRecon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showStampAction:)];
    stampTapRecon.numberOfTapsRequired = 1;
    [stampView addGestureRecognizer:stampTapRecon];
    
    stampTapRecon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideStampAction:)];
    stampTapRecon.numberOfTapsRequired = 1;
    [stampPopView addGestureRecognizer:stampTapRecon];
    
    //
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(stampAction:)];
    swipe.numberOfTouchesRequired = 1;
    [swipe setDirection: UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight];
    [stampView addGestureRecognizer:swipe];
    
    //
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(noteMoveAction:)];
    [noteView addGestureRecognizer:pan];
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(picMoveAction:)];
    [picView addGestureRecognizer:pan];
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(voiceMoveAction:)];
    [voiceView addGestureRecognizer:pan];
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(stampMoveAction:)];
    [stampView addGestureRecognizer:pan];
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(inputTextMoveAction:)];
    [inputField addGestureRecognizer:pan];
    
    //
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"audio" ofType: @"m4r"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
    myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    myAudioPlayer.numberOfLoops = 1;
}

//

- (void)noteMoveAction:(id)sender
{
    [self moveView:noteView with:sender];
}

- (void)picMoveAction:(id)sender
{
    [self moveView:picView with:sender];
}

- (void)voiceMoveAction:(id)sender
{
    [self moveView:voiceView with:sender];
}

- (void)stampMoveAction:(id)sender
{
    [self moveView:stampView with:sender];
}

- (void)inputTextMoveAction:(id)sender
{
    [self moveView:inputField with:sender];
}

- (void)moveView: (UIView *)uiView with: (UIPanGestureRecognizer *)pan
{
    CGPoint p = [pan locationInView:self.view];
    CGRect rect = uiView.frame;
    uiView.frame = CGRectMake(p.x-rect.size.width/2, p.y-rect.size.height/2, rect.size.width, rect.size.height);
}

//

- (void)showStampAction:(id)sender
{
    stampPopView.hidden = !stampPopView.hidden;
}

- (void)hideStampAction:(id)sender
{
    stampPopView.hidden = YES;
}

- (void)showPicAction:(id)sender
{
    picPopView.hidden = !picPopView.hidden;
}

- (void)hidePicAction:(id)sender
{
    picPopView.hidden = YES;
}

- (void)showNoteAction:(id)sender
{
    notePopView.hidden = !notePopView.hidden;
}

- (void)hideNoteAction:(id)sender
{
    notePopView.hidden = YES;
}

- (void)playVoiceAction:(id)sender
{
    if (playingAudio) {
        voiceView.image = [UIImage imageNamed:@"sound"];
        [myAudioPlayer stop];
    } else {
        voiceView.image = [UIImage imageNamed:@"sound-on"];
        [myAudioPlayer play];
    }
    playingAudio = !playingAudio;
}

//

- (void) loadContent: (NSString *)header
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"linbiao" ofType:@"html"];
    
    if (content.length == 0) {
        content = [NSString stringWithContentsOfFile:path
                                            encoding:NSUTF8StringEncoding
                                               error:NULL];
    }
    
    content = [NSString stringWithFormat:@"%@%@", header, content];
    
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    [contentView loadHTMLString: content
                        baseURL: targetURL];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self isPresentedAsModal]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                              target:self
                                                                                              action:@selector(dismissAction:)];
    }
    
    if (mode == 0) {
        stampView.hidden = voiceView.hidden = picView.hidden = noteView.hidden = scratchView.hidden = inputField.hidden = YES;
        stampButton.enabled = scratchButton.enabled = picButton.enabled = voiceButton.enabled = noteButton.enabled = inputTextButton.enabled = YES;
        [modeButton setTitle:@"显示"];
        [canvas clear];
        [canvas reset];
        //canvas.hidden = NO;
    } else {
        stampView.hidden = voiceView.hidden = picView.hidden = noteView.hidden = scratchView.hidden = inputField.hidden = NO;
        stampButton.enabled = scratchButton.enabled = picButton.enabled = voiceButton.enabled = noteButton.enabled = inputTextButton.enabled = NO;
        [modeButton setTitle:@"签批"];
        //canvas.hidden = YES;
    }
    
    if (self.newDoc) {
        contentView.hidden = YES;
    } else {
        if (self.imageDoc != nil) {
            contentView.hidden = YES;
            imgContentView.image = imageDoc;
        } else {
            contentView.hidden = NO;
            imgContentView.image = nil;
        }
    }
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

- (UIImage *) screenshot {
    //UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    CGSize size = self.view.bounds.size;
    size.height -= 44.0;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactsNav"];
            if (navController != nil) {
                [self presentViewController: navController animated:YES completion:nil];
            }
        } else if (buttonIndex == 1) {
            // My Documents
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"请输入文档名"
                                                              message:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"提交", nil];
            
            [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [message textFieldAtIndex:0].text = self.navigationItem.title;
            [message show];
        } else if (buttonIndex == 2) {
            [self.navigationController popViewControllerAnimated:YES];
        } else if (buttonIndex == 3) {
            UIImage *shot = [self screenshot];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent: [NSString stringWithFormat:@"%@Img.jpg", self.navigationItem.title]];
            
            // Save image.
            [UIImageJPEGRepresentation(shot, 0.7) writeToFile:path atomically:YES];
            //[UIImagePNGRepresentation(shot) writeToFile:path atomically:YES];
            NSURL *targetURL = [NSURL fileURLWithPath:path];
        
            self.dc = [UIDocumentInteractionController interactionControllerWithURL:targetURL];
            dc.delegate = self;
            [dc presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        } else if (buttonIndex == 4) {
            DocumentLogViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DocLog"];
            if (controller != nil) {
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
    } else if (actionSheet.tag == 2) {
        if (buttonIndex == 0) {
            stampView.hidden = NO;
            stampView.image = [UIImage imageNamed:@"signature"];
        } else if (buttonIndex == 3) {
            stampView.hidden = NO;
            stampView.image = [UIImage imageNamed:@"stamp"];
        }
    } else if (actionSheet.tag == 3) {
        if (buttonIndex == 0) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        } else if (buttonIndex == 1) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        //if (buttonIndex < 2)
        //    [self addPhoto];
    }
}

//

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//

- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

//

- (IBAction)sendAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Send Document"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"我的联系人",
                                                                      @"我的文档",
                                                                      @"原发件人",
                                                                      @"其它应用...",
                                                                      @"文档流转记录",
                                                                      nil];
    actionSheet.tag = 1;
    actionSheet.title = @"发送/保存文档到";
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

/*
- (IBAction)noteAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Make Note"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"手写标注",
                                                                      @"语音标注",
                                                                      @"文本标注",
                                                                      @"图像标注",
                                                                      nil];
    actionSheet.tag = 2;
    actionSheet.title = nil;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
*/

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneAction:(id)sender {
    if ([self isPresentedAsModal]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//

- (IBAction)inputTextAction:(id)sender
{
    inputField.hidden = !inputField.hidden;
    if (inputField.hidden) {
        [inputField resignFirstResponder];
    } else {
        [inputField becomeFirstResponder];
    }
}

- (IBAction)favoriteAction:(id)sender
{
    [emergeView show: @"收藏成功"];
}

- (IBAction)stampAction:(id)sender
{
    stampView.hidden = !stampView.hidden;
}

- (IBAction)scratchAction:(id)sender
{
    scratchView.hidden = !scratchView.hidden;
}

- (IBAction)voiceAction:(id)sender
{
    voiceView.hidden = !voiceView.hidden;
}

- (IBAction)picAction:(id)sender
{
    picView.hidden = !picView.hidden;
}

- (IBAction)noteAction:(id)sender
{
    noteView.hidden = !noteView.hidden;
}

- (IBAction)modeAction:(id)sender
{
    if (mode == 0) {
        mode = 1;
    } else {
        mode = 0;
    }
    
    [self viewWillAppear:YES];
}

- (IBAction)imageAction:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照片",
                                                                      @"从相册读入",
                                                                      nil];
    actionSheet.tag = 3;
    actionSheet.title = @"插入图片/视频";
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void) addPhoto
{
    [self loadContent:@"<img src='lin_biao.jpg' width=100><br>"];
}

- (IBAction)textAction:(id)sender
{
    [self loadContent:@"<br>"];
    [inputField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[self loadContent:[NSString stringWithFormat:@"<span style='font-family:arial; font-size:10pt;'>%@</span>", textField.text]];
    //textField.text = @"";
    [inputField resignFirstResponder];
    return YES;
}

//

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //
    [self dismissViewControllerAnimated:YES completion:nil];
}

//

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    // Dismiss the image selection, hide the picker and show the image view with the picked image
    [self addPhoto];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
