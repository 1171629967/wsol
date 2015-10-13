//
//  YijianReplyVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/10/13.
//  Copyright © 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"

@interface YijianReplyVC : BaseViewController<NavigationProtal,UITextViewDelegate>
{
    UITextView *tv_content;
    UILabel *label;
}

@property (copy, nonatomic) NSString *replyId;


@end
