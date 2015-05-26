//
//  MusicListVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/5/11.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"
@class AudioStreamer;

@interface MusicListVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,NavigationProtal>
{

    NSMutableArray *musics;
    UILabel *lb_content;
    UITableView *tableview;
}

@end
