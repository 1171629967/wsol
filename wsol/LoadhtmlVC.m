//
//  RenwuVC.m
//  wsol
//
//  Created by 王 李鑫 on 14-9-7.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "LoadhtmlVC.h"
#import "TWTSideMenuViewController.h"

@interface LoadhtmlVC ()

@end

@implementation LoadhtmlVC

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
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    openItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = openItem;
    
    //改变navigationBar标题
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = self.titleName;
    label.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView = label;
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:self.htmlName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    self.webview.delegate = self;
    [self.webview loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
}


- (void)openButtonPressed
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
