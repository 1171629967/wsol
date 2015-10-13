//
//  YijianReplyVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/10/10.
//  Copyright © 2015年 wlx. All rights reserved.
//

#import "YijianReplyListVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import <BmobSDK/Bmob.h>
#import "YijianReply.h"
#import "YijianReplyListCell.h"
#import "Masonry.h"
#import "YijianReplyVC.h"

@interface YijianReplyListVC ()

@end

@implementation YijianReplyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航栏
    [[super rightItem] setTitle:@"回复"];
    [super label].text = @"意见回复列表";
    self.navigationProtal = self;
    
    
    //左上角返回按钮白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    replys = [[NSMutableArray alloc] init];
    
    //[self doHttp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    [self doHttp];
}


- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"YijianReply"];
    bquery.limit = 10000;
    [bquery whereKey:@"replyId" equalTo:self.replyId];
    [bquery orderByDescending:@"createdAt"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            [replys removeAllObjects];
            
            for (BmobObject *obj in array) {
                NSString *content = [obj objectForKey:@"content"];
                //NSString *replyId = [obj objectForKey:@"replyId"] ;
                int from = [[obj objectForKey:@"from"] intValue];
                
                
                                
                YijianReply *reply = [[YijianReply alloc] initWithContent:content AndFrom:from];
                [replys addObject:reply];
            }
            //刷新表格控件
            [tableview reloadData];  
        }
    }];

}




//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}



//返回多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [replys count];
}


//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YijianReply *reply = [replys objectAtIndex:[indexPath row]];
    return reply.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    YijianReplyListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"YijianReplyListCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[YijianReplyListCell class]]) {
                cell = (YijianReplyListCell *)o;
                lb_content = [[UILabel alloc] init];
                lb_content.numberOfLines = 0;
                lb_content.font = [UIFont systemFontOfSize:14];
                [lb_content setLineBreakMode:NSLineBreakByCharWrapping];
                [lb_content sizeToFit];
                [cell.contentView addSubview:lb_content];
//                [lb_content mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(cell.contentView).with.offset(10);
//                    make.top.equalTo(cell.contentView).with.offset(10);
//                    make.right.equalTo(cell.contentView).with.offset(10);
//                    make.bottom.equalTo(cell.contentView).with.offset(10);
//                   
//                }];

                
                
                break;
            }
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    YijianReply *reply = [replys objectAtIndex:[indexPath row]];
    
    if (reply.from == 0) {
        lb_content.textColor = [UIColor whiteColor];
    }
    else if(reply.from == 1){
        lb_content.textColor = [UIColor orangeColor];
    }
    
    //设置回复内容
    lb_content.text = reply.finalReply;
    lb_content.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, reply.contentHeight);

    
    return cell;
}



-(void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)rightAction
{
    YijianReplyVC *replyVC = [[YijianReplyVC alloc] init];
    replyVC.hasNavBack = YES;
    replyVC.replyId = self.replyId;
    [self.navigationController pushViewController:replyVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"意见回复列表"];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"意见回复列表"];
}




@end
