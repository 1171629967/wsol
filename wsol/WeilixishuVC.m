//
//  WeilixishuVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/1/8.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "WeilixishuVC.h"
#import <BmobSDK/Bmob.h>
#import "MobClick.h"
#import "Masonry.h"

@interface WeilixishuVC ()

@end

@implementation WeilixishuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"威力系数";
    self.navigationProtal = self;
    
    isShowedExplain = NO;

    
    
    //左上角返回按钮白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    

    [self initViews];
    [self doHttp];
}





- (void)initViews {
    scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];

    
    //武器名字
    lb_weaponName = [UILabel new];
    lb_weaponName.font = [UIFont systemFontOfSize: 20.0];
    lb_weaponName.text = self.weaponName;
    [lb_weaponName setTextColor:[UIColor orangeColor]];
    [container addSubview:lb_weaponName];
    [lb_weaponName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container).with.offset(10);
        make.centerX.mas_equalTo(container.mas_centerX);
    }];
    
    
    //系数说明按钮
    bt_explain = [UIButton new];
    bt_explain.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [bt_explain setTitle:@"威力系数说明" forState:UIControlStateNormal];// 添加文字
    [bt_explain setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    [bt_explain addTarget:self action:@selector(loadExplain) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:bt_explain];
    [bt_explain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lb_weaponName);
        make.left.equalTo(lb_weaponName.mas_right).offset(10);
    }];
    

    
    
    
    //系数说明
    lb_explainContent = [UILabel new];
    lb_explainContent.textColor = [UIColor whiteColor];
    [lb_explainContent setNumberOfLines:0];
    [lb_explainContent setLineBreakMode:NSLineBreakByCharWrapping];
    lb_explainContent.font = [UIFont systemFontOfSize:10.0];
    [container addSubview:lb_explainContent];
    [lb_explainContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container).with.offset(10);
        make.top.mas_equalTo(lb_weaponName.mas_bottom).with.offset(10);
        make.width.mas_equalTo(container.mas_width).offset(-20);
    }];
    
    
    
    //备注
    lb_beizu = [UILabel new];
    [lb_beizu setLineBreakMode:NSLineBreakByCharWrapping];
    lb_beizu.textColor = [UIColor orangeColor];
    [lb_beizu setNumberOfLines:0];
    lb_beizu.font = [UIFont systemFontOfSize:10.0];
    [container addSubview:lb_beizu];
    [lb_beizu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container).with.offset(10);
        make.top.mas_equalTo(lb_explainContent.mas_bottom).with.offset(10);
        make.width.mas_equalTo(container.mas_width).offset(-20);
    }];
    
    
    //武器详情介绍
    lb_weaponDes = [UILabel new];
    lb_weaponDes.textColor = [UIColor whiteColor];
    [lb_weaponDes setNumberOfLines:0];
    lb_weaponDes.font = [UIFont systemFontOfSize:10];
    [lb_weaponDes setLineBreakMode:NSLineBreakByCharWrapping];
    [container addSubview:lb_weaponDes];
    [lb_weaponDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container).with.offset(10);
        make.top.mas_equalTo(lb_beizu.mas_bottom).with.offset(10);
        make.width.mas_equalTo(container.mas_width).offset(-20);
    }];
    
    

    //剩下来的整体View
    allXIshuView = [UIView new];
    allXIshuView.backgroundColor = [UIColor clearColor];
    [container addSubview:allXIshuView];
    [allXIshuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container);
        make.top.mas_equalTo(lb_weaponDes.mas_bottom).with.offset(10);
        make.width.mas_equalTo(container.mas_width);
    }];
    
}

