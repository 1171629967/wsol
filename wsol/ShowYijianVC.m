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
#import "YijianReplyListVC.h"

@interface ShowYijianVC ()

@end

@implementation ShowYijianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"玩家意见一览";
    self.navigationProtal = self;
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    
    
    
    
   
    
    yijians = [[NSMutableArray alloc] init];
    
    [self doHttp];
    
}



- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Yijian"];
    bquery.limit = 1000;
    [bquery orderByDescending:@"createdAt"];
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
                NSString *objectId = obj.objectId;
                
                
                Yijian *yijian = [[Yijian alloc] initWithContent:content AndObjectId:objectId];
                [yijians addObject:yijian];
            }
            //刷新表格控件
            [tableview reloadData];
            
            
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
    YijianReplyListVC *yijianReplyVC = [[YijianReplyListVC alloc] init];
    yijianReplyVC.hasNavBack = YES;
    NSString *h = [[yijians objectAtIndex:[indexPath row]] objectId];
    yijianReplyVC.replyId = h;
    [self.navigationController pushViewController:yijianReplyVC animated:YES];
    //取消单元格被选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    [MobClick beginLogPageView:@"玩家意见一览"];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"玩家意见一览"];
}


@end
