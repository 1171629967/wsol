//
//  AboutApp.m
//  wsol
//
//  Created by 王 李鑫 on 14-9-7.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "LoadtxtVC.h"
#import "TWTSideMenuViewController.h"

@interface LoadtxtVC ()

@end

@implementation LoadtxtVC

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
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    //[[super rightItem] setTitle:@""];
    [super label].text = self.titleName;
    self.navigationProtal = self;
    
    self.textview.backgroundColor = [UIColor clearColor];
    
    
    
    //    获取txt文件路径
    NSString *txtPath = [[NSBundle mainBundle] pathForResource:self.txtName ofType:@"txt"];
    //    将txt到string对象中，编码类型为NSUTF8StringEncoding
    NSString *string = [[NSString  alloc] initWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
    self.textview.text = string;
}


-(void)leftAction
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

-(void)rightAction
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
