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
#import "WeaponVC.h"


@interface WLXAppDelegate : UIResponder <UIApplicationDelegate,TWTSideMenuViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) TWTSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) MenuTableVC *menuTableVC;
@property (nonatomic, strong) WeaponVC *weaponVC;

@property BOOL isOpenAD;




@end
