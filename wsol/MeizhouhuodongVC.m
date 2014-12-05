//
//  MeizhouhuodongVC.m
//  wsol
//
//  Created by 王 李鑫 on 14/12/5.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "MeizhouhuodongVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import "PMHelper.h"


@interface MeizhouhuodongVC ()

@end

@implementation MeizhouhuodongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    openItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = openItem;
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refreshButtonPressed)];
    refreshItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = refreshItem;
    
    //改变navigationBar标题
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"每周活动";
    label.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView = label;
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [textView setEditable:NO];
    textView.backgroundColor = [UIColor grayColor];
    textView.textColor = [UIColor whiteColor];
    textView.font = [UIFont fontWithName:@"Arial" size:20];
    [self.view addSubview:textView];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);//只能设置中心，不能设置大小
    activityIndicator.hidden = YES;
    [self.view addSubview:activityIndicator];
    
    [self doHttp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    NSString *str = [NSString stringWithFormat:@"%@?key=%@&info=%@",TULING_API,TULING_KEY,TULING_QUESTION1];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    // 当以文本形式读取返回内容时用这个方法
    //NSString *responseString = [request responseString];
    NSString *text = [request responseJsonDataWithKey:@"text"];
    NSString *str = [text stringByReplacingOccurrencesOfString:@"\$" withString:@"\n"];
    textView.text = str;
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    textView.text = @"加载数据失败，请重试";
    NSError *error = [request error];    
}

- (void)openButtonPressed
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

- (void)refreshButtonPressed
{
    [self doHttp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"每周活动页面"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"每周活动页面"];
}

@end
