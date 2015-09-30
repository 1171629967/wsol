//
//  RenwuDetailVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/8/8.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"

@interface RenwuDetailVC : BaseViewController<NavigationProtal>
{
    UIScrollView *scrollView;
    
    UILabel *lb_renwuName;
    UILabel *lb_renwuBeizhu;
    UILabel *lb_renwuLevel;
    UILabel *lb_renwuPeopleCount;
    UILabel *lb_renwuJiaofu;
    UILabel *lb_renwuMap;
    UILabel *lb_renwuZhifa;
    UILabel *lb_renwuGetDaoju;
    
    UILabel *lb_shangye;
    UILabel *lb_liutong;
    UILabel *lb_jishu;
    UILabel *lb_junshi;
    UILabel *lb_zhian;
    UILabel *lb_junfei;

}
//@property (weak, nonatomic) IBOutlet UILabel *lb_renwuName;
//@property (weak, nonatomic) IBOutlet UILabel *lb_renwuLevel;
//@property (weak, nonatomic) IBOutlet UILabel *lb_renwuPeopleCount;
//@property (weak, nonatomic) IBOutlet UILabel *lb_renwuJiaofu;
//@property (weak, nonatomic) IBOutlet UILabel *lb_renwuMap;
//@property (weak, nonatomic) IBOutlet UILabel *lb_renwuZhifa;
//@property (weak, nonatomic) IBOutlet UILabel *lb_renwuDaoju;
//@property (weak, nonatomic) IBOutlet UILabel *lb_shangyePoint;
//@property (weak, nonatomic) IBOutlet UILabel *lb_liutongPoint;
//@property (weak, nonatomic) IBOutlet UILabel *lb_jishuPoint;
//@property (weak, nonatomic) IBOutlet UILabel *lb_junshiPoint;
//@property (weak, nonatomic) IBOutlet UILabel *lb_zhianPoint;
//@property (weak, nonatomic) IBOutlet UILabel *lb_junfeiPoint;

@property int renwuId;

@end
