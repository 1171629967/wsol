//
//  RegistVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/20.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "RegistVC.h"
#import "User.h"
#import "WLXAppDelegate.h"
#import "CompletePersonInfoVC.h"
#import "Utils.h"

@interface RegistVC ()

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [super label].text = @"注册";
    
    self.bt_cancel.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.bt_rigistConfirm.layer.borderWidth = 1;
    self.bt_rigistConfirm.layer.borderColor = [[UIColor whiteColor]CGColor];
    [self.et_password setSecureTextEntry:YES];
    
    
    //左上角返回按钮白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancle:(id)sender {
    [self.view endEditing:YES];
}

//执行注册操作
- (IBAction)registConfirm:(id)sender {
    [self.view endEditing:YES];
    
    //现在非空判断
    if ([Utils isBlankString:self.et_userName.text]) {
        HUD.mode = MBProgressHUDModeText;
        HUD.hidden = NO;
        HUD.labelText = @"请输入邮箱作为账号";
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
    //开始执行注册接口调用
    User *user = [[User alloc] init];
    [user setUserName:self.et_userName.text];
    [user setEmail:self.et_userName.text];
    [user setPassword:self.et_password.text];
    //设置系统版本号
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *systemVersionStr = [NSString stringWithFormat:@"IOS  %f",systemVersion];
    [user setObject:systemVersionStr forKey:@"registOS"];
    
    
    
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        activityIndicator.hidden = YES;
        HUD.mode = MBProgressHUDModeText;
        HUD.hidden = NO;
        if (isSuccessful) {
            HUD.labelText = @"注册成功";
            [HUD showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            } completionBlock:^{
                HUD.hidden = YES;
                //进入完善信息页面
                WLXAppDelegate *appDelegate = (WLXAppDelegate *)[[UIApplication sharedApplication] delegate];
                CompletePersonInfoVC *completeVC = [[CompletePersonInfoVC alloc] init];
                completeVC.type = 0;
                appDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:completeVC];
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
@end
