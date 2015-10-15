//
//  TransationVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/2/10.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "TransationVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import <BmobSDK/Bmob.h>
#import "Transation.h"
#import "TransationTVC.h"




@interface TransationVC ()

@end

@implementation TransationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"吧主担保交易";
    self.navigationProtal = self;
    
    
    
   
    

    
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-20-20)];
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    
    
  
    
    
     transations = [[NSMutableArray alloc] init];
    
    [self doHttp];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)doHttpGetData
{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Transation"];
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
            [transations removeAllObjects];
            
            
            
            for (BmobObject *obj in array) {
                NSString *title = [obj objectForKey:@"title"];
                 NSString *url = [obj objectForKey:@"url"];
                
                Transation *transation = [[Transation alloc] initWithTitle:title Url:url];
                [transations addObject:transation];
            }
            //刷新表格控件
            [tableView reloadData];
            
            
        }
        
    }];
    
    
    

}

- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Information"];
    [bquery whereKey:@"type" equalTo:@"transation_ios"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            headerStr = @"加载数据失败，请重试";
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            BmobObject *obj = [array objectAtIndex:0];
            NSString *des = [obj objectForKey:@"des"];
            NSString *str = [des stringByReplacingOccurrencesOfString:@"$" withString:@"\n"];
            headerStr = str;
            
            
            CGSize cgsize = {0, 0};
            cgsize = [headerStr sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(300, 5000)lineBreakMode:0];
            
            headerHeight = cgsize.height;
            
            
         
            
            emojiLabel = [[MLEmojiLabel alloc] initWithFrame:CGRectMake(10, 10, 300, headerHeight)];
            emojiLabel.emojiDelegate = self;
            emojiLabel.backgroundColor = [UIColor clearColor];
            [emojiLabel setEmojiText:headerStr];
            [emojiLabel sizeToFit];
            emojiLabel.isNeedAtAndPoundSign = YES;
            emojiLabel.numberOfLines = 0;
            emojiLabel.textColor = [UIColor orangeColor];
            emojiLabel.font = [UIFont systemFontOfSize:12];
            tableView.tableHeaderView = emojiLabel;
            
            [self doHttpGetData];
        }
        
    }];
    
    
    
}


- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
            NSLog(@"点击了电话%@",link);
            break;
        case MLEmojiLabelLinkTypeEmail:
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
            NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
    
}



//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}



//返回多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [transations count];
    
}


//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 60;
    
//    Transation *transation = [transations objectAtIndex:[indexPath row]];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    TransationTVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"TransationTVC" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[TransationTVC class]]) {
                cell = (TransationTVC *)o;
                break;
            }
        }
    }
    
    
    
   
        cell.backgroundColor = [UIColor clearColor];
        Transation *transation = [transations objectAtIndex:[indexPath row]];
        
        
        
        cell.lb_title.text = transation.title;
        cell.tv_url.text = transation.url;
        cell.tv_url.dataDetectorTypes = UIDataDetectorTypeLink;
        
        
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
    [MobClick beginLogPageView:@"吧主担保交易页面"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"吧主担保交易页面"];
}

@end
