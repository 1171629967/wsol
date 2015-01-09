//
//  NeizhengdengjiVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/1/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "NeizhengdengjiVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import "NeizhengdengjiTVC.h"

@interface NeizhengdengjiVC ()

@end

@implementation NeizhengdengjiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    openItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = openItem;
    
   
    
    //改变navigationBar标题
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"内政等级表";
    label.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView = label;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 20)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    UILabel *lb_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    lb_1.text = @"内政等级";
    lb_1.textColor = [UIColor blackColor];
    lb_1.font = [UIFont systemFontOfSize:10];
    lb_1.textAlignment = NSTextAlignmentCenter;
    lb_1.backgroundColor = [UIColor greenColor];
    [view addSubview:lb_1];
    UILabel *lb_2 = [[UILabel alloc] initWithFrame:CGRectMake(81, 0, 80, 20)];
    lb_2.text = @"升下级所需";
    lb_2.textColor = [UIColor blackColor];
    lb_2.font = [UIFont systemFontOfSize:10];
    lb_2.textAlignment = NSTextAlignmentCenter;
    lb_2.backgroundColor = [UIColor greenColor];
    [view addSubview:lb_2];
    UILabel *lb_3 = [[UILabel alloc] initWithFrame:CGRectMake(161, 0, 80, 20)];
    lb_3.text = @"与上级差值";
    lb_3.textColor = [UIColor blackColor];
    lb_3.font = [UIFont systemFontOfSize:10];
    lb_3.textAlignment = NSTextAlignmentCenter;
    lb_3.backgroundColor = [UIColor greenColor];
    [view addSubview:lb_3];
    UILabel *lb_4 = [[UILabel alloc] initWithFrame:CGRectMake(241, 0, 80, 20)];
    lb_4.text = @"总内政值";
    lb_4.textColor = [UIColor blackColor];
    lb_4.font = [UIFont systemFontOfSize:10];
    lb_4.textAlignment = NSTextAlignmentCenter;
    lb_4.backgroundColor = [UIColor greenColor];
    [view addSubview:lb_4];
    
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, SCREEN_WIDTH, SCREEN_HEIGHT-84)];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    neizhengDataArray = [neizhengData componentsSeparatedByString:@","];
    
}





#pragma mark - Table view delegate
//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}


#pragma mark - Table view data source
//返回多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [neizhengDataArray count];
}

//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    NeizhengdengjiTVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"NeizhengdengjiTVC" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[NeizhengdengjiTVC class]]) {
                cell = (NeizhengdengjiTVC *)o;
                break;
            }
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.lb1.text = [NSString stringWithFormat:@"%d",[indexPath row]];
    //总内政值
    cell.lb4.text = [neizhengDataArray objectAtIndex:[indexPath row]];
    //升下级所需
    if ([indexPath row] == 0) {
        cell.lb2.text = @"10";
    }
    else {
        int b = [[neizhengDataArray objectAtIndex:[indexPath row]] intValue];
        int a = [[neizhengDataArray objectAtIndex:[indexPath row]-1] intValue];
        cell.lb2.text = [NSString stringWithFormat:@"%d",b-a];
    }
    //与上级等级差
    if ([indexPath row] <= 50) {
        cell.lb3.text = @"2";
    }
    else if([indexPath row] > 50 && [indexPath row] <= 90){
        cell.lb3.text = @"4";
    }
    else if([indexPath row] > 90 && [indexPath row] <= 100){
        cell.lb3.text = @"6";
    }
    else if([indexPath row] > 100 && [indexPath row] <= 130){
        cell.lb3.text = @"12";
    }
    
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openButtonPressed
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"内政等级表页面"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"内政等级表页面"];
}


@end
