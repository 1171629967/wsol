//
//  RenwuListVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/7/29.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"

@interface RenwuListVC : BaseViewController<NavigationProtal,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *renwus;
    UILabel *lb_content;
    UITableView *tableview;
}

@end
