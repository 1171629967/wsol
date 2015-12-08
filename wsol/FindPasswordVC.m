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
        make.width.equalTo(self.view);
    }];
    
    container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    
    //第一条分割线
    v_line1 = [UIView new];
    v_line1.backgroundColor = [UIColor whiteColor];
    [container addSubview:v_line1];
    [v_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container.mas_left);
        make.top.equalTo(container).with.offset(40);
        make.height.equalTo(@1);
        make.right.mas_equalTo(container.mas_right);
    }];
    
    lb_userName = [UILabel new];
    lb_userName.textColor = [UIColor whiteColor];
    lb_userName.text = @"账号：";
    [container addSubview:lb_userName];
    [lb_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container).offset(10);
        make.top.equalTo(v_line1).offset(10);
        make.width.equalTo(@60);
    }];
    
    //用户名输入框
    tf_userName = [UITextField new];
    tf_userName.placeholder = @"请输入账号（邮箱名）";
    [tf_userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [container addSubview:tf_userName];
    [tf_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lb_userName.mas_right).offset(10);
        make.top.equalTo(v_line1).offset(10);
        make.right.equalTo(container).offset(10);
    }];
    
    //第二条分割线
    v_line2 = [UIView new];
    v_line2.backgroundColor = [UIColor whiteColor];
    [container addSubview:v_line2];
    [v_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container.mas_left);
        make.top.equalTo(lb_userName.mas_bottom).with.offset(10);
        make.height.equalTo(@1);
        make.right.mas_equalTo(container.mas_right);
    }];

    
}
@end
