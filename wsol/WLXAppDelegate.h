//
//  WLXAppDelegate.h
//  wsol
//
//  Created by 王 李鑫 on 14-8-30.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTSideMenuViewController.h"
#import "MenuTableVC.h"
#import "JinpaiWeaponVC.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件


@interface WLXAppDelegate : UIResponder <UIApplicationDelegate,TWTSideMenuViewControllerDelegate>
{
    BMKMapManager* _mapManager;    
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) TWTSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) MenuTableVC *menuTableVC;
@property (nonatomic, strong) JinpaiWeaponVC *jinpaiWeaponVC;

- (void)exitApplication;



@property BOOL isOpenAD;




@end
