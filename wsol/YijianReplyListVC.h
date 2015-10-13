//
//  YijianReplyVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/10/10.
//  Copyright © 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"

@interface YijianReplyListVC : BaseViewController<NavigationProtal,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *replys;
    UILabel *lb_content;
    UITableView *tableview;
    
}

@property (copy, nonatomic) NSString *replyId;

@end
