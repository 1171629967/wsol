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
#import "RenwuVC.h"
#import "AboutApp.h"


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



- (IBAction)action_1_1:(id)sender {
    if ([currentVC isEqualToString:@"1_1"]) {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
    else
    {
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[WeaponVC new]];
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    }
    currentVC = @"1_1";
}

- (IBAction)action_2_1:(id)sender {
    if ([currentVC isEqualToString:@"2_1"]) {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
    else
    {
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[RenwuVC new]];
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
        
    }
    currentVC = @"2_1";
}

- (IBAction)action_4_1:(id)sender {
    if ([currentVC isEqualToString:@"4_1"]) {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
    else
    {
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[AboutApp new]];
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
        
    }
    currentVC = @"4_1";
}
@end