/** 加载系数说明 */
- (void)loadExplain
{
    if (isShowedExplain) {
        return;
    }
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Information"];
    [bquery whereKey:@"type" equalTo:@"weilixishu_explain"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            
        }
        else {
            isShowedExplain = YES;
            BmobObject *obj = [array objectAtIndex:0];
            NSString *des = [obj objectForKey:@"des"];
            NSString *finalDes = [des stringByReplacingOccurrencesOfString:@"$" withString:@"\n"];
            //赋值
            lb_explainContent.text = finalDes;
            
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(int)getLabelHeightWithLabel:(UILabel *)label AndString:(NSString *)string AndCount:(int) count
{

    UIFont *font = [UIFont systemFontOfSize: 12.0];
    CGSize size = CGSizeMake(label.frame.size.width,2000);
    CGSize labelsize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return labelsize.height;
}




- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Weilixishu"];
    [bquery whereKey:@"weaponName" equalTo:self.weaponName];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            //textView.text = @"加载数据失败，请重试";
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            BmobObject *obj = [array objectAtIndex:0];
            
            
            
            //设置备注
            NSString *beizhu = [obj objectForKey:@"beizhu"];
            if (![beizhu isEqualToString:@""]) {
                NSString *finalBeizhu = [beizhu stringByReplacingOccurrencesOfString:@"$" withString:@"\n"];
                lb_beizu.text = finalBeizhu;
            }
            
            //设置武器详细Des
            NSString *weaponDes = [obj objectForKey:@"weaponDes"];
            isHaveWeaponDes = ![weaponDes isEqualToString:@""];
            if (isHaveWeaponDes) {
                NSString *finalDes = [weaponDes stringByReplacingOccurrencesOfString:@"$" withString:@"\n"];
                lb_weaponDes.text = finalDes;
            }

            
            //设置武器数值
            int haveData = [[obj objectForKey:@"haveData"] intValue];
            if (haveData == 0) {
                return ;
            }
            
            
            //第一条分割线
            v_line1 = [UIView new];
            v_line1.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line1];
            [v_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView.mas_left);
                make.top.equalTo(allXIshuView).with.offset(1);
                make.height.equalTo(@1);
                make.right.mas_equalTo(allXIshuView.mas_right);
            }];
            
            
            
            
            
            //--------------------------------N1-N6 start--------------------------------
            v_N1_N6 = [UIView new];
            v_N1_N6.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_N1_N6];
            [v_N1_N6 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView.mas_left);
                make.top.equalTo(v_line1).with.offset(10);
                make.right.mas_equalTo(allXIshuView.mas_right);
            }];
            
            
            NSNumber *width1 = [NSNumber numberWithInt:(SCREEN_WIDTH-10*7)/6];
            
            
            lb_N1 = [UILabel new];
            lb_N1.textColor = [UIColor orangeColor];
            lb_N1.text = @"N1";
            lb_N1.font = [UIFont systemFontOfSize: 12.0];
            lb_N1.textAlignment = NSTextAlignmentCenter;
            [v_N1_N6 addSubview:lb_N1];
            [lb_N1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_N1_N6).offset(10);
                make.top.equalTo(v_N1_N6);
                make.width.equalTo(width1);
            }];
            
            lb_N2 = [UILabel new];
            lb_N2.textColor = [UIColor orangeColor];
            lb_N2.text = @"N2";
            lb_N2.font = [UIFont systemFontOfSize: 12.0];
            lb_N2.textAlignment = NSTextAlignmentCenter;
            [v_N1_N6 addSubview:lb_N2];
            [lb_N2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N1.mas_right).offset(10);
                make.top.equalTo(v_N1_N6);
                make.width.mas_equalTo(width1);
            }];
            
            lb_N3 = [UILabel new];
            lb_N3.textColor = [UIColor orangeColor];
            lb_N3.text = @"N3";
            lb_N3.font = [UIFont systemFontOfSize: 12.0];
            lb_N3.textAlignment = NSTextAlignmentCenter;
            [v_N1_N6 addSubview:lb_N3];
            [lb_N3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N2.mas_right).offset(10);
                make.top.equalTo(v_N1_N6);
                make.width.mas_equalTo(width1);
            }];
            
            lb_N4 = [UILabel new];
            lb_N4.textColor = [UIColor orangeColor];
            lb_N4.text = @"N4";
            lb_N4.font = [UIFont systemFontOfSize: 12.0];
            lb_N4.textAlignment = NSTextAlignmentCenter;
            [v_N1_N6 addSubview:lb_N4];
            [lb_N4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N3.mas_right).offset(10);
                make.top.equalTo(v_N1_N6);
                make.width.mas_equalTo(width1);
            }];
            
            lb_N5 = [UILabel new];
            lb_N5.textColor = [UIColor orangeColor];
            lb_N5.text = @"N5";
            lb_N5.font = [UIFont systemFontOfSize: 12.0];
            lb_N5.textAlignment = NSTextAlignmentCenter;
            [v_N1_N6 addSubview:lb_N5];
            [lb_N5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N4.mas_right).offset(10);
                make.top.equalTo(v_N1_N6);
                make.width.mas_equalTo(width1);
            }];
            
            lb_N6 = [UILabel new];
            lb_N6.textColor = [UIColor orangeColor];
            lb_N6.text = @"N6";
            lb_N6.font = [UIFont systemFontOfSize: 12.0];
            lb_N6.textAlignment = NSTextAlignmentCenter;
            [v_N1_N6 addSubview:lb_N6];
            [lb_N6 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N5.mas_right).offset(10);
                make.top.equalTo(v_N1_N6);
                make.width.mas_equalTo(width1);
            }];
            
            
            [v_N1_N6 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_N1,lb_N2]);
            }];
            //--------------------------------N1-N6 end--------------------------------
            //--------------------------------N1-N6数值 start--------------------------------
            v_N1data_N6data = [UIView new];
            v_N1data_N6data.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_N1data_N6data];
            [v_N1data_N6data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_N1_N6.mas_bottom).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            lb_N1data = [UILabel new];
            lb_N1data.font = [UIFont systemFontOfSize: 12.0];
            lb_N1data.textAlignment = NSTextAlignmentCenter;
            [lb_N1data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N1data.numberOfLines = 0;
            [v_N1data_N6data addSubview:lb_N1data];
            [lb_N1data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_N1data_N6data).offset(10);
                make.top.equalTo(v_N1data_N6data);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_N1data AndString:[obj objectForKey:@"N1"] AndColorString:[obj objectForKey:@"N1color"]];

            
            lb_N2data = [UILabel new];
            lb_N2data.font = [UIFont systemFontOfSize: 12.0];
            lb_N2data.textAlignment = NSTextAlignmentCenter;
            [lb_N2data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N2data.numberOfLines = 0;
            [v_N1data_N6data addSubview:lb_N2data];
            [lb_N2data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N1data.mas_right).offset(10);
                make.top.equalTo(v_N1data_N6data);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_N2data AndString:[obj objectForKey:@"N2"] AndColorString:[obj objectForKey:@"N2color"]];
            
            lb_N3data = [UILabel new];
            lb_N3data.font = [UIFont systemFontOfSize: 12.0];
            lb_N3data.textAlignment = NSTextAlignmentCenter;
            [lb_N3data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N3data.numberOfLines = 0;
            [v_N1data_N6data addSubview:lb_N3data];
            [lb_N3data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N2data.mas_right).offset(10);
                make.top.equalTo(v_N1data_N6data);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_N3data AndString:[obj objectForKey:@"N3"] AndColorString:[obj objectForKey:@"N3color"]];
            
            lb_N4data = [UILabel new];
            lb_N4data.font = [UIFont systemFontOfSize: 12.0];
            lb_N4data.textAlignment = NSTextAlignmentCenter;
            [lb_N4data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N4data.numberOfLines = 0;
            [v_N1data_N6data addSubview:lb_N4data];
            [lb_N4data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N3data.mas_right).offset(10);
                make.top.equalTo(v_N1data_N6data);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_N4data AndString:[obj objectForKey:@"N4"] AndColorString:[obj objectForKey:@"N4color"]];
            
            lb_N5data = [UILabel new];
            lb_N5data.font = [UIFont systemFontOfSize: 12.0];
            lb_N5data.textAlignment = NSTextAlignmentCenter;
            [lb_N5data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N5data.numberOfLines = 0;
            [v_N1data_N6data addSubview:lb_N5data];
            [lb_N5data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N4data.mas_right).offset(10);
                make.top.equalTo(v_N1data_N6data);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_N5data AndString:[obj objectForKey:@"N5"] AndColorString:[obj objectForKey:@"N5color"]];
            
            lb_N6data = [UILabel new];
            lb_N6data.font = [UIFont systemFontOfSize: 12.0];
            lb_N6data.textAlignment = NSTextAlignmentCenter;
            [lb_N6data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N6data.numberOfLines = 0;
            [v_N1data_N6data addSubview:lb_N6data];
            [lb_N6data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_N5data.mas_right).offset(10);
                make.top.equalTo(v_N1data_N6data);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_N6data AndString:[obj objectForKey:@"N6"] AndColorString:[obj objectForKey:@"N6color"]];

            
            [v_N1data_N6data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_N1data,lb_N2data,lb_N3data,lb_N4data,lb_N5data,lb_N6data]);
            }];
            //--------------------------------N1-N6数值 end--------------------------------
            
            
            //第二条分割线
            v_line2 = [UIView new];
            v_line2.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line2];
            [v_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_N1data_N6data.mas_bottom).with.offset(10);
                make.height.equalTo(@1);
                make.right.mas_equalTo(allXIshuView);
            }];
            
 
    
            //--------------------------------E6-E9 start--------------------------------
            v_E6_E9 = [UIView new];
            v_E6_E9.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_E6_E9];
            [v_E6_E9 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_line2).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            NSNumber *width2 = [NSNumber numberWithInt:(SCREEN_WIDTH-10*5)/4];
            
            
            lb_E6 = [UILabel new];
            lb_E6.textColor = [UIColor orangeColor];
            lb_E6.text = @"E6";
            lb_E6.font = [UIFont systemFontOfSize: 12.0];
            lb_E6.textAlignment = NSTextAlignmentCenter;
            [v_E6_E9 addSubview:lb_E6];
            [lb_E6 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_E6_E9).offset(10);
                make.top.equalTo(v_E6_E9);
                make.width.equalTo(width2);
            }];
            
            lb_E7 = [UILabel new];
            lb_E7.textColor = [UIColor orangeColor];
            lb_E7.text = @"E7";
            lb_E7.font = [UIFont systemFontOfSize: 12.0];
            lb_E7.textAlignment = NSTextAlignmentCenter;
            [v_E6_E9 addSubview:lb_E7];
            [lb_E7 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_E6.mas_right).offset(10);
                make.top.equalTo(v_E6_E9);
                make.width.equalTo(width2);
            }];
            
            lb_E8 = [UILabel new];
            lb_E8.textColor = [UIColor orangeColor];
            lb_E8.text = @"E8";
            lb_E8.font = [UIFont systemFontOfSize: 12.0];
            lb_E8.textAlignment = NSTextAlignmentCenter;
            [v_E6_E9 addSubview:lb_E8];
            [lb_E8 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_E7.mas_right).offset(10);
                make.top.equalTo(v_E6_E9);
                make.width.equalTo(width2);
            }];
            
            lb_E9 = [UILabel new];
            lb_E9.textColor = [UIColor orangeColor];
            lb_E9.text = @"E9";
            lb_E9.font = [UIFont systemFontOfSize: 12.0];
            lb_E9.textAlignment = NSTextAlignmentCenter;
            [v_E6_E9 addSubview:lb_E9];
            [lb_E9 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_E8.mas_right).offset(10);
                make.top.equalTo(v_E6_E9);
                make.width.equalTo(width2);
            }];
            
            [v_E6_E9 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_E6,lb_E7,lb_E8,lb_E9]);
            }];
            //--------------------------------E6-E9 end--------------------------------
            //--------------------------------E6-E9数值 start--------------------------------
            v_E6data_E9data = [UIView new];
            v_E6data_E9data.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_E6data_E9data];
            [v_E6data_E9data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_E6_E9.mas_bottom).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            lb_E6data = [UILabel new];
            lb_E6data.font = [UIFont systemFontOfSize: 12.0];
            lb_E6data.textAlignment = NSTextAlignmentCenter;
            [lb_E6data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_E6data.numberOfLines = 0;
            [v_E6data_E9data addSubview:lb_E6data];
            [lb_E6data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_E6data_E9data).offset(10);
                make.top.equalTo(v_E6data_E9data);
                make.width.equalTo(width2);
            }];
            [self setColorWithLable:lb_E6data AndString:[obj objectForKey:@"E6"] AndColorString:[obj objectForKey:@"E6color"]];
            
            
            lb_E7data = [UILabel new];
            lb_E7data.font = [UIFont systemFontOfSize: 12.0];
            lb_E7data.textAlignment = NSTextAlignmentCenter;
            [lb_E7data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_E7data.numberOfLines = 0;
            [v_E6data_E9data addSubview:lb_E7data];
            [lb_E7data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_E6data.mas_right).offset(10);
                make.top.equalTo(v_E6data_E9data);
                make.width.equalTo(width2);
            }];
            [self setColorWithLable:lb_E7data AndString:[obj objectForKey:@"E7"] AndColorString:[obj objectForKey:@"E7color"]];
            
            
            lb_E8data = [UILabel new];
            lb_E8data.font = [UIFont systemFontOfSize: 12.0];
            lb_E8data.textAlignment = NSTextAlignmentCenter;
            [lb_E8data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_E8data.numberOfLines = 0;
            [v_E6data_E9data addSubview:lb_E8data];
            [lb_E8data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_E7data.mas_right).offset(10);
                make.top.equalTo(v_E6data_E9data);
                make.width.equalTo(width2);
            }];
            [self setColorWithLable:lb_E8data AndString:[obj objectForKey:@"E8"] AndColorString:[obj objectForKey:@"E8color"]];
            
            
            lb_E9data = [UILabel new];
            lb_E9data.font = [UIFont systemFontOfSize: 12.0];
            lb_E9data.textAlignment = NSTextAlignmentCenter;
            [lb_E9data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_E9data.numberOfLines = 0;
            [v_E6data_E9data addSubview:lb_E9data];
            [lb_E9data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_E8data.mas_right).offset(10);
                make.top.equalTo(v_E6data_E9data);
                make.width.equalTo(width2);
            }];
            [self setColorWithLable:lb_E9data AndString:[obj objectForKey:@"E9"] AndColorString:[obj objectForKey:@"E9color"]];
            
            
            [v_E6data_E9data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_E6data,lb_E7data,lb_E8data,lb_E9data]);
            }];
            //--------------------------------E6-E9数值 end-------------------------------
            
            
            //第三条分割线
            v_line3 = [UIView new];
            v_line3.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line3];
            [v_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_E6data_E9data.mas_bottom).with.offset(10);
                make.height.equalTo(@1);
                make.right.mas_equalTo(allXIshuView);
            }];
            
    
            //--------------------------------C2-C5 start--------------------------------
            v_C2_C5 = [UIView new];
            v_C2_C5.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_C2_C5];
            [v_C2_C5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_line3).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];

            lb_C2 = [UILabel new];
            lb_C2.textColor = [UIColor orangeColor];
            lb_C2.text = @"C2";
            lb_C2.font = [UIFont systemFontOfSize: 12.0];
            lb_C2.textAlignment = NSTextAlignmentCenter;
            [v_C2_C5 addSubview:lb_C2];
            [lb_C2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_C2_C5).offset(10);
                make.top.equalTo(v_C2_C5);
                make.width.equalTo(width2);
            }];
            
            lb_C3 = [UILabel new];
            lb_C3.textColor = [UIColor orangeColor];
            lb_C3.text = @"C3";
            lb_C3.font = [UIFont systemFontOfSize: 12.0];
            lb_C3.textAlignment = NSTextAlignmentCenter;
            [v_C2_C5 addSubview:lb_C3];
            [lb_C3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_C2.mas_right).offset(10);
                make.top.equalTo(v_C2_C5);
                make.width.equalTo(width2);
            }];
            
            lb_C4 = [UILabel new];
            lb_C4.textColor = [UIColor orangeColor];
            lb_C4.text = @"C4";
            lb_C4.font = [UIFont systemFontOfSize: 12.0];
            lb_C4.textAlignment = NSTextAlignmentCenter;
            [v_C2_C5 addSubview:lb_C4];
            [lb_C4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_C3.mas_right).offset(10);
                make.top.equalTo(v_C2_C5);
                make.width.equalTo(width2);
            }];
            
            lb_C5 = [UILabel new];
            lb_C5.textColor = [UIColor orangeColor];
            lb_C5.text = @"C5";
            lb_C5.font = [UIFont systemFontOfSize: 12.0];
            lb_C5.textAlignment = NSTextAlignmentCenter;
            [v_C2_C5 addSubview:lb_C5];
            [lb_C5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_C4.mas_right).offset(10);
                make.top.equalTo(v_C2_C5);
                make.width.equalTo(width2);
            }];
            
            
            [v_C2_C5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_C2,lb_C3,lb_C4,lb_C5]);
            }];
    
            //--------------------------------C2-C5 end--------------------------------
            //--------------------------------C2-C5数值 start--------------------------------
            v_C2data_C5data = [UIView new];
            v_C2data_C5data.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_C2data_C5data];
            [v_C2data_C5data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_C2_C5.mas_bottom).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            lb_C2data = [UILabel new];
            lb_C2data.font = [UIFont systemFontOfSize: 12.0];
            lb_C2data.textAlignment = NSTextAlignmentCenter;
            [lb_C2data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_C2data.numberOfLines = 0;
            [v_C2data_C5data addSubview:lb_C2data];
            [lb_C2data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_C2data_C5data).offset(10);
                make.top.equalTo(v_C2data_C5data);
                make.width.equalTo(width2);
            }];
            [self setColorWithLable:lb_C2data AndString:[obj objectForKey:@"C2"] AndColorString:[obj objectForKey:@"C2color"]];
            
            
            lb_C3data = [UILabel new];
            lb_C3data.font = [UIFont systemFontOfSize: 12.0];
            lb_C3data.textAlignment = NSTextAlignmentCenter;
            [lb_C3data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_C3data.numberOfLines = 0;
            [v_C2data_C5data addSubview:lb_C3data];
            [lb_C3data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_C2data.mas_right).offset(10);
                make.top.equalTo(v_C2data_C5data);
                make.width.equalTo(width2);
            }];
            [self setColorWithLable:lb_C3data AndString:[obj objectForKey:@"C3"] AndColorString:[obj objectForKey:@"C3color"]];
            
            
            lb_C4data = [UILabel new];
            lb_C4data.font = [UIFont systemFontOfSize: 12.0];
            lb_C4data.textAlignment = NSTextAlignmentCenter;
            [lb_C4data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_C4data.numberOfLines = 0;
            [v_C2data_C5data addSubview:lb_C4data];
            [lb_C4data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_C3data.mas_right).offset(10);
                make.top.equalTo(v_C2data_C5data);
                make.width.equalTo(width2);
            }];
            [self setColorWithLable:lb_C4data AndString:[obj objectForKey:@"C4"] AndColorString:[obj objectForKey:@"C4color"]];
            
            
            lb_C5data = [UILabel new];
            lb_C5data.font = [UIFont systemFontOfSize: 12.0];
            lb_C5data.textAlignment = NSTextAlignmentCenter;
            [lb_C5data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_C5data.numberOfLines = 0;
            [v_C2data_C5data addSubview:lb_C5data];
            [lb_C5data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_C4data.mas_right).offset(10);
                make.top.equalTo(v_C2data_C5data);
                make.width.equalTo(width2);
            }];
            [self setColorWithLable:lb_C5data AndString:[obj objectForKey:@"C5"] AndColorString:[obj objectForKey:@"C5color"]];
            
            
            [v_C2data_C5data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_C2data,lb_C3data,lb_C4data,lb_C5data]);
            }];
            
            //--------------------------------C2-C5数值 end--------------------------------
            

            //第四条分割线
            v_line4 = [UIView new];
            v_line4.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line4];
            [v_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_C2data_C5data.mas_bottom).with.offset(10);
                make.height.equalTo(@1);
                make.right.mas_equalTo(allXIshuView);
            }];

            //--------------------------------D,JA,JC satrt--------------------------------
            v_D_JC = [UIView new];
            v_D_JC.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_D_JC];
            [v_D_JC mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_line4).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            NSNumber *width3 = [NSNumber numberWithInt:(SCREEN_WIDTH-10*4)/3];
            
            
            lb_D = [UILabel new];
            lb_D.textColor = [UIColor orangeColor];
            lb_D.text = @"D";
            lb_D.font = [UIFont systemFontOfSize: 12.0];
            lb_D.textAlignment = NSTextAlignmentCenter;
            [v_D_JC addSubview:lb_D];
            [lb_D mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_D_JC).offset(10);
                make.top.equalTo(v_D_JC);
                make.width.equalTo(width3);
            }];
            
            lb_JA = [UILabel new];
            lb_JA.textColor = [UIColor orangeColor];
            lb_JA.text = @"JA";
            lb_JA.font = [UIFont systemFontOfSize: 12.0];
            lb_JA.textAlignment = NSTextAlignmentCenter;
            [v_D_JC addSubview:lb_JA];
            [lb_JA mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_D.mas_right).offset(10);
                make.top.equalTo(v_D_JC);
                make.width.equalTo(width3);
            }];
            
            lb_JC = [UILabel new];
            lb_JC.textColor = [UIColor orangeColor];
            lb_JC.text = @"JC";
            lb_JC.font = [UIFont systemFontOfSize: 12.0];
            lb_JC.textAlignment = NSTextAlignmentCenter;
            [v_D_JC addSubview:lb_JC];
            [lb_JC mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_JA.mas_right).offset(10);
                make.top.equalTo(v_D_JC);
                make.width.equalTo(width3);
            }];
            
            [v_D_JC mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_D,lb_JA,lb_JC]);
            }];
            
            
            //--------------------------------D,JA,JC end--------------------------------
            //--------------------------------D,JA,JC数值 start--------------------------------
            v_Ddata_JCdata = [UIView new];
            v_Ddata_JCdata.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_Ddata_JCdata];
            [v_Ddata_JCdata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_D_JC.mas_bottom).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            lb_Ddata = [UILabel new];
            lb_Ddata.font = [UIFont systemFontOfSize: 12.0];
            lb_Ddata.textAlignment = NSTextAlignmentCenter;
            [lb_Ddata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_Ddata.numberOfLines = 0;
            [v_Ddata_JCdata addSubview:lb_Ddata];
            [lb_Ddata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_Ddata_JCdata).offset(10);
                make.top.equalTo(v_Ddata_JCdata);
                make.width.equalTo(width3);
            }];
            [self setColorWithLable:lb_Ddata AndString:[obj objectForKey:@"D"] AndColorString:[obj objectForKey:@"Dcolor"]];
            
            lb_JAdata = [UILabel new];
            lb_JAdata.font = [UIFont systemFontOfSize: 12.0];
            lb_JAdata.textAlignment = NSTextAlignmentCenter;
            [lb_JAdata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_JAdata.numberOfLines = 0;
            [v_Ddata_JCdata addSubview:lb_JAdata];
            [lb_JAdata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_Ddata.mas_right).offset(10);
                make.top.equalTo(v_Ddata_JCdata);
                make.width.equalTo(width3);
            }];
            [self setColorWithLable:lb_JAdata AndString:[obj objectForKey:@"JA"] AndColorString:[obj objectForKey:@"JAcolor"]];
            
            lb_JCdata = [UILabel new];
            lb_JCdata.font = [UIFont systemFontOfSize: 12.0];
            lb_JCdata.textAlignment = NSTextAlignmentCenter;
            [lb_JCdata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_JCdata.numberOfLines = 0;
            [v_Ddata_JCdata addSubview:lb_JCdata];
            [lb_JCdata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_JAdata.mas_right).offset(10);
                make.top.equalTo(v_Ddata_JCdata);
                make.width.equalTo(width3);
            }];
            [self setColorWithLable:lb_JCdata AndString:[obj objectForKey:@"JC"] AndColorString:[obj objectForKey:@"JCcolor"]];
            
            [v_Ddata_JCdata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_Ddata,lb_JAdata,lb_JCdata]);
            }];
            
            

            //--------------------------------D,JA,JC数值 end--------------------------------

            //第五条分割线
            v_line5 = [UIView new];
            v_line5.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line5];
            [v_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_Ddata_JCdata.mas_bottom).with.offset(10);
                make.height.equalTo(@1);
                make.right.mas_equalTo(allXIshuView);
            }];
            
   
            //--------------------------------刻印 start--------------------------------
            v_tu_ba = [UIView new];
            v_tu_ba.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_tu_ba];
            [v_tu_ba mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_line5).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            
            
            lb_tu = [UILabel new];
            lb_tu.textColor = [UIColor orangeColor];
            lb_tu.text = @"突";
            lb_tu.font = [UIFont systemFontOfSize: 12.0];
            lb_tu.textAlignment = NSTextAlignmentCenter;
            [v_tu_ba addSubview:lb_tu];
            [lb_tu mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_tu_ba).offset(10);
                make.top.equalTo(v_tu_ba);
                make.width.equalTo(width1);
            }];
            
            lb_dun = [UILabel new];
            lb_dun.textColor = [UIColor orangeColor];
            lb_dun.text = @"盾";
            lb_dun.font = [UIFont systemFontOfSize: 12.0];
            lb_dun.textAlignment = NSTextAlignmentCenter;
            [v_tu_ba addSubview:lb_dun];
            [lb_dun mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_tu.mas_right).offset(10);
                make.top.equalTo(v_tu_ba);
                make.width.equalTo(width1);
            }];
            
            lb_sui = [UILabel new];
            lb_sui.textColor = [UIColor orangeColor];
            lb_sui.text = @"碎";
            lb_sui.font = [UIFont systemFontOfSize: 12.0];
            lb_sui.textAlignment = NSTextAlignmentCenter;
            [v_tu_ba addSubview:lb_sui];
            [lb_sui mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_dun.mas_right).offset(10);
                make.top.equalTo(v_tu_ba);
                make.width.equalTo(width1);
            }];
            
            lb_zhen = [UILabel new];
            lb_zhen.textColor = [UIColor orangeColor];
            lb_zhen.text = @"阵";
            lb_zhen.font = [UIFont systemFontOfSize: 12.0];
            lb_zhen.textAlignment = NSTextAlignmentCenter;
            [v_tu_ba addSubview:lb_zhen];
            [lb_zhen mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_sui.mas_right).offset(10);
                make.top.equalTo(v_tu_ba);
                make.width.equalTo(width1);
            }];
            
            lb_wei = [UILabel new];
            lb_wei.textColor = [UIColor orangeColor];
            lb_wei.text = @"卫";
            lb_wei.font = [UIFont systemFontOfSize: 12.0];
            lb_wei.textAlignment = NSTextAlignmentCenter;
            [v_tu_ba addSubview:lb_wei];
            [lb_wei mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_zhen.mas_right).offset(10);
                make.top.equalTo(v_tu_ba);
                make.width.equalTo(width1);
            }];
            
            lb_ba = [UILabel new];
            lb_ba.textColor = [UIColor orangeColor];
            lb_ba.text = @"霸";
            lb_ba.font = [UIFont systemFontOfSize: 12.0];
            lb_ba.textAlignment = NSTextAlignmentCenter;
            [v_tu_ba addSubview:lb_ba];
            [lb_ba mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_wei.mas_right).offset(10);
                make.top.equalTo(v_tu_ba);
                make.width.equalTo(width1);
            }];
            
            [v_tu_ba mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_tu,lb_sui,lb_dun,lb_zhen,lb_wei,lb_ba]);
            }];

            //--------------------------------刻印 end--------------------------------
            //--------------------------------刻印数值 start--------------------------------
            v_tudata_badata = [UIView new];
            v_tudata_badata.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_tudata_badata];
            [v_tudata_badata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_tu_ba.mas_bottom).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            lb_tudata = [UILabel new];
            lb_tudata.font = [UIFont systemFontOfSize: 12.0];
            lb_tudata.textAlignment = NSTextAlignmentCenter;
            [lb_tudata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_tudata.numberOfLines = 0;
            [v_tudata_badata addSubview:lb_tudata];
            [lb_tudata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_tudata_badata).offset(10);
                make.top.equalTo(v_tudata_badata);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_tudata AndString:[obj objectForKey:@"tu"] AndColorString:[obj objectForKey:@"tucolor"]];
            

            lb_dundata = [UILabel new];
            lb_dundata.font = [UIFont systemFontOfSize: 12.0];
            lb_dundata.textAlignment = NSTextAlignmentCenter;
            [lb_dundata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_dundata.numberOfLines = 0;
            [v_tudata_badata addSubview:lb_dundata];
            [lb_dundata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_tu.mas_right).offset(10);
                make.top.equalTo(v_tudata_badata);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_dundata AndString:[obj objectForKey:@"dun"] AndColorString:[obj objectForKey:@"duncolor"]];
            
            lb_suidata = [UILabel new];
            lb_suidata.font = [UIFont systemFontOfSize: 12.0];
            lb_suidata.textAlignment = NSTextAlignmentCenter;
            [lb_suidata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_suidata.numberOfLines = 0;
            [v_tudata_badata addSubview:lb_suidata];
            [lb_suidata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_dun.mas_right).offset(10);
                make.top.equalTo(v_tudata_badata);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_suidata AndString:[obj objectForKey:@"sui"] AndColorString:[obj objectForKey:@"suicolor"]];
            

            lb_zhendata = [UILabel new];
            lb_zhendata.font = [UIFont systemFontOfSize: 12.0];
            lb_zhendata.textAlignment = NSTextAlignmentCenter;
            [lb_zhendata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_zhendata.numberOfLines = 0;
            [v_tudata_badata addSubview:lb_zhendata];
            [lb_zhendata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_sui.mas_right).offset(10);
                make.top.equalTo(v_tudata_badata);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_zhendata AndString:[obj objectForKey:@"zhen"] AndColorString:[obj objectForKey:@"zhencolor"]];
            

            lb_weidata = [UILabel new];
            lb_weidata.font = [UIFont systemFontOfSize: 12.0];
            lb_weidata.textAlignment = NSTextAlignmentCenter;
            [lb_weidata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_weidata.numberOfLines = 0;
            [v_tudata_badata addSubview:lb_weidata];
            [lb_weidata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_zhen.mas_right).offset(10);
                make.top.equalTo(v_tudata_badata);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_weidata AndString:[obj objectForKey:@"wei"] AndColorString:[obj objectForKey:@"weicolor"]];
            

            lb_badata = [UILabel new];
            lb_badata.font = [UIFont systemFontOfSize: 12.0];
            lb_badata.textAlignment = NSTextAlignmentCenter;
            [lb_badata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_badata.numberOfLines = 0;
            [v_tudata_badata addSubview:lb_badata];
            [lb_badata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_weidata.mas_right).offset(10);
                make.top.equalTo(v_tudata_badata);
                make.width.equalTo(width1);
            }];
            [self setColorWithLable:lb_badata AndString:[obj objectForKey:@"ba"] AndColorString:[obj objectForKey:@"bacolor"]];
            
            [v_tudata_badata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_tudata,lb_suidata,lb_dundata,lb_zhendata,lb_weidata,lb_badata]);
            }];
            //--------------------------------刻印数值 end--------------------------------

            //第六条分割线
            v_line6 = [UIView new];
            v_line6.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line6];
            [v_line6 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_tudata_badata.mas_bottom).with.offset(10);
                make.height.equalTo(@1);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            
            //--------------------------------无双 satrt--------------------------------
            v_puwu_zhenmo = [UIView new];
            v_puwu_zhenmo.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_puwu_zhenmo];
            [v_puwu_zhenmo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_line6).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
 
            lb_puwuAndZhenwu = [UILabel new];
            lb_puwuAndZhenwu.textColor = [UIColor orangeColor];
            lb_puwuAndZhenwu.text = @"无双/真无双";
            lb_puwuAndZhenwu.font = [UIFont systemFontOfSize: 12.0];
            lb_puwuAndZhenwu.textAlignment = NSTextAlignmentCenter;
            [v_puwu_zhenmo addSubview:lb_puwuAndZhenwu];
            [lb_puwuAndZhenwu mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_puwu_zhenmo).offset(10);
                make.top.equalTo(v_puwu_zhenmo);
                make.width.equalTo(width3);
            }];
            
            lb_pumo = [UILabel new];
            lb_pumo.textColor = [UIColor orangeColor];
            lb_pumo.text = @"普末";
            lb_pumo.font = [UIFont systemFontOfSize: 12.0];
            lb_pumo.textAlignment = NSTextAlignmentCenter;
            [v_puwu_zhenmo addSubview:lb_pumo];
            [lb_pumo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_puwuAndZhenwu.mas_right).offset(10);
                make.top.equalTo(v_puwu_zhenmo);
                make.width.equalTo(width3);
            }];
            
            lb_zhenmo = [UILabel new];
            lb_zhenmo.textColor = [UIColor orangeColor];
            lb_zhenmo.text = @"真末";
            lb_zhenmo.font = [UIFont systemFontOfSize: 12.0];
            lb_zhenmo.textAlignment = NSTextAlignmentCenter;
            [v_puwu_zhenmo addSubview:lb_zhenmo];
            [lb_zhenmo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_pumo.mas_right).offset(10);
                make.top.equalTo(v_puwu_zhenmo);
                make.width.equalTo(width3);
            }];
            
            [v_puwu_zhenmo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_puwuAndZhenwu,lb_pumo,lb_zhenmo]);
            }];
            //--------------------------------无双 end--------------------------------
            //--------------------------------无双数值 start--------------------------------
            v_puwudata_zhenmodata = [UIView new];
            v_puwudata_zhenmodata.backgroundColor = [UIColor clearColor];
            [allXIshuView addSubview:v_puwudata_zhenmodata];
            [v_puwudata_zhenmodata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(allXIshuView);
                make.top.equalTo(v_puwu_zhenmo.mas_bottom).with.offset(10);
                make.right.mas_equalTo(allXIshuView);
            }];
            
            
            lb_puwuAndZhenwudata = [UILabel new];
            lb_puwuAndZhenwudata.font = [UIFont systemFontOfSize: 12.0];
            lb_puwuAndZhenwudata.textAlignment = NSTextAlignmentCenter;
            [lb_puwuAndZhenwudata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_puwuAndZhenwudata.numberOfLines = 0;
            [v_puwudata_zhenmodata addSubview:lb_puwuAndZhenwudata];
            [lb_puwuAndZhenwudata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v_puwudata_zhenmodata).offset(10);
                make.top.equalTo(v_puwudata_zhenmodata);
                make.width.equalTo(width3);
            }];
            [self setColorWithLable:lb_puwuAndZhenwudata AndString:[obj objectForKey:@"puwuAndZhenwu"] AndColorString:[obj objectForKey:@"puwuAndZhenwucolor"]];
            
            lb_pumodata = [UILabel new];
            lb_pumodata.font = [UIFont systemFontOfSize: 12.0];
            lb_pumodata.textAlignment = NSTextAlignmentCenter;
            [lb_pumodata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_pumodata.numberOfLines = 0;
            [v_puwudata_zhenmodata addSubview:lb_pumodata];
            [lb_pumodata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_puwuAndZhenwudata.mas_right).offset(10);
                make.top.equalTo(v_puwudata_zhenmodata);
                make.width.equalTo(width3);
            }];
            [self setColorWithLable:lb_pumodata AndString:[obj objectForKey:@"pumo"] AndColorString:[obj objectForKey:@"pumocolor"]];
            
            lb_zhenmodata = [UILabel new];
            lb_zhenmodata.font = [UIFont systemFontOfSize: 12.0];
            lb_zhenmodata.textAlignment = NSTextAlignmentCenter;
            [lb_zhenmodata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_zhenmodata.numberOfLines = 0;
            [v_puwudata_zhenmodata addSubview:lb_zhenmodata];
            [lb_zhenmodata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lb_pumodata.mas_right).offset(10);
                make.top.equalTo(v_puwudata_zhenmodata);
                make.width.equalTo(width3);
            }];
            [self setColorWithLable:lb_zhenmodata AndString:[obj objectForKey:@"zhenmo"] AndColorString:[obj objectForKey:@"zhenmocolor"]];
            
            
            [v_puwudata_zhenmodata mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.greaterThanOrEqualTo(@[lb_puwuAndZhenwudata,lb_pumodata,lb_zhenmodata]);
            }];
            //--------------------------------无双数值 end--------------------------------
            
            //最后控制一下scrollview的滚动范围
            [container mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(v_puwudata_zhenmodata.mas_bottom).offset(10 + 20);
            }];
        }
        
    }];
    
    
    
}


