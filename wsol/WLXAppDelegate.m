//
//  WLXAppDelegate.m
//  wsol
//
//  Created by 王 李鑫 on 14-8-30.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "WLXAppDelegate.h"

#import "MobClick.h"
#import "ConfigHeader.h"



@implementation WLXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //友盟统计初始化
    //[MobClick setLogEnabled:YES];
    [MobClick startWithAppkey:@"5402df29fd98c59f3a0120a6" reportPolicy:BATCH   channelId:@""];
    
    //有米广告初始化
    [YouMiNewSpot initYouMiDeveloperParams:@"f33506c35f98564f" YM_SecretId:@"817f789c8e214ae5"];
    //使用前先初始化一下插屏
    [YouMiNewSpot initYouMiDeveLoperSpot:kSPOTSpotTypePortrait];//填上你对应的横竖屏模式
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    self.menuTableVC = [[MenuTableVC alloc] init];
    self.weaponVC = [[WeaponVC alloc] init];
    self.sideMenuViewController = [[TWTSideMenuViewController alloc] initWithMenuViewController:self.menuTableVC mainViewController:[[UINavigationController alloc] initWithRootViewController:self.weaponVC]];
    
    
    //self.sideMenuViewController.shadowColor = [UIColor blackColor];
    //self.sideMenuViewController.edgeOffset = (UIOffset) { .horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 18.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 0.5634f : 0.85f;
    self.sideMenuViewController.delegate = self;
    self.window.rootViewController = self.sideMenuViewController;
    
    
    
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColor]];
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
    //有米广告
    NSString *value = [YouMiNewSpot onlineYouMiValueForKey:@"isOpenAD"];
    if ([value isEqualToString:@"YES"]) {
        [YouMiNewSpot showYouMiSpotAction:^(BOOL flag){
            if (flag) {
                //NSLog(@"log添加展示成功的逻辑");
            }
            else{
                //NSLog(@"log添加展示失败的逻辑");
            }
        }];
    }
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





@end
