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
#import <BmobSDK/Bmob.h>
#import "Utils.h"

@interface MeizhouhuodongVC ()

@end

@implementation MeizhouhuodongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"每周活动";
    self.navigationProtal = self;
    
   
    
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [textView setEditable:NO];
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor whiteColor];
    textView.font = [UIFont fontWithName:@"Arial" size:20];
    [self.view addSubview:textView];
    
   
    
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
    
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Information"];
    [bquery whereKey:@"type" equalTo:@"activity_everyweek_ios"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            textView.text = @"加载数据失败，请重试";
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            BmobObject *obj = [array objectAtIndex:0];
            NSString *des = [obj objectForKey:@"des"];
            NSString *str = [des stringByReplacingOccurrencesOfString:@"$" withString:@"\n"];
            textView.text = str;
        }
            
    }];
    
    
   
}



-(void)leftAction
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

-(void)rightAction
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
