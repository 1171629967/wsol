//
//  BaseViewController.h
//  wsol
//
//  Created by 王 李鑫 on 15/5/7.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@protocol NavigationProtal <NSObject>
-(void)leftAction;
-(void)rightAction;
@end

@interface BaseViewController : UIViewController
{
    CAGradientLayer *newShadow;
    MBProgressHUD *HUD;
    UIActivityIndicatorView *activityIndicator;
}

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIBarButtonItem *leftItem;
@property (strong, nonatomic) UIBarButtonItem *rightItem;
@property (nonatomic,assign) id<NavigationProtal> navigationProtal;

@property (nonatomic) BOOL hasNavBack;




@end
