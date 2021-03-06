//
//  WLXAppDelegate.m
//  wsol
//
//  Created by 王 李鑫 on 14-8-30.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "WLXAppDelegate.h"

#import "MobClick.h"
#import "Utils.h"
#import <BmobSDK/Bmob.h>
#import "LoginVC.h"
#import "User.h"
#import "CompletePersonInfoVC.h"





@implementation WLXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //友盟统计初始化
    //[MobClick setLogEnabled:YES];
    [MobClick startWithAppkey:@"5402df29fd98c59f3a0120a6" reportPolicy:BATCH   channelId:@""];
    
    //设置bmob的key
    [Bmob registerWithAppKey:@"8763a00a263ee5064e8a55be05f72f3a"];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"F2Tbe9Zo1d20qRQyepeL35Gf"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    self.menuTableVC = [[MenuTableVC alloc] init];
    self.jinpaiWeaponVC = [[JinpaiWeaponVC alloc] init];
    self.sideMenuViewController = [[TWTSideMenuViewController alloc] initWithMenuViewController:self.menuTableVC mainViewController:[[UINavigationController alloc] initWithRootViewController:self.jinpaiWeaponVC]];
    
    
//    self.sideMenuViewController.shadowColor = [UIColor blackColor];
//    self.sideMenuViewController.edgeOffset = (UIOffset) { .horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 18.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 0.5634f : 0.85f;
    self.sideMenuViewController.delegate = self;
    //self.window.rootViewController = self.sideMenuViewController;
    
   
    
    //根据当前是否有登录用户进行处理
    User *user = (User *)[User getCurrentObject];
    if (user) {
        if ([Utils isBlankString:[user objectForKey:@"nickName"]]) {
            CompletePersonInfoVC *completeVC = [[CompletePersonInfoVC alloc] init];
            completeVC.type = 0;
            self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:completeVC];
        }
        else {
            self.window.rootViewController = self.sideMenuViewController;
        }
    }else{
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]];
    }
    
    
   
    //设置整体APP顶部导航栏的颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:100]];
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}




- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //发出通知，开启跑马灯
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadPaomadeng" object:nil];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - TWTSideMenuViewControllerDelegate

- (UIStatusBarStyle)sideMenuViewController:(TWTSideMenuViewController *)sideMenuViewController statusBarStyleForViewController:(UIViewController *)viewController
{
    if (viewController == self.menuTableVC) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)sideMenuViewControllerWillOpenMenu:(TWTSideMenuViewController *)sender {
    NSLog(@"willOpenMenu");
}

- (void)sideMenuViewControllerDidOpenMenu:(TWTSideMenuViewController *)sender {
    NSLog(@"didOpenMenu");
}

- (void)sideMenuViewControllerWillCloseMenu:(TWTSideMenuViewController *)sender {
    NSLog(@"willCloseMenu");
}

- (void)sideMenuViewControllerDidCloseMenu:(TWTSideMenuViewController *)sender {
	NSLog(@"didCloseMenu");
}



//-------------------------------- 退出程序 -----------------------------------------//

- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    self.window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}



- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}



@end
