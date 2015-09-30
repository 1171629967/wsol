//
//  RenwuDetailVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/8/8.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "RenwuDetailVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import <BmobSDK/Bmob.h>
#import "Masonry.h"

@interface RenwuDetailVC ()

@end

@implementation RenwuDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"任务详情";
    self.navigationProtal = self;
    
    //左上角返回按钮白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self doHttp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"RenwuDetail"];
    [bquery whereKey:@"renwuId" equalTo:[NSNumber numberWithInt:self.renwuId]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            BmobObject *obj = [array objectAtIndex:0];
            
            NSString *renwuName = [obj objectForKey:@"renwuName"];
            NSString *renwuBeizhu = [obj objectForKey:@"renwuBeizhu"];
            NSString *renwuLevel = [obj objectForKey:@"renwuLevel"];
            NSString *renwuPeopleCount = [NSString stringWithFormat:@"%@",[obj objectForKey:@"renwuPeopleCount"]];
            NSString *renwuJiaofu = [obj objectForKey:@"renwuJiaofu"];
            NSString *renwuMap = [obj objectForKey:@"renwuMap"];
            NSString *renwuZhifa = [obj objectForKey:@"renwuZhifa"];
            NSString *renwuGetDaoju = [obj objectForKey:@"renwuGetDaoju"];
            NSString *shangyePoint = [NSString stringWithFormat:@"%@",[obj objectForKey:@"shangyePoint"]];
            NSString *liutongPoint = [NSString stringWithFormat:@"%@",[obj objectForKey:@"liutongPoint"]];
            NSString *jishuPoint = [NSString stringWithFormat:@"%@",[obj objectForKey:@"jishuPoint"]];
            NSString *junshiPoint = [NSString stringWithFormat:@"%@",[obj objectForKey:@"junshiPoint"]];
            NSString *zhianPoint = [NSString stringWithFormat:@"%@",[obj objectForKey:@"zhianPoint"]];
            NSString *junfeiPoint = [NSString stringWithFormat:@"%@",[obj objectForKey:@"junfeiPoint"]];


            //事先移除掉所有控件
            for (UIView *view in [self.view subviews]) {
                [view removeFromSuperview];
            }
        
            
            /** ------------动态布局控件 start---------- */
            scrollView  = [UIScrollView new];
            [self.view addSubview:scrollView];
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
                
            }];
            //任务名称
            lb_renwuName = [UILabel new];
            lb_renwuName.textAlignment = NSTextAlignmentCenter;
            lb_renwuName.font = [UIFont systemFontOfSize: 20.0];
            lb_renwuName.text = renwuName;
            [lb_renwuName setTextColor:[UIColor whiteColor]];
            [scrollView addSubview:lb_renwuName];
            [lb_renwuName mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).with.offset(20);
                make.top.equalTo(scrollView).with.offset(20);
                make.width.equalTo(scrollView).with.offset(-40);
            }];
            
            
            //任务备注
            BOOL isBeizhuNull;
            if (renwuBeizhu.length == 0) {
                isBeizhuNull = YES;
            }
            else {
                isBeizhuNull = NO;
                //有备注，所以需要加入任务备注控件
                lb_renwuBeizhu = [UILabel new];
                [scrollView addSubview:lb_renwuBeizhu];
                
                UIFont *font = [UIFont systemFontOfSize:14.0f];
                NSString *finalRenwuBeizhu = [NSString stringWithFormat:@"备注:  %@",renwuBeizhu];
                lb_renwuBeizhu.textAlignment = NSTextAlignmentCenter;
                lb_renwuBeizhu.font = font;
                lb_renwuBeizhu.text = finalRenwuBeizhu;
                lb_renwuBeizhu.textColor = [UIColor orangeColor];
                lb_renwuBeizhu.numberOfLines = 0;
                [lb_renwuBeizhu setLineBreakMode:NSLineBreakByCharWrapping];
                [lb_renwuBeizhu mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(lb_renwuName);
                    make.left.equalTo(lb_renwuName);
                    make.top.mas_equalTo(lb_renwuName.mas_bottom).with.offset(10);
                }];
            }
            
            //任务等级
            lb_renwuLevel = [UILabel new];
            [scrollView addSubview:lb_renwuLevel];
            lb_renwuLevel.font = [UIFont systemFontOfSize: 14.0];
            lb_renwuLevel.text = [NSString stringWithFormat:@"任务等级：  %@",renwuLevel];
            [lb_renwuLevel setTextColor:[UIColor whiteColor]];
            [lb_renwuLevel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).with.offset(20);
                make.width.equalTo(scrollView).with.offset(-40);
                if (isBeizhuNull) {
                    make.top.mas_equalTo(lb_renwuName.mas_bottom).with.offset(30);
                }
                else {
                    make.top.mas_equalTo(lb_renwuBeizhu.mas_bottom).with.offset(30);
                }
            }];

            //任务人数
            lb_renwuPeopleCount = [UILabel new];
            [scrollView addSubview:lb_renwuPeopleCount];
            lb_renwuPeopleCount.font = [UIFont systemFontOfSize: 14.0];
            lb_renwuPeopleCount.text = [NSString stringWithFormat:@"任务人数：  %@",renwuPeopleCount];
            [lb_renwuPeopleCount setTextColor:[UIColor whiteColor]];
            [lb_renwuPeopleCount mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).with.offset(20);
                make.width.equalTo(scrollView).with.offset(-40);
                make.top.mas_equalTo(lb_renwuLevel.mas_bottom).with.offset(10);
            }];

            //任务交付NPC
            lb_renwuJiaofu = [UILabel new];
            [scrollView addSubview:lb_renwuJiaofu];
            lb_renwuJiaofu.font = [UIFont systemFontOfSize: 14.0];
            lb_renwuJiaofu.text = [NSString stringWithFormat:@"任务交付：  %@",renwuJiaofu];
            [lb_renwuJiaofu setTextColor:[UIColor whiteColor]];
            [lb_renwuJiaofu mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).with.offset(20);
                make.width.equalTo(scrollView).with.offset(-40);
                make.top.mas_equalTo(lb_renwuPeopleCount.mas_bottom).with.offset(10);
            }];
            
            //任务地图
            lb_renwuMap = [UILabel new];
            [scrollView addSubview:lb_renwuMap];
            lb_renwuMap.font = [UIFont systemFontOfSize: 14.0];
            lb_renwuMap.text = [NSString stringWithFormat:@"任务地图：  %@",renwuMap];
            [lb_renwuMap setTextColor:[UIColor whiteColor]];
            [lb_renwuMap mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).with.offset(20);
                make.width.equalTo(scrollView).with.offset(-40);
                make.top.mas_equalTo(lb_renwuJiaofu.mas_bottom).with.offset(10);
            }];

            //任务制法
            lb_renwuZhifa = [UILabel new];
            [scrollView addSubview:lb_renwuZhifa];
            lb_renwuZhifa.font = [UIFont systemFontOfSize: 14.0];
            lb_renwuZhifa.text = [NSString stringWithFormat:@"任务制法：  %@",renwuZhifa];
            [lb_renwuZhifa setTextColor:[UIColor whiteColor]];
            [lb_renwuZhifa mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).with.offset(20);
                make.width.equalTo(scrollView).with.offset(-40);
                make.top.mas_equalTo(lb_renwuMap.mas_bottom).with.offset(10);
            }];
            
            //S任务道具
            lb_renwuGetDaoju = [UILabel new];
            [scrollView addSubview:lb_renwuGetDaoju];
            lb_renwuGetDaoju.font = [UIFont systemFontOfSize: 14.0];
            lb_renwuGetDaoju.text = [NSString stringWithFormat:@"S任务道具:  %@",renwuGetDaoju];
            lb_renwuGetDaoju.textColor = [UIColor whiteColor];
            lb_renwuGetDaoju.numberOfLines = 0;
            [lb_renwuGetDaoju setLineBreakMode:NSLineBreakByCharWrapping];
            [lb_renwuGetDaoju mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).with.offset(20);
                make.width.equalTo(scrollView).with.offset(-40);
                make.top.mas_equalTo(lb_renwuZhifa.mas_bottom).with.offset(10);
            }];
            
            //奖励文案
            
            //商业
            lb_shangye = [UILabel new];
            [scrollView addSubview:lb_shangye];
            lb_shangye.font = [UIFont systemFontOfSize: 14.0];
            lb_shangye.text = @"商业";
            lb_shangye.textAlignment = NSTextAlignmentCenter;
            lb_shangye.textColor = [UIColor whiteColor];
            [lb_shangye mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).with.offset(20);
                make.width.mas_equalTo(@((SCREEN_WIDTH-40)/6));
                make.top.mas_equalTo(lb_renwuGetDaoju.mas_bottom).with.offset(20);
            }];
            //流通
            lb_liutong = [UILabel new];
            [scrollView addSubview:lb_liutong];
            lb_liutong.font = [UIFont systemFontOfSize: 14.0];
            lb_liutong.text = @"流通";
            lb_liutong.textAlignment = NSTextAlignmentCenter;
            lb_liutong.textColor = [UIColor whiteColor];
            [lb_liutong mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_shangye.mas_right);
                make.width.mas_equalTo(@((SCREEN_WIDTH-40)/6));
                make.top.mas_equalTo(lb_renwuGetDaoju.mas_bottom).with.offset(20);
            }];
            //技术
            lb_jishu = [UILabel new];
            [scrollView addSubview:lb_jishu];
            lb_jishu.font = [UIFont systemFontOfSize: 14.0];
            lb_jishu.text = @"技术";
            lb_jishu.textAlignment = NSTextAlignmentCenter;
            lb_jishu.textColor = [UIColor whiteColor];
            [lb_jishu mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_liutong.mas_right);
                make.width.mas_equalTo(@((SCREEN_WIDTH-40)/6));
                make.top.mas_equalTo(lb_renwuGetDaoju.mas_bottom).with.offset(20);
            }];
            //军事
            lb_junshi = [UILabel new];
            [scrollView addSubview:lb_junshi];
            lb_junshi.font = [UIFont systemFontOfSize: 14.0];
            lb_junshi.text = @"军事";
            lb_junshi.textAlignment = NSTextAlignmentCenter;
            lb_junshi.textColor = [UIColor whiteColor];
            [lb_junshi mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_jishu.mas_right);
                make.width.mas_equalTo(@((SCREEN_WIDTH-40)/6));
                make.top.mas_equalTo(lb_renwuGetDaoju.mas_bottom).with.offset(20);
            }];
            //治安
            lb_zhian = [UILabel new];
            [scrollView addSubview:lb_zhian];
            lb_zhian.font = [UIFont systemFontOfSize: 14.0];
            lb_zhian.text = @"治安";
            lb_zhian.textAlignment = NSTextAlignmentCenter;
            lb_zhian.textColor = [UIColor whiteColor];
            [lb_zhian mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_junshi.mas_right);
                make.width.mas_equalTo(@((SCREEN_WIDTH-40)/6));
                make.top.mas_equalTo(lb_renwuGetDaoju.mas_bottom).with.offset(20);
            }];
            //军费
            lb_junfei = [UILabel new];
            [scrollView addSubview:lb_junfei];
            lb_junfei.font = [UIFont systemFontOfSize: 14.0];
            lb_junfei.text = @"军费";
            lb_junfei.textAlignment = NSTextAlignmentCenter;
            lb_junfei.textColor = [UIColor whiteColor];
            [lb_junfei mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_zhian.mas_right);
                make.width.mas_equalTo(@((SCREEN_WIDTH-40)/6));
                make.top.mas_equalTo(lb_renwuGetDaoju.mas_bottom).with.offset(20);
            }];

            /** ------------动态布局控件 end----------- */
            
            
            
