//
//  NeizhengdengjiVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/1/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeizhengdengjiVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
    NSArray *neizhengDataArray;
    
}

@end