- (void)setColorWithLable:(UILabel*)label AndString:(NSString*)string AndColorString:(NSString*)colorString
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSArray *array=[colorString componentsSeparatedByString:@"|"];
    for (int i = 0; i < array.count; i++) {
        NSArray *arrayData=[[array objectAtIndex:i] componentsSeparatedByString:@","];
        int a = [[arrayData objectAtIndex:0] intValue];
        int b = [[arrayData objectAtIndex:1] intValue];
        int c = [[arrayData objectAtIndex:2] intValue];
        switch (c) {
                // 白色（无属性）
            case 0:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(a,b)];
                break;
                // 蓝色 （带属性）
            case 1:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:0.41 blue:0.85 alpha:1] range:NSMakeRange(a,b)];
                break;
                // 红色 （自带炎属性）
            case 2:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(a,b)];
                break;
                // 青色 （自带冰属性）
            case 3:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(a,b)];
                break;
                // 紫色 （自带斩属性）
            case 4:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:1] range:NSMakeRange(a,b)];
                break;
                // 绿色 （自带风属性）
            case 5:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(a,b)];
                break;
                // 黄色 （自带雷属性）
            case 6:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(a,b)];
                break;
                
            default:
                break;
        }
    }
    
    label.attributedText = str;
}



-(void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)rightAction
{
    [self doHttp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"武器威力系数页面"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"武器威力系数页面"];
}


@end