//            UIFont *font = [UIFont systemFontOfSize:17];
//            //设置一个行高上限
//            CGSize size = CGSizeMake(250,2000);
//            //计算实际frame大小，并将label的frame变成实际大小
//            CGSize labelsize = [renwuGetDaoju sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//            [self.lb_renwuDaoju setFrame: (CGRectMake(156.0, 243.0,labelsize.width, labelsize.height))];
//            
//            self.lb_renwuName.text = renwuName;
//            self.lb_renwuLevel.text = renwuLevel;
//            self.lb_renwuPeopleCount.text = renwuPeopleCount;
//            self.lb_renwuJiaofu.text = renwuJiaofu;
//            self.lb_renwuMap.text = renwuMap;
//            self.lb_renwuZhifa.text = renwuZhifa;
//            self.lb_renwuDaoju.text = renwuGetDaoju;
//            self.lb_shangyePoint.text = shangyePoint;
//            self.lb_liutongPoint.text = liutongPoint;
//            self.lb_jishuPoint.text = jishuPoint;
//            self.lb_junshiPoint.text = junfeiPoint;
//            self.lb_zhianPoint.text = zhianPoint;
//            self.lb_junfeiPoint.text = junshiPoint;
            
            
            
            
            
            

        }
        
    }];
}








-(void)leftAction
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

-(void)rightAction
{
    [self doHttp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"任务详情"];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"任务详情"];
}


@end
