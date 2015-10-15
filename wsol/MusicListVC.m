//
//  MusicListVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/11.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "MusicListVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import <BmobSDK/Bmob.h>
#import "Music.h"
#import "MusicTVC.h"
#import "AudioStreamer.h"
#import "Reachability.h"

@interface MusicListVC ()
{
    AudioStreamer *streamer;
}

@end

@implementation MusicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"游戏BGM音乐";
    self.navigationProtal = self;
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-20-20)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
  
    
    musics = [[NSMutableArray alloc] init];
    
    [self doHttp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Music"];
    bquery.limit = 1000;
    [bquery orderByAscending:@"musicId"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            [musics removeAllObjects];
            
            
            
            for (BmobObject *obj in array) {
                NSString *musicName = [obj objectForKey:@"musicName"];
                int musicId = [(NSNumber *)[obj objectForKey:@"musicId"] intValue];
                BmobFile *musicFile = [obj objectForKey:@"musicFile"];
                
                
                Music *music = [[Music alloc] initWithMusicFile:musicFile AndMusicName:musicName AndMusicId:musicId];
                [musics addObject:music];
            }
            //刷新表格控件
            [tableview reloadData];
            
            
        }
        
    }];
    
    
    
    
}

//返回多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [musics count];
}


//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Music *music = [musics objectAtIndex:[indexPath row]];
    return music.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    MusicTVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MusicTVC" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[MusicTVC class]]) {
                cell = (MusicTVC *)o;
                
                lb_content = [[UILabel alloc] init];
                lb_content.numberOfLines = 0;
                lb_content.textColor = [UIColor whiteColor];
                lb_content.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:lb_content];
                
                break;
            }
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    Music *music = [musics objectAtIndex:[indexPath row]];
    int h =music.contentHeight;
    
    [lb_content setFrame:CGRectMake(10, 10, 300, h)];
    lb_content.text = music.musicContent;
    
    
    
    
    return cell;
}





- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"游戏BMG音乐"];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"游戏BMG音乐"];
    [self destroyStreamer];
}

//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    willPlayMusic = [musics objectAtIndex:[indexPath row]];
    // 使用WiFi网络
    if ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable) {
        [self playMusic];
        return;
    }
    
    // 使用3G网络
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"当前没有连接wifi,将会消耗较多手机流量，确定需要继续听音乐吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alter show];
        return;
    }
    
    
    
    // 没有网络连接
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"当前没有连接任何网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
    
    
    
    
}


- (void)createStreamer:(NSString *)musicUrl
{
    [self destroyStreamer];
    
    NSString *escapedValue =
    ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                           nil,
                                                                           (CFStringRef)musicUrl,
                                                                           NULL,
                                                                           NULL,
                                                                           kCFStringEncodingUTF8)) ;
    ;
    NSURL *url = [NSURL URLWithString:escapedValue];
    streamer = [[AudioStreamer alloc] initWithURL:url];
    
    
}

- (void)destroyStreamer
{
    if (streamer)
    {
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:streamer];
        
        [streamer stop];
        streamer = nil;
    }
}


-(void)leftAction
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

-(void)rightAction
{
    [self doHttp];
}


/** 弹出框的按钮点击后响应的代理函数 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self playMusic];
    }
}

/** 执行播放音乐 */
-(void)playMusic
{
    [self destroyStreamer];
    [self createStreamer:willPlayMusic.musicFile.url];
    [streamer start];
}


@end
