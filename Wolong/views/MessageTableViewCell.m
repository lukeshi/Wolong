//
//  MessageTableViewCell.m
//  DelightMe
//
//  Created by Perry on 11-8-19.
//  Copyright 2011年 OpenConceptSystems, Inc. All rights reserved.
//

#import "MessageTableViewCell.h"

#define kAvatarTag 1
#define kBubbleTag 2
#define kSenderTag 3
#define kContentTag 4

static CGFloat const kContentFontSize = 14.0f;
static CGFloat const kContentTextWidth = 250.0f;

@implementation MessageTableViewCell

@synthesize avatar = _avatar;

- (void)setup
{
    UIImageView *avatar = [[UIImageView alloc] init];
    avatar.tag = kAvatarTag;
    [self addSubview:avatar];
    
    UIImageView *bubbleBackground = [[UIImageView alloc] init];
    bubbleBackground.tag = kBubbleTag;
    [self addSubview:bubbleBackground];
    
    UILabel *sender = [[UILabel alloc] init];
    sender.backgroundColor = [UIColor clearColor];
    sender.font = [UIFont systemFontOfSize:kContentFontSize];
    sender.textColor = [UIColor grayColor];
    sender.textAlignment = NSTextAlignmentRight;
    sender.tag = kSenderTag;
    [self addSubview:sender];
    
    UILabel *content = [[UILabel alloc] init];
    content.backgroundColor = [UIColor clearColor];
    content.tag = kContentTag;
    content.numberOfLines = 0;
    content.lineBreakMode = NSLineBreakByWordWrapping;
    content.font = [UIFont systemFontOfSize:kContentFontSize];
    [self addSubview:content];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

/*
- (void)setContactUser:(User *)contactUser
{
    if (_contactUser != contactUser)
    {
        [_contactUser release];
        _contactUser = [contactUser retain];
    }
}
*/

/*
- (void)setMsg:(Msg *)msg
{
    if (_msg != msg)
    {
        [_msg release];
        _msg = [msg retain];
        
        [(UILabel *)[self viewWithTag:kSenderTag] setText:[msg.sendTime substringToIndex:19]];
        [(UILabel *)[self viewWithTag:kContentTag] setText:msg.data];
        
        DelightMeAppDelegate *appDelegate = (DelightMeAppDelegate *)[[UIApplication sharedApplication] delegate];
        if ([msg.fromUserId isEqualToString:appDelegate.user.userId]) {
            [(UIImageView *)[self viewWithTag:kAvatarTag] setImage: [DataUtil getPeopleImage:appDelegate.user.icon]];
            [(UIImageView *)[self viewWithTag:kBubbleTag]
             setImage:[[UIImage imageNamed:@"chat-bubble-response"] stretchableImageWithLeftCapWidth:2 topCapHeight:10]];
        } else {
            [(UIImageView *)[self viewWithTag:kAvatarTag] setImage: [DataUtil getPeopleImage:_contactUser.icon]];
            [(UIImageView *)[self viewWithTag:kBubbleTag]
             setImage:[[UIImage imageNamed:@"chat-bubble"] stretchableImageWithLeftCapWidth:6 topCapHeight:10]];
        }
        [self setNeedsLayout];
    }
}
*/

- (void)setMsg:(NSString *)msg isResponse:(BOOL)resp photo:(UIImage *)image
{
    message = msg;
    isResponse = resp;
    photo = image;
    
    [(UILabel *)[self viewWithTag:kSenderTag] setText:@"12/30/13"];
    [(UILabel *)[self viewWithTag:kContentTag] setText:msg];
    
    if (isResponse) {
        [(UIImageView *)[self viewWithTag:kAvatarTag] setImage: photo];
        [(UIImageView *)[self viewWithTag:kBubbleTag]
         setImage:[[UIImage imageNamed:@"chat-bubble-response"] stretchableImageWithLeftCapWidth:4 topCapHeight:12]];
    } else {
        NSString *bubbleName = self.female ? @"chat-bubble-pink" : @"chat-bubble";
        [(UIImageView *)[self viewWithTag:kAvatarTag] setImage: photo];
        [(UIImageView *)[self viewWithTag:kBubbleTag]
         setImage:[[UIImage imageNamed:bubbleName] stretchableImageWithLeftCapWidth:8 topCapHeight:12]];
    }
    [self setNeedsLayout];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#define PHOTOSIZE   50.0

- (void)layoutSubviews
{
    CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:kContentFontSize]
                               constrainedToSize:CGSizeMake(kContentTextWidth, CGFLOAT_MAX)
                                   lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel *sender = (UILabel *)[self viewWithTag:kSenderTag];
    //CGSize size2 = [sender.text sizeWithFont:sender.font];
    CGSize size2 = [sender.text sizeWithAttributes:@{NSFontAttributeName:sender.font}];
    
    if (isResponse) {
        [(UIImageView *)[self viewWithTag:kAvatarTag]
         setFrame:CGRectMake(CGRectGetWidth(self.bounds)-PHOTOSIZE-5, 5, PHOTOSIZE, PHOTOSIZE)];
        
        [(UILabel *)[self viewWithTag:kSenderTag]
         setFrame:CGRectMake(CGRectGetWidth(self.bounds)-PHOTOSIZE-22-MAX(size.width, size2.width), 10, MAX(size.width, size2.width), 15)];
        [(UIImageView *)[self viewWithTag:kBubbleTag]
         setFrame:CGRectMake(CGRectGetWidth(self.bounds)-PHOTOSIZE-14-15-MAX(size.width, size2.width), 8,
                             MAX(size.width, size2.width)+20.0f, size.height+24.0f)];
        [(UILabel *)[self viewWithTag:kContentTag]
         setFrame:CGRectMake(CGRectGetWidth(self.bounds)-PHOTOSIZE-22-MAX(size.width, size2.width), 27, kContentTextWidth, size.height)];
    } else {
        [(UIImageView *)[self viewWithTag:kAvatarTag]
         setFrame:CGRectMake(5, 5, PHOTOSIZE, PHOTOSIZE)];
        
        [(UILabel *)[self viewWithTag:kSenderTag]
         setFrame:CGRectMake(PHOTOSIZE+25, 10, MAX(size.width, size2.width), 15)];
        [(UIImageView *)[self viewWithTag:kBubbleTag]
         setFrame:CGRectMake(PHOTOSIZE+14, 8,
                             MAX(size.width, size2.width)+20.0f, size.height+24.0f)];
        [(UILabel *)[self viewWithTag:kContentTag]
         setFrame:CGRectMake(PHOTOSIZE+25, 27, kContentTextWidth, size.height)];
    }
}

@end
