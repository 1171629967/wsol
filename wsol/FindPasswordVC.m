//
//  FindPasswordVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/12/7.
//  Copyright © 2015年 wlx. All rights reserved.
//

#import "FindPasswordVC.h"
#import <BmobSDK/Bmob.h>
#import "MobClick.h"
#import "Masonry.h"
#import "Utils.h"

@interface FindPasswordVC ()

@end

@implementation FindPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
//    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"找回密码";
    self.navigationProtal = self;

    //左上角返回按钮白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self initViews];
    //[self doHttp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initViews {
    scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        //make.width.equalTo(self.view);
    }];
    
//    container = [UIView new];
//    [scrollView addSubview:container];
//    [container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(scrollView);
//        make.width.equalTo(scrollView);
//    }];
    
    
    //第一条分割线
    v_line1 = [UIView new];
    v_line1.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:v_line1];
    [v_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.equalTo(scrollView).with.offset(40);
        make.height.equalTo(@0.5);
        make.width.equalTo(scrollView);
    }];
    
    lb_userName = [UILabel new];
    lb_userName.textColor = [UIColor whiteColor];
    lb_userName.text = @"账号：";
    [scrollView addSubview:lb_userName];
    [lb_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(10);
        make.top.equalTo(v_line1.mas_bottom).offset(10);
        make.width.equalTo(@60);
    }];
    
    //用户名输入框
    tf_userName = [UITextField new];
    tf_userName.placeholder = @"请输入账号（邮箱名）";
    tf_userName.textColor = [UIColor whiteColor];
    [tf_userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [scrollView addSubview:tf_userName];
    [tf_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lb_userName.mas_right).offset(10);
        make.top.equalTo(v_line1.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    
    //第二条分割线
    v_line2 = [UIView new];
    v_line2.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:v_line2];
    [v_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.equalTo(lb_userName.mas_bottom).with.offset(10);
        make.height.equalTo(@0.5);
        make.width.equalTo(scrollView);
    }];
    
    
    //发送验证邮件按钮
    bt_send = [UIButton new];
    bt_send.layer.borderWidth = 0.5;
    bt_send.layer.borderColor = [[UIColor whiteColor]CGColor];
    [bt_send setTitle: @"发送验证邮件" forState: UIControlStateNormal];
    bt_send.titleLabel.textColor = [UIColor whiteColor];
    [bt_send addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:bt_send];
    [bt_send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView.mas_left).offset(20);
        make.top.equalTo(v_line2.mas_bottom).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    
    
    //描述
    lb_des = [UILabel new];
    lb_des.textColor = [UIColor whiteColor];
    lb_des.text = @"请输入您注册的邮箱，系统会向您的邮箱发送一封修改密码的邮件，请在一小时内登录邮箱修改密码，否则邮件会失效";
    [lb_des setLineBreakMode:NSLineBreakByWordWrapping];
    lb_des.numberOfLines = 0;
    lb_des.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:lb_des];
    [lb_des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bt_send.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    
}



-(void) clickButton
{
    //现在非空判断
    if ([Utils isBlankString:tf_userName.text]) {
        HUD.mode = MBProgressHUDModeText;
        HUD.hidden = NO;
        HUD.labelText = @"请输入邮箱";
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            HUD.hidden = YES;
        }];
        return;
    }
    [BmobUser requestPasswordResetInBackgroundWithEmail:tf_userName.text];
    
    //提示邮件发送成功
    HUD.mode = MBProgressHUDModeText;
    HUD.hidden = NO;
    HUD.labelText = @"发送成功，请登录邮箱修改密码";
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        HUD.hidden = YES;
    }];
}

@end
