//
//  TransationVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/2/10.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h"
#import "BaseViewController.h"

@interface TransationVC : BaseViewController<NavigationProtal,UITableViewDataSource,UITableViewDelegate,MLEmojiLabelDelegate>
{
    MLEmojiLabel *emojiLabel;
  
    UITableView *tableView;
    NSMutableArray *transations;
    float headerHeight;
    NSString *headerStr;
}
@end
