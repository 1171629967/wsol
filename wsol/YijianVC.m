//
//  YijianVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/1/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "YijianVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import <BmobSDK/Bmob.h>

@interface YijianVC ()

@end

@implementation YijianVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"提交"];
    [super label].text = @"意见和建议";
    self.navigationProtal = self;
    
    
    
    
    self.view.userInteractionEnabled = YES;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:scrollView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [scrollView addGestureRecognizer:tapGestureRecognizer];
    
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);//只能设置中心，不能设置大小
    activityIndicator.hidden = YES;
    [scrollView addSubview:activityIndicator];
    
    
    lb_des = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
    lb_des.textColor = [UIColor orangeColor];
    lb_des.text = @"为了更加完善该应用，您有任何意见和建议，请填写告知，谢谢";
    lb_des.numberOfLines = 0;
    lb_des.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:lb_des];
    
    
    lb_tiebaName = [[UILabel alloc]initWithFrame:CGRectMake(10, lb_des.frame.origin.y+lb_des.frame.size.height+10, 60, 40)];
    lb_tiebaName.text = @"贴吧ID";
    lb_tiebaName.textAlignment = NSTextAlignmentCenter;
    lb_tiebaName.textColor = [UIColor orangeColor];
    [scrollView addSubview:lb_tiebaName];
    
    tf_tiebaName = [[UITextView alloc] initWithFrame:CGRectMake(80, lb_des.frame.origin.y+lb_des.frame.size.height+10, SCREEN_WIDTH-80-10, 40)];
    [scrollView addSubview:tf_tiebaName];
    tf_tiebaName.delegate = self;
    lb_hidTieba = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, SCREEN_WIDTH-80-10-20, 35)];
    lb_hidTieba.text = @"为了更方便地联系您，请填写您的贴吧ID，也可不填";
    lb_hidTieba.textColor = [UIColor grayColor];
    lb_hidTieba.enabled = NO;//lable必须设置为不可用
    lb_hidTieba.font = [UIFont systemFontOfSize:12];
    lb_hidTieba.numberOfLines = 0;
    lb_hidTieba.backgroundColor = [UIColor clearColor];
    [tf_tiebaName addSubview:lb_hidTieba];

    
    
    lb_gameName = [[UILabel alloc]initWithFrame:CGRectMake(10, tf_tiebaName.frame.origin.y+tf_tiebaName.frame.size.height+10, 60, 40)];
    lb_gameName.text = @"游戏ID";
    lb_gameName.textAlignment = NSTextAlignmentCenter;
    lb_gameName.textColor = [UIColor orangeColor];
    [scrollView addSubview:lb_gameName];
    
    tf_gameName = [[UITextView alloc] initWithFrame:CGRectMake(80, tf_tiebaName.frame.origin.y+tf_tiebaName.frame.size.height+10, SCREEN_WIDTH-80-10, 40)];
    [scrollView addSubview:tf_gameName];
    tf_gameName.delegate = self;
    lb_hidGame = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, SCREEN_WIDTH-80-10-20, 35)];
    lb_hidGame.text = @"为了更方便地联系您，请填写您的游戏ID，也可不填";
    lb_hidGame.textColor = [UIColor grayColor];
    lb_hidGame.enabled = NO;//lable必须设置为不可用
    lb_hidGame.font = [UIFont systemFontOfSize:12];
    lb_hidGame.numberOfLines = 0;
    lb_hidGame.backgroundColor = [UIColor clearColor];
    [tf_gameName addSubview:lb_hidGame];
    
    lb_qq = [[UILabel alloc]initWithFrame:CGRectMake(10, tf_gameName.frame.origin.y+tf_gameName.frame.size.height+10, 60, 40)];
    lb_qq.text = @"QQ号码";
    lb_qq.textAlignment = NSTextAlignmentCenter;
    lb_qq.textColor = [UIColor orangeColor];
    [scrollView addSubview:lb_qq];
    
    tf_qq = [[UITextView alloc] initWithFrame:CGRectMake(80, tf_gameName.frame.origin.y+tf_gameName.frame.size.height+10, SCREEN_WIDTH-80-10, 40)];
    [scrollView addSubview:tf_qq];
    tf_qq.delegate = self;
    lb_hidQQ = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, SCREEN_WIDTH-80-10-20, 35)];
    lb_hidQQ.text = @"为了更方便地联系您，请填写您的游戏QQ号码，也可不填";
    lb_hidQQ.textColor = [UIColor grayColor];
    lb_hidQQ.enabled = NO;//lable必须设置为不可用
    lb_hidQQ.font = [UIFont systemFontOfSize:12];
    lb_hidQQ.numberOfLines = 0;
    lb_hidQQ.backgroundColor = [UIColor clearColor];
    [tf_qq addSubview:lb_hidQQ];

    
    tf_yijian = [[UITextView alloc] initWithFrame:CGRectMake(10, tf_qq.frame.origin.y+tf_qq.frame.size.height+20, SCREEN_WIDTH-20, 60)];
    [scrollView addSubview:tf_yijian];
    tf_yijian.delegate = self;
    lb_hidYijian = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, SCREEN_WIDTH-40, 35)];
    lb_hidYijian.text = @"请填写您对本应用的意见和建议，包括您想对作者说的任何话，必须填写";
    lb_hidYijian.textColor = [UIColor grayColor];
    lb_hidYijian.enabled = NO;//lable必须设置为不可用
    lb_hidYijian.font = [UIFont systemFontOfSize:12];
    lb_hidYijian.numberOfLines = 0;
    lb_hidYijian.backgroundColor = [UIColor clearColor];
    [tf_yijian addSubview:lb_hidYijian];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [tf_yijian resignFirstResponder];
    [tf_tiebaName resignFirstResponder];
    [tf_qq resignFirstResponder];
    [tf_gameName resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}




