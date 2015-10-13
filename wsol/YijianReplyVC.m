//
//  YijianReplyVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/10/13.
//  Copyright © 2015年 wlx. All rights reserved.
//

#import "YijianReplyVC.h"
#import "Masonry.h"
#import <BmobSDK/Bmob.h>
#import "MobClick.h"
#import "User.h"




@interface YijianReplyVC ()

@end

@implementation YijianReplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [[super rightItem] setTitle:@"提交"];
    [super label].text = @"意见回复";
    self.navigationProtal = self;
    
    //左上角返回按钮白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    
    
    //添加控件布局
    label = [UILabel new];
    label.text = @"请填写您对该建议的回复内容";
    label.textColor = [UIColor orangeColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(10);
        make.top.mas_equalTo(self.view).with.offset(10);
        make.right.mas_equalTo(self.view).with.offset(-10);
        //make.bottom.mas_equalTo(tv_content).with.offset(-5);
    }];
    
    
    tv_content = [UITextView new];
    [self.view addSubview:tv_content];
    tv_content.delegate = self;
    tv_content.backgroundColor = [UIColor whiteColor];
    tv_content.textColor = [UIColor blackColor];
    [tv_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(label.mas_bottom).with.offset(10);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.bottom.mas_equalTo(self.view).with.offset(-SCREEN_HEIGHT/3*2);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)rightAction
{
    //内容空判断
    if (tv_content.text.length == 0) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"回复不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        return;
    }
    [self doHttp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"意见回复"];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"意见回复"];
}





- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == tv_content) {
        //[scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
}



-(void)textViewDidChange:(UITextView *)textView
{
    if (textView == tv_content) {
        
    }
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [tv_content resignFirstResponder];
    //[scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


-(void)doHttp
{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    
    
    
    BmobObject  *yijianReply = [BmobObject objectWithClassName:@"YijianReply"];
    
    //添加用户名
    User *user = (User *)[User getCurrentObject];
    [yijianReply setObject:[user objectForKey:@"username"] forKey:@"username"];
    //添加用户意见
    [yijianReply setObject:tv_content.text forKey:@"content"];
    //来自玩家还是作者
    [yijianReply setObject:[NSNumber numberWithInt:0] forKey:@"from"];
    //回复哪条意见
    [yijianReply setObject:self.replyId forKey:@"replyId"];
    //设置系统版本号
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *systemVersionStr = [NSString stringWithFormat:@"IOS  %f",systemVersion];
    [yijianReply setObject:systemVersionStr forKey:@"fromOS"];
    
    [yijianReply saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        activityIndicator.hidden = YES;//关掉菊花转
        if (error) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"提交失败，请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
        }
        else{
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"谢谢您的回复，祝您游戏愉快" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
        }
    }];
    
    
    
}



/** 弹出框的按钮点击后响应的代理函数 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        tv_content.text = @"";
    }
}




@end
