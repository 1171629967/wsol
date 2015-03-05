//
//  MusicListVCTableViewController.h
//  wsol
//
//  Created by 王 李鑫 on 15/2/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AudioStreamer;

@interface MusicListVCTableViewController : UITableViewController
{
    UIActivityIndicatorView *activityIndicator;
    NSMutableArray *musics;
    UILabel *lb_content;
}

@end
