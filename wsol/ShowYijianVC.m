//
//  ShowYijianVCTableViewController.m
//  wsol
//
//  Created by 王 李鑫 on 15/1/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "ShowYijianVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import <BmobSDK/Bmob.h>
#import "Yijian.h"
#import "ShowYijianTVC.h"

@interface ShowYijianVC ()

@end

@implementation ShowYijianVC

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
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"玩家意见一览";
    label.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView = label;
    
    
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_background.png"]];
    
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);//只能设置中心，不能设置大小
    activityIndicator.hidden = YES;
    [self.view addSubview:activityIndicator];
    
    yijians = [[NSMutableArray alloc] init];
    
    [self doHttp];
    
}



- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Yijian"];
    bquery.limit = 1000;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            [yijians removeAllObjects];
            
            
            
            for (BmobObject *obj in array) {
                NSString *content = [obj objectForKey:@"content"];
               
                
                
                Yijian *yijian = [[Yijian alloc] initWithContent:content];
                [yijians addObject:yijian];
            }
            //刷新表格控件
            [self.tableView reloadData];
            
            
        }
        
    }];
    
  
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}



//返回多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [yijians count];
    
}


//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Yijian *yijian = [yijians objectAtIndex:[indexPath row]];
    return yijian.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    ShowYijianTVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"ShowYijianTVC" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[ShowYijianTVC class]]) {
                cell = (ShowYijianTVC *)o;
                
                lb_content = [[UILabel alloc] init];
                lb_content.numberOfLines = 0;
                lb_content.textColor = [UIColor whiteColor];
                lb_content.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:lb_content];
                
                break;
            }
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    Yijian *yijian = [yijians objectAtIndex:[indexPath row]];
    
    
    
    
   
    
   
    int h =yijian.contentHeight;
    
    [lb_content setFrame:CGRectMake(10, 10, 300, h)];
    lb_content.text = yijian.content;
    
    
    
    
    return cell;
}

- (void)refreshButtonPressed
{
    [self doHttp];
}

- (void)openButtonPressed
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"玩家意见一览"];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"玩家意见一览"];
}


@end
