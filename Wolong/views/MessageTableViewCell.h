//
//  MessageTableViewCell.h
//

#import <UIKit/UIKit.h>
//#import "User.h"
//#import "Msg.h"

@interface MessageTableViewCell : UITableViewCell {
    NSString *message;
    BOOL isResponse;
    UIImage *photo;
}

@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, assign) BOOL female;

- (void)setMsg:(NSString *)msg isResponse:(BOOL)resp photo:(UIImage *)image;

@end
