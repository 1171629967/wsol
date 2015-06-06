//
//  PlayerNearbyVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/6/2.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"
#import "EGOImageView.h"
#import "CompletePersonInfoVC.h"

@interface PlayerNearbyVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,NavigationProtal>
{
    NSMutableArray *players;
    UITableView *tableview;
    EGOImageView* iv_face;
    UILabel *lb_address;
    CompletePersonInfoVC *completePersonInfoVC;
}

@end
