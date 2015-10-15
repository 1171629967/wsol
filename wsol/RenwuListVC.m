//
//  RenwuListVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/7/29.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "RenwuListVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import <BmobSDK/Bmob.h>
#import "Renwu.h"
#import "RenwuListTVC.h"
#import "RenwuDetailVC.h"

@interface RenwuListVC ()

@end

@implementation RenwuListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"任务列表";
    self.navigationProtal = self;
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-20-20)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    renwus = [[NSMutableArray alloc] init];
    
    [self doHttp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RenwuDetailVC *renwuDetailVC = [[RenwuDetailVC alloc] init];
    renwuDetailVC.hasNavBack = YES;
    renwuDetailVC.renwuId = [[renwus objectAtIndex:[indexPath row]] renwuId];
    [self.navigationController pushViewController:renwuDetailVC animated:YES];
    //取消单元格被选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



//返回多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [renwus count];
    
}


//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    RenwuListTVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"RenwuListTVC" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[RenwuListTVC class]]) {
                cell = (RenwuListTVC *)o;
                
                
                break;
            }
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    Renwu *renwu = [renwus objectAtIndex:[indexPath row]];
    
    
    cell.lb_renwuName.text = [NSString stringWithFormat:@"%d、 %@",((int)[indexPath row]+1),renwu.renwuName];
    
    cell.lb_renwuLevel.text = [NSString stringWithFormat:@"%@",renwu.renwuLevel];
    
    return cell;
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
    [MobClick beginLogPageView:@"任务列表"];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"任务列表"];
}




- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Renwu"];
    bquery.limit = 1000;
    [bquery orderByAscending:@"renwuId"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            [renwus removeAllObjects];
            for (BmobObject *obj in array) {
                int renwuId = [(NSNumber *)[obj objectForKey:@"renwuId"] intValue];
                NSString *renwuName = [obj objectForKey:@"renwuName"];
                NSString *renwuLevel = [obj objectForKey:@"renwuLevel"];
                Renwu *renwu = [[Renwu alloc] initWithRenwuName:renwuName RenwuLevel:renwuLevel RenwuId:renwuId];
                [renwus addObject:renwu];
            }
            //刷新表格控件
            [tableview reloadData];            
        }
        
    }];
}

@end
