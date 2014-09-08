//
//  MenuVC.m
//  wsol
//
//  Created by 王 李鑫 on 14-9-7.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "MenuVC.h"
#import "TWTSideMenuViewController.h"
#import "WeaponVC.h"
#import "LoadhtmlVC.h"
#import "LoadtxtVC.h"


@interface MenuVC ()

@end

@implementation MenuVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
   currentVC = @"1_1";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//金牌武器上升值
- (IBAction)jinpaiwuqi:(id)sender {
    if ([currentVC isEqualToString:@"jinpaiwuqi"]) {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
    else
    {
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[[WeaponVC alloc] init]];
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    }
    currentVC = @"jinpaiwuqi";
}

//任务报酬一览
- (IBAction)renwubaochou:(id)sender {
    if ([currentVC isEqualToString:@"renwubaochou"]) {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
    else
    {
        LoadhtmlVC *htmlVC = [[LoadhtmlVC alloc] init];
        htmlVC.htmlName = @"renwubaochou";
        htmlVC.titleName = @"任务报酬一览";
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:htmlVC];
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
        
    }
    currentVC = @"renwubaochou";
}

//关于app
- (IBAction)aboutapp:(id)sender {
    if ([currentVC isEqualToString:@"aboutapp"]) {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
    else
    {
        LoadtxtVC *txtVC = [[LoadtxtVC alloc] init];
        txtVC.txtName = @"aboutapp";
        txtVC.titleName = @"关于APP";
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:txtVC];
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
        
    }
    currentVC = @"aboutapp";
}

//任务等级表
- (IBAction)renwudengji:(id)sender {
    if ([currentVC isEqualToString:@"renwudengji"]) {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
    else
    {
        LoadhtmlVC *htmlVC = [[LoadhtmlVC alloc] init];
        htmlVC.htmlName = @"renwudengji";
        htmlVC.titleName = @"任务等级表";
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:htmlVC];
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
        
    }
    currentVC = @"renwudengji";

}
@end
