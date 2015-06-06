//
//  LoginVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/19.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "LoginVC.h"
#import <BmobSDK/Bmob.h>
#import "RegistVC.h"
#import "Utils.h"
#import "WLXAppDelegate.h"
#import "CompletePersonInfoVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [super label].text = @"登录";
    
    self.bt_cancel.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
    self.bt_login.layer.borderWidth = 1;
    self.bt_login.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.bt_regist.layer.borderWidth = 1;
    self.bt_regist.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    [self.et_password setSecureTextEntry:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/** 登录操作 */
- (IBAction)login:(id)sender {
    [self.view endEditing:YES];
    //现在非空判断
    if ([Utils isBlankString:self.et_userName.text]) {
        HUD.mode = MBProgressHUDModeText;
        HUD.hidden = NO;
        HUD.labelText = @"请输入用户名";
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            HUD.hidden = YES;
        }];
        return;
    }
    if ([Utils isBlankString:self.et_password.text]) {
        HUD.mode = MBProgressHUDModeText;
        HUD.hidden = NO;
        HUD.labelText = @"请输入密码";
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            HUD.hidden = YES;
        }];
        return;
    }
    
    
    activityIndicator.hidden = NO;
    [BmobUser loginWithUsernameInBackground:self.et_userName.text password:self.et_password.text block:^(BmobUser *user, NSError *error) {
        activityIndicator.hidden = YES;
        
        HUD.mode = MBProgressHUDModeText;
        HUD.hidden = NO;
        if (user) {
            HUD.labelText = @"登录成功";
            [HUD showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            } completionBlock:^{
                HUD.hidden = YES;
                
                WLXAppDelegate *appDelegate = (WLXAppDelegate *)[[UIApplication sharedApplication] delegate];
                if ([Utils isBlankString:[user objectForKey:@"nickName"]]) {
                    //进入完善信息页面
                    CompletePersonInfoVC *completeVC = [[CompletePersonInfoVC alloc] init];
                    completeVC.type = 0;
                    appDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:completeVC];
                }
                else {
                    //进入主页
                    appDelegate.window.rootViewController = appDelegate.sideMenuViewController;
                }
            }];
        }
        else {
            HUD.labelText = [[error userInfo] valueForKey:@"error"];
            [HUD showAnimated:YES whileExecutingBlock:^{
                sleep(2);
            } completionBlock:^{
                HUD.hidden = YES;
            }];

        }
        
    }];
    
}


/** 跳转到注册页面 */
- (IBAction)regist:(id)sender
{
    [self.view endEditing:YES];
    RegistVC *registVC = [[RegistVC alloc] init];
    registVC.hasNavBack = YES;
    [self.navigationController pushViewController:registVC animated:YES];
}


- (IBAction)cancel:(id)sender
{
    [self.view endEditing:YES];
}
@end
