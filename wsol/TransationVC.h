//
//  TransationVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/2/10.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h"

@interface TransationVC : UIViewController<UITableViewDataSource,UITableViewDelegate,MLEmojiLabelDelegate>
{
    MLEmojiLabel *emojiLabel;
    UIActivityIndicatorView *activityIndicator;
    UITableView *tableView;
    NSMutableArray *transations;
    float headerHeight;
    NSString *headerStr;
}
@end
