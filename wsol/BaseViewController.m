//
//  BaseViewController.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/7.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"
#import "Utils.h"
#import "TWTSideMenuViewController.h"



@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO; 
    
    if (!self.hasNavBack) {
        //设置navigationBar左边按钮
        self.leftItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(leftPressed)];
        self.leftItem.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = self.leftItem;
    }
    
    
    
    //设置navigationBar右边按钮
    self.rightItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(rightPressed)];
    self.rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    //改变navigationBar标题
    CGRect rect = CGRectMake(0, 0, 200, 44);
    self.label = [[UILabel alloc] initWithFrame:rect];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = UITextAlignmentCenter;
    //label.text = @"意见和建议";
    self.label.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView = self.label;
    
    //设置主题颜色
    [self setCurrentAppTheme:self.view];
    
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);//只能设置中心，不能设置大小
    activityIndicator.hidden = YES;
    [self.view addSubview:activityIndicator];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];  
    
    //注册更换APP主题的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAppTheme) name:Notification_CHANGE_APP_THEME object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftPressed
{
    [self.navigationProtal leftAction];
}


- (void)rightPressed
{
    [self.navigationProtal rightAction];
}

/** 改变APP主题 */
- (void)changeAppTheme
{
    [self changeAppTheme:self.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)changeAppTheme :(UIView *) view
{
    
    
    [self setCurrentAppTheme:view];
    
}

- (void)setCurrentAppTheme :(UIView *) view
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int currentTheme = (int)[userDefaults integerForKey:UserDefaultsKey_CurrentAppTheme];
    
    
    switch (currentTheme) {
        case 0:
            view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"appbg0.png"]];
            break;
        case 1:
            view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"appbg1.png"]];
            break;
        case 2:
            view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"appbg2.png"]];
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
        case 8:
            
            break;
        case 9:
            
            break;
        case 10:
            
            break;
        case 11:
            
            break;
        case 12:
            
            break;
            
            
    }
    
//    if (view != NULL) {
//        if (newShadow == NULL) {
//            newShadow = [[CAGradientLayer alloc] init];
//            CGRect newShadowFrame = CGRectMake(0, 0, SCREEN_WIDTH  , SCREEN_HEIGHT);
//            newShadow.frame = newShadowFrame;
//            //添加渐变的颜色组合
//            newShadow.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor,(id)[UIColor blackColor].CGColor,nil];
//            //设置当前页面的颜色
//            [view.layer addSublayer:newShadow];
//        }
//        else {
//            newShadow.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor,(id)[UIColor blackColor].CGColor,nil];
//        }
//       
//    }
    //设置NavigationBar的颜色
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:red green:green blue:blue alpha:1]];
    
}


@end
