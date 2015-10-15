//
//  ShowYijianVCTableViewController.h
//  wsol
//
//  Created by 王 李鑫 on 15/1/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ShowYijianVC : BaseViewController<NavigationProtal,UITableViewDataSource,UITableViewDelegate>
{
    
    
    NSMutableArray *yijians;
    UIImageView *iv_narrow;
    UILabel *lb_content;
    UITableView *tableview;
}

@end