- (void)textViewDidBeginEditing:(UITextView *)textView
{

    if (textView == tf_yijian) {
        [scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
    
}



-(void)textViewDidChange:(UITextView *)textView
{
    if (textView == tf_tiebaName) {
        if (textView.text.length == 0) {
            lb_hidTieba.text = @"为了更方便地联系您，请填写您的贴吧ID，也可不填";
        }else{
            lb_hidTieba.text = @"";
        }
    }
    else if (textView == tf_gameName) {
        if (textView.text.length == 0) {
            lb_hidGame.text = @"为了更方便地联系您，请填写您的游戏ID，也可不填";
        }else{
            lb_hidGame.text = @"";
        }
    }
    else if (textView == tf_qq) {
        if (textView.text.length == 0) {
            lb_hidQQ.text = @"为了更方便地联系您，请填写您的QQ号码，也可不填";
        }else{
            lb_hidQQ.text = @"";
        }
    }
    else if (textView == tf_yijian) {
        if (textView.text.length == 0) {
            lb_hidYijian.text = @"请填写您对本应用的意见和建议，包括您想对作者说的任何话，必须填写";
        }else{
            lb_hidYijian.text = @"";
        }
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




-(void)doHttp
{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    if (tf_yijian.text.length == 0) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请填写您的意见和建议" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    
    BmobObject  *yijian = [BmobObject objectWithClassName:@"Yijian"];
    if (tf_gameName.text.length > 0) {
        [yijian setObject:tf_gameName.text forKey:@"gameName"];
    }
    if (tf_tiebaName.text.length > 0) {
        [yijian setObject:tf_tiebaName.text forKey:@"tf_tiebaName"];
    }
    if (tf_qq.text.length > 0) {
        [yijian setObject:tf_qq.text forKey:@"qq"];
    }
    [yijian setObject:tf_yijian.text forKey:@"content"];
    //设置系统版本号
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *systemVersionStr = [NSString stringWithFormat:@"IOS  %f",systemVersion];
    [yijian setObject:systemVersionStr forKey:@"fromOS"];
    [yijian saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (error) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"提交失败，请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
        }
        else{
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"提交成功，谢谢您的反馈!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
        }
    }];
    
    
   
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"意见和建议"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"意见和建议"];
}

@end
