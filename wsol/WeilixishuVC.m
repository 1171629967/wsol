//
//  WeilixishuVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/1/8.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "WeilixishuVC.h"
#import <BmobSDK/Bmob.h>
#import "MobClick.h"

@interface WeilixishuVC ()

@end

@implementation WeilixishuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isShowedExplain = NO;
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refreshButtonPressed)];
    refreshItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = refreshItem;
    
    //改变navigationBar标题
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"武器威力系数";
    label.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView = label;
    
    self.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_background.png"]];
    self.view.userInteractionEnabled = YES;
    [self initViews];
    
    
//    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [textView setEditable:NO];
//    textView.backgroundColor = [UIColor grayColor];
//    textView.textColor = [UIColor whiteColor];
//    textView.font = [UIFont fontWithName:@"Arial" size:20];
//    [self.view addSubview:textView];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);//只能设置中心，不能设置大小
    activityIndicator.hidden = YES;
    [self.view addSubview:activityIndicator];
    
    
    
    [self doHttp];
}





- (void)initViews {
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:scrollView];
    
    //武器名字
    lb_weaponName = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100/2, 0, 100, 30)];
    lb_weaponName.textAlignment = NSTextAlignmentCenter;
    lb_weaponName.font = [UIFont systemFontOfSize: 20.0];
    lb_weaponName.text = self.weaponName;
    [lb_weaponName setTextColor:[UIColor orangeColor]];
    [scrollView addSubview:lb_weaponName];
    //系数说明按钮
    bt_explain = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80-10, 0, 80, 30)];
    bt_explain.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [bt_explain setTitle: @"威力系数说明" forState: UIControlStateNormal];
    [bt_explain setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    [scrollView addSubview:bt_explain];
    [bt_explain addTarget:self action:@selector(loadExplain) forControlEvents:UIControlEventTouchUpInside];
    //系数说明
    lb_explain = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 0, 0)];
    lb_explain.textColor = [UIColor whiteColor];
    [scrollView addSubview:lb_explain];
    //备注
    lb_beizu = [[UILabel alloc] initWithFrame:CGRectMake(10, 40+lb_explain.frame.size.height+10, SCREEN_WIDTH-20, 0)];
    [scrollView addSubview:lb_beizu];
    
    //剩下来的整体View
    allXIshuView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [scrollView addSubview:allXIshuView];
}

/** 加载系数说明 */
- (void)loadExplain
{
    if (isShowedExplain) {
        return;
    }
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Information"];
    [bquery whereKey:@"type" equalTo:@"weilixishu_explain"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            
        }
        else {
            isShowedExplain = YES;
            
            BmobObject *obj = [array objectAtIndex:0];
            NSString *des = [obj objectForKey:@"des"];
            NSString *str = [des stringByReplacingOccurrencesOfString:@"$" withString:@"\n"];
            
            [lb_explain setNumberOfLines:0];
            UIFont *font = [UIFont fontWithName:@"Arial" size:10];
            CGSize size = CGSizeMake(SCREEN_WIDTH-20,2000);
            CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [lb_explain setFrame:CGRectMake(10, 40, labelsize.width, labelsize.height)];
            lb_explain.font = font;
            lb_explain.text = str;
            
            //备注位置向下移动
            [lb_beizu setFrame:CGRectMake(10, lb_beizu.frame.origin.y+labelsize.height, lb_beizu.frame.size.width, lb_beizu.frame.size.height)];
            //allXIshuView位置需要向下移动
            [allXIshuView setFrame:CGRectMake(0, allXIshuView.frame.origin.y+labelsize.height, SCREEN_WIDTH, allXIshuView.frame.size.height)];
            //设置scrollView的滚动范围
            [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, allXIshuView.frame.origin.y+allXIshuView.frame.size.height+10+60)];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(int)getLabelHeightWithLabel:(UILabel *)label AndString:(NSString *)string AndCount:(int) count
{

    UIFont *font = [UIFont systemFontOfSize: 12.0];
    CGSize size = CGSizeMake(SCREEN_WIDTH/count,2000);
    CGSize labelsize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize.height;
}


-(int) getMaxHeightWithArray:(NSArray *)array
{
    int max = [[array objectAtIndex:0] intValue];
    for (int i = 1; i<array.count; i++) {
        int data = [[array objectAtIndex:i] intValue];
        if (data > max) {
            max = data;
        }
    }
    return max;
}

- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Weilixishu"];
    [bquery whereKey:@"weaponName" equalTo:self.weaponName];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            //textView.text = @"加载数据失败，请重试";
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            BmobObject *obj = [array objectAtIndex:0];
            
            
            
            //设置备注
            NSString *beizhu = [obj objectForKey:@"beizhu"];
            if (![beizhu isEqualToString:@""]) {
                
                
                UIFont *font = [UIFont fontWithName:@"Arial" size:10];
                CGSize size = CGSizeMake(SCREEN_WIDTH-20,2000);
                CGSize labelsize = [beizhu sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                
                [lb_beizu setFrame:CGRectMake(10, 40+lb_explain.frame.size.height+10, labelsize.width, labelsize.height)];
                
                lb_beizu.textColor = [UIColor orangeColor];
                [lb_beizu setNumberOfLines:0];
                lb_beizu.font = font;
                lb_beizu.text = beizhu;
                lb_beizu.textAlignment = NSTextAlignmentCenter;
            }
            
            
            //设置武器数值
            int haveData = [[obj objectForKey:@"haveData"] intValue];
            if (haveData == 0) {
                return ;
            }
            
            
            //第一条分割线
            v_line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 1)];
            v_line1.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line1];
            //--------------------------------N1-N6--------------------------------
            lb_N1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH/6, 20)];
            lb_N1.textColor = [UIColor orangeColor];
            lb_N1.text = @"N1";
            lb_N1.font = [UIFont systemFontOfSize: 12.0];
            lb_N1.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_N1];
            lb_N2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6, 15, SCREEN_WIDTH/6, 20)];
            lb_N2.textColor = [UIColor orangeColor];
            lb_N2.text = @"N2";
            lb_N2.font = [UIFont systemFontOfSize: 12.0];
            lb_N2.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_N2];
            lb_N3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*2, 15, SCREEN_WIDTH/6, 20)];
            lb_N3.textColor = [UIColor orangeColor];
            lb_N3.text = @"N3";
            lb_N3.font = [UIFont systemFontOfSize: 12.0];
            lb_N3.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_N3];
            lb_N4 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*3, 15, SCREEN_WIDTH/6, 20)];
            lb_N4.textColor = [UIColor orangeColor];
            lb_N4.text = @"N4";
            lb_N4.font = [UIFont systemFontOfSize: 12.0];
            lb_N4.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_N4];
            lb_N5 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*4, 15, SCREEN_WIDTH/6, 20)];
            lb_N5.textColor = [UIColor orangeColor];
            lb_N5.text = @"N5";
            lb_N5.font = [UIFont systemFontOfSize: 12.0];
            lb_N5.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_N5];
            lb_N6 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*5, 15, SCREEN_WIDTH/6, 20)];
            lb_N6.textColor = [UIColor orangeColor];
            lb_N6.text = @"N6";
            lb_N6.font = [UIFont systemFontOfSize: 12.0];
            lb_N6.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_N6];
            //--------------------------------N1-N6--------------------------------
            //--------------------------------N1-N6数值--------------------------------
            lb_N1data = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH/6, 20)];
            lb_N1data.font = [UIFont systemFontOfSize: 12.0];
            lb_N1data.textAlignment = NSTextAlignmentCenter;
            [lb_N1data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N1data.numberOfLines = 0;
            [allXIshuView addSubview:lb_N1data];
            lb_N2data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6, 40, SCREEN_WIDTH/6, 20)];
            lb_N2data.font = [UIFont systemFontOfSize: 12.0];
            lb_N2data.textAlignment = NSTextAlignmentCenter;
            [lb_N2data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N2data.numberOfLines = 0;
            [allXIshuView addSubview:lb_N2data];
            lb_N3data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*2, 40, SCREEN_WIDTH/6, 20)];
            lb_N3data.font = [UIFont systemFontOfSize: 12.0];
            lb_N3data.textAlignment = NSTextAlignmentCenter;
            [lb_N3data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N3data.numberOfLines = 0;
            [allXIshuView addSubview:lb_N3data];
            lb_N4data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*3, 40, SCREEN_WIDTH/6, 20)];
            lb_N4data.font = [UIFont systemFontOfSize: 12.0];
            lb_N4data.textAlignment = NSTextAlignmentCenter;
            [lb_N4data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N4data.numberOfLines = 0;
            [allXIshuView addSubview:lb_N4data];
            lb_N5data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*4, 40, SCREEN_WIDTH/6, 20)];
            lb_N5data.font = [UIFont systemFontOfSize: 12.0];
            lb_N5data.textAlignment = NSTextAlignmentCenter;
            [lb_N5data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N5data.numberOfLines = 0;
            [allXIshuView addSubview:lb_N5data];
            lb_N6data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*5, 40, SCREEN_WIDTH/6, 20)];
            lb_N6data.font = [UIFont systemFontOfSize: 12.0];
            lb_N6data.textAlignment = NSTextAlignmentCenter;
            [lb_N6data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_N6data.numberOfLines = 0;
            [allXIshuView addSubview:lb_N6data];
            //--------------------------------N1-N6数值--------------------------------
            int N1height = [self getLabelHeightWithLabel:lb_N1data AndString:[obj objectForKey:@"N1"] AndCount:6];
            [self setColorWithLable:lb_N1data AndString:[obj objectForKey:@"N1"] AndColorString:[obj objectForKey:@"N1color"] AndHeight:N1height];
            
            int N2height = [self getLabelHeightWithLabel:lb_N2data AndString:[obj objectForKey:@"N2"] AndCount:6];
            [self setColorWithLable:lb_N2data AndString:[obj objectForKey:@"N2"] AndColorString:[obj objectForKey:@"N2color"] AndHeight:N2height];
            
            int N3height = [self getLabelHeightWithLabel:lb_N3data AndString:[obj objectForKey:@"N3"] AndCount:6];
            [self setColorWithLable:lb_N3data AndString:[obj objectForKey:@"N3"] AndColorString:[obj objectForKey:@"N3color"] AndHeight:N3height];
            
            int N4height = [self getLabelHeightWithLabel:lb_N4data AndString:[obj objectForKey:@"N4"] AndCount:6];
            [self setColorWithLable:lb_N4data AndString:[obj objectForKey:@"N4"] AndColorString:[obj objectForKey:@"N4color"] AndHeight:N4height];
            
            int N5height = [self getLabelHeightWithLabel:lb_N5data AndString:[obj objectForKey:@"N5"] AndCount:6];
            [self setColorWithLable:lb_N5data AndString:[obj objectForKey:@"N5"] AndColorString:[obj objectForKey:@"N5color"] AndHeight:N5height];
            
            int N6height = [self getLabelHeightWithLabel:lb_N6data AndString:[obj objectForKey:@"N6"] AndCount:6];
            [self setColorWithLable:lb_N6data AndString:[obj objectForKey:@"N6"] AndColorString:[obj objectForKey:@"N6color"] AndHeight:N6height];
            //取得第一排最大高度
            NSArray *array1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:N1height],[NSNumber numberWithInt:N2height],[NSNumber numberWithInt:N3height],[NSNumber numberWithInt:N4height],[NSNumber numberWithInt:N5height],[NSNumber numberWithInt:N6height], nil];
            int maxHeight1 = [self getMaxHeightWithArray:array1];
            //第2条分割线
            v_line2 = [[UIView alloc] initWithFrame:CGRectMake(0, lb_N1data.frame.origin.y+maxHeight1+10, SCREEN_WIDTH, 1)];
            v_line2.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line2];
            //--------------------------------E6-E9--------------------------------
            lb_E6 = [[UILabel alloc] initWithFrame:CGRectMake(0, v_line2.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_E6.textColor = [UIColor orangeColor];
            lb_E6.text = @"E6";
            lb_E6.font = [UIFont systemFontOfSize: 12.0];
            lb_E6.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_E6];
            lb_E7 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, v_line2.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_E7.textColor = [UIColor orangeColor];
            lb_E7.text = @"E7";
            lb_E7.font = [UIFont systemFontOfSize: 12.0];
            lb_E7.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_E7];
            lb_E8 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, v_line2.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_E8.textColor = [UIColor orangeColor];
            lb_E8.text = @"E8";
            lb_E8.font = [UIFont systemFontOfSize: 12.0];
            lb_E8.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_E8];
            lb_E9 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, v_line2.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_E9.textColor = [UIColor orangeColor];
            lb_E9.text = @"E9";
            lb_E9.font = [UIFont systemFontOfSize: 12.0];
            lb_E9.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_E9];
            //--------------------------------E6-E9--------------------------------
            //--------------------------------E6-E9数值--------------------------------
            lb_E6data = [[UILabel alloc] initWithFrame:CGRectMake(0, lb_E6.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_E6data.font = [UIFont systemFontOfSize: 12.0];
            lb_E6data.textAlignment = NSTextAlignmentCenter;
            [lb_E6data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_E6data.numberOfLines = 0;
            [allXIshuView addSubview:lb_E6data];
            lb_E7data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, lb_E6.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_E7data.font = [UIFont systemFontOfSize: 12.0];
            lb_E7data.textAlignment = NSTextAlignmentCenter;
            [lb_E7data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_E7data.numberOfLines = 0;
            [allXIshuView addSubview:lb_E7data];
            lb_E8data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, lb_E6.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_E8data.font = [UIFont systemFontOfSize: 12.0];
            lb_E8data.textAlignment = NSTextAlignmentCenter;
            [lb_E8data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_E8data.numberOfLines = 0;
            [allXIshuView addSubview:lb_E8data];
            lb_E9data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, lb_E6.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_E9data.font = [UIFont systemFontOfSize: 12.0];
            lb_E9data.textAlignment = NSTextAlignmentCenter;
            [lb_E9data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_E9data.numberOfLines = 0;
            [allXIshuView addSubview:lb_E9data];
            //--------------------------------E6-E9数值-------------------------------
            int E6height = [self getLabelHeightWithLabel:lb_E6data AndString:[obj objectForKey:@"E6"] AndCount:4];
            [self setColorWithLable:lb_E6data AndString:[obj objectForKey:@"E6"] AndColorString:[obj objectForKey:@"E6color"] AndHeight:E6height];
            
            int E7height = [self getLabelHeightWithLabel:lb_E7data AndString:[obj objectForKey:@"E7"] AndCount:4];
            [self setColorWithLable:lb_E7data AndString:[obj objectForKey:@"E7"] AndColorString:[obj objectForKey:@"E7color"] AndHeight:E7height];
            
            int E8height = [self getLabelHeightWithLabel:lb_E8data AndString:[obj objectForKey:@"E8"] AndCount:4];
            [self setColorWithLable:lb_E8data AndString:[obj objectForKey:@"E8"] AndColorString:[obj objectForKey:@"E8color"] AndHeight:E8height];
            
            int E9height = [self getLabelHeightWithLabel:lb_E9data AndString:[obj objectForKey:@"E9"] AndCount:4];
            [self setColorWithLable:lb_E9data AndString:[obj objectForKey:@"E9"] AndColorString:[obj objectForKey:@"E9color"] AndHeight:E9height];
            //取得第2排最大高度
            NSArray *array2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:E6height],[NSNumber numberWithInt:E7height],[NSNumber numberWithInt:E8height],[NSNumber numberWithInt:E9height], nil];
            int maxHeight2 = [self getMaxHeightWithArray:array2];
            //第3条分割线
            v_line3 = [[UIView alloc] initWithFrame:CGRectMake(0, lb_E6data.frame.origin.y+maxHeight2+10, SCREEN_WIDTH, 1)];
            v_line3.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line3];
            //--------------------------------C2-C5--------------------------------
            lb_C2 = [[UILabel alloc] initWithFrame:CGRectMake(0, v_line3.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_C2.textColor = [UIColor orangeColor];
            lb_C2.text = @"C2";
            lb_C2.font = [UIFont systemFontOfSize: 12.0];
            lb_C2.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_C2];
            lb_C3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, v_line3.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_C3.textColor = [UIColor orangeColor];
            lb_C3.text = @"C3";
            lb_C3.font = [UIFont systemFontOfSize: 12.0];
            lb_C3.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_C3];
            lb_C4 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, v_line3.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_C4.textColor = [UIColor orangeColor];
            lb_C4.text = @"C4";
            lb_C4.font = [UIFont systemFontOfSize: 12.0];
            lb_C4.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_C4];
            lb_C5 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, v_line3.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_C5.textColor = [UIColor orangeColor];
            lb_C5.text = @"C5";
            lb_C5.font = [UIFont systemFontOfSize: 12.0];
            lb_C5.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_C5];
            //--------------------------------C2-C5--------------------------------
            //--------------------------------C2-C5数值--------------------------------
            lb_C2data = [[UILabel alloc] initWithFrame:CGRectMake(0, lb_C2.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_C2data.font = [UIFont systemFontOfSize: 12.0];
            lb_C2data.textAlignment = NSTextAlignmentCenter;
            [lb_C2data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_C2data.numberOfLines = 0;
            [allXIshuView addSubview:lb_C2data];
            lb_C3data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, lb_C2.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_C3data.font = [UIFont systemFontOfSize: 12.0];
            lb_C3data.textAlignment = NSTextAlignmentCenter;
            [lb_C3data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_C3data.numberOfLines = 0;
            [allXIshuView addSubview:lb_C3data];
            lb_C4data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, lb_C2.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_C4data.font = [UIFont systemFontOfSize: 12.0];
            lb_C4data.textAlignment = NSTextAlignmentCenter;
            [lb_C4data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_C4data.numberOfLines = 0;
            [allXIshuView addSubview:lb_C4data];
            lb_C5data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, lb_C2.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_C5data.font = [UIFont systemFontOfSize: 12.0];
            lb_C5data.textAlignment = NSTextAlignmentCenter;
            [lb_C5data setLineBreakMode:NSLineBreakByWordWrapping];
            lb_C5data.numberOfLines = 0;
            [allXIshuView addSubview:lb_C5data];
            //--------------------------------C2-C5数值--------------------------------
            int C2height = [self getLabelHeightWithLabel:lb_C2data AndString:[obj objectForKey:@"C2"] AndCount:4];
            [self setColorWithLable:lb_C2data AndString:[obj objectForKey:@"C2"] AndColorString:[obj objectForKey:@"C2color"] AndHeight:C2height];
            
            int C3height = [self getLabelHeightWithLabel:lb_C3data AndString:[obj objectForKey:@"C3"] AndCount:4];
            [self setColorWithLable:lb_C3data AndString:[obj objectForKey:@"C3"] AndColorString:[obj objectForKey:@"C3color"] AndHeight:C3height];
            
            int C4height = [self getLabelHeightWithLabel:lb_C4data AndString:[obj objectForKey:@"C4"] AndCount:4];
            [self setColorWithLable:lb_C4data AndString:[obj objectForKey:@"C4"] AndColorString:[obj objectForKey:@"C4color"] AndHeight:C4height];
            
            int C5height = [self getLabelHeightWithLabel:lb_C5data AndString:[obj objectForKey:@"C5"] AndCount:4];
            [self setColorWithLable:lb_C5data AndString:[obj objectForKey:@"C5"] AndColorString:[obj objectForKey:@"C5color"] AndHeight:C5height];
            //取得第3排最大高度
            NSArray *array3 = [NSArray arrayWithObjects:[NSNumber numberWithInt:C2height],[NSNumber numberWithInt:C3height],[NSNumber numberWithInt:C4height],[NSNumber numberWithInt:C5height], nil];
            int maxHeight3 = [self getMaxHeightWithArray:array3];
            //第4条分割线
            v_line4 = [[UIView alloc] initWithFrame:CGRectMake(0, lb_C2data.frame.origin.y+maxHeight3+10, SCREEN_WIDTH, 1)];
            v_line4.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line4];
            //--------------------------------D,JA,JC--------------------------------
            lb_D = [[UILabel alloc] initWithFrame:CGRectMake(0, v_line4.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_D.textColor = [UIColor orangeColor];
            lb_D.text = @"D";
            lb_D.font = [UIFont systemFontOfSize: 12.0];
            lb_D.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_D];
            lb_JA = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, v_line4.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_JA.textColor = [UIColor orangeColor];
            lb_JA.text = @"JA";
            lb_JA.font = [UIFont systemFontOfSize: 12.0];
            lb_JA.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_JA];
            lb_JC = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, v_line4.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_JC.textColor = [UIColor orangeColor];
            lb_JC.text = @"JC";
            lb_JC.font = [UIFont systemFontOfSize: 12.0];
            lb_JC.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_JC];
            //--------------------------------D,JA,JC--------------------------------
            //--------------------------------D,JA,JC数值--------------------------------
            lb_Ddata = [[UILabel alloc] initWithFrame:CGRectMake(0, lb_D.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_Ddata.font = [UIFont systemFontOfSize: 12.0];
            [lb_Ddata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_Ddata.numberOfLines = 0;
            lb_Ddata.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_Ddata];
            lb_JAdata = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, lb_D.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_JAdata.font = [UIFont systemFontOfSize: 12.0];
            [lb_JAdata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_JAdata.numberOfLines = 0;
            lb_JAdata.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_JAdata];
            lb_JCdata = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, lb_D.frame.origin.y+20+5, SCREEN_WIDTH/4, 20)];
            lb_JCdata.font = [UIFont systemFontOfSize: 12.0];
            [lb_JCdata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_JCdata.numberOfLines = 0;
            lb_JCdata.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_JCdata];
            //--------------------------------D,JA,JC数值--------------------------------
            int Dheight = [self getLabelHeightWithLabel:lb_Ddata AndString:[obj objectForKey:@"D"] AndCount:4];
            [self setColorWithLable:lb_Ddata AndString:[obj objectForKey:@"D"] AndColorString:[obj objectForKey:@"Dcolor"] AndHeight:Dheight];
            
            int JAheight = [self getLabelHeightWithLabel:lb_JAdata AndString:[obj objectForKey:@"JA"] AndCount:4];
            [self setColorWithLable:lb_JAdata AndString:[obj objectForKey:@"JA"] AndColorString:[obj objectForKey:@"JAcolor"] AndHeight:JAheight];
            
            int JCheight = [self getLabelHeightWithLabel:lb_JCdata AndString:[obj objectForKey:@"JC"] AndCount:4];
            [self setColorWithLable:lb_JCdata AndString:[obj objectForKey:@"JC"] AndColorString:[obj objectForKey:@"JCcolor"] AndHeight:JCheight];
            //取得第4排最大高度
            NSArray *array4 = [NSArray arrayWithObjects:[NSNumber numberWithInt:Dheight],[NSNumber numberWithInt:JAheight],[NSNumber numberWithInt:JCheight], nil];
            int maxHeight4 = [self getMaxHeightWithArray:array4];
            //第5条分割线
            v_line5 = [[UIView alloc] initWithFrame:CGRectMake(0, lb_Ddata.frame.origin.y+maxHeight4+10, SCREEN_WIDTH, 1)];
            v_line5.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line5];
            //--------------------------------刻印--------------------------------
            lb_tu = [[UILabel alloc] initWithFrame:CGRectMake(0, v_line5.frame.origin.y+5, SCREEN_WIDTH/6, 20)];
            lb_tu.textColor = [UIColor orangeColor];
            lb_tu.text = @"突";
            lb_tu.font = [UIFont systemFontOfSize: 12.0];
            lb_tu.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_tu];
            lb_dun = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6, v_line5.frame.origin.y+5, SCREEN_WIDTH/6, 20)];
            lb_dun.textColor = [UIColor orangeColor];
            lb_dun.text = @"盾";
            lb_dun.font = [UIFont systemFontOfSize: 12.0];
            lb_dun.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_dun];
            lb_sui = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*2, v_line5.frame.origin.y+5, SCREEN_WIDTH/6, 20)];
            lb_sui.textColor = [UIColor orangeColor];
            lb_sui.text = @"碎";
            lb_sui.font = [UIFont systemFontOfSize: 12.0];
            lb_sui.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_sui];
            lb_zhen = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*3, v_line5.frame.origin.y+5, SCREEN_WIDTH/6, 20)];
            lb_zhen.textColor = [UIColor orangeColor];
            lb_zhen.text = @"阵";
            lb_zhen.font = [UIFont systemFontOfSize: 12.0];
            lb_zhen.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_zhen];
            lb_wei = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*4, v_line5.frame.origin.y+5, SCREEN_WIDTH/6, 20)];
            lb_wei.textColor = [UIColor orangeColor];
            lb_wei.text = @"卫";
            lb_wei.font = [UIFont systemFontOfSize: 12.0];
            lb_wei.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_wei];
            lb_ba = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*5, v_line5.frame.origin.y+5, SCREEN_WIDTH/6, 20)];
            lb_ba.textColor = [UIColor orangeColor];
            lb_ba.text = @"霸";
            lb_ba.font = [UIFont systemFontOfSize: 12.0];
            lb_ba.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_ba];
            //--------------------------------刻印--------------------------------
            //--------------------------------刻印数值--------------------------------
            lb_tudata = [[UILabel alloc] initWithFrame:CGRectMake(0, lb_tu.frame.origin.y+20+5, SCREEN_WIDTH/6, 40)];
            lb_tudata.font = [UIFont systemFontOfSize: 12.0];
            lb_tudata.textAlignment = NSTextAlignmentCenter;
            [lb_tudata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_tudata.numberOfLines = 0;
            [allXIshuView addSubview:lb_tudata];
            lb_dundata = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6, lb_tu.frame.origin.y+20+5, SCREEN_WIDTH/6, 40)];
            lb_dundata.font = [UIFont systemFontOfSize: 12.0];
            lb_dundata.textAlignment = NSTextAlignmentCenter;
            [lb_dundata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_dundata.numberOfLines = 0;
            [allXIshuView addSubview:lb_dundata];
            lb_suidata = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*2, lb_tu.frame.origin.y+20+5, SCREEN_WIDTH/6, 40)];
            lb_suidata.font = [UIFont systemFontOfSize: 12.0];
            lb_suidata.textAlignment = NSTextAlignmentCenter;
            [lb_suidata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_suidata.numberOfLines = 0;
            [allXIshuView addSubview:lb_suidata];
            lb_zhendata = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*3, lb_tu.frame.origin.y+20+5, SCREEN_WIDTH/6, 40)];
            lb_zhendata.font = [UIFont systemFontOfSize: 12.0];
            lb_zhendata.textAlignment = NSTextAlignmentCenter;
            [lb_zhendata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_zhendata.numberOfLines = 0;
            [allXIshuView addSubview:lb_zhendata];
            lb_weidata = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*4, lb_tu.frame.origin.y+20+5, SCREEN_WIDTH/6, 60)];
            lb_weidata.font = [UIFont systemFontOfSize: 12.0];
            lb_weidata.textAlignment = NSTextAlignmentCenter;
            [lb_weidata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_weidata.numberOfLines = 0;
            [allXIshuView addSubview:lb_weidata];
            lb_badata = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6*5, lb_tu.frame.origin.y+20+5, SCREEN_WIDTH/6, 40)];
            lb_badata.font = [UIFont systemFontOfSize: 12.0];
            lb_badata.textAlignment = NSTextAlignmentCenter;
            [lb_badata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_badata.numberOfLines = 0;
            [allXIshuView addSubview:lb_badata];
            //--------------------------------刻印数值--------------------------------
            int tuheight = [self getLabelHeightWithLabel:lb_tudata AndString:[obj objectForKey:@"tu"] AndCount:6];
            [self setColorWithLable:lb_tudata AndString:[obj objectForKey:@"tu"] AndColorString:[obj objectForKey:@"tucolor"] AndHeight:tuheight];
            
            int dunheight = [self getLabelHeightWithLabel:lb_dundata AndString:[obj objectForKey:@"dun"] AndCount:6];
            [self setColorWithLable:lb_dundata AndString:[obj objectForKey:@"dun"] AndColorString:[obj objectForKey:@"duncolor"] AndHeight:dunheight];
            
            int suiheight = [self getLabelHeightWithLabel:lb_suidata AndString:[obj objectForKey:@"sui"] AndCount:6];
            [self setColorWithLable:lb_suidata AndString:[obj objectForKey:@"sui"] AndColorString:[obj objectForKey:@"suicolor"] AndHeight:suiheight];
            
            int zhenheight = [self getLabelHeightWithLabel:lb_zhendata AndString:[obj objectForKey:@"zhen"] AndCount:6];
            [self setColorWithLable:lb_zhendata AndString:[obj objectForKey:@"zhen"] AndColorString:[obj objectForKey:@"zhencolor"] AndHeight:zhenheight];
            
            int weiheight = [self getLabelHeightWithLabel:lb_weidata AndString:[obj objectForKey:@"wei"] AndCount:6];
            [self setColorWithLable:lb_weidata AndString:[obj objectForKey:@"wei"] AndColorString:[obj objectForKey:@"weicolor"] AndHeight:weiheight];
            
            int baheight = [self getLabelHeightWithLabel:lb_badata AndString:[obj objectForKey:@"ba"] AndCount:6];
            [self setColorWithLable:lb_badata AndString:[obj objectForKey:@"ba"] AndColorString:[obj objectForKey:@"bacolor"] AndHeight:baheight];
            //取得第5排最大高度
            NSArray *array5 = [NSArray arrayWithObjects:[NSNumber numberWithInt:tuheight],[NSNumber numberWithInt:dunheight],[NSNumber numberWithInt:suiheight],[NSNumber numberWithInt:zhenheight],[NSNumber numberWithInt:weiheight],[NSNumber numberWithInt:baheight], nil];
            int maxHeight5 = [self getMaxHeightWithArray:array5];
            //第6条分割线
            v_line6 = [[UIView alloc] initWithFrame:CGRectMake(0, lb_tudata.frame.origin.y+maxHeight5+10, SCREEN_WIDTH, 1)];
            v_line6.backgroundColor = [UIColor grayColor];
            [allXIshuView addSubview:v_line6];
            //--------------------------------无双--------------------------------
            lb_puwuAndZhenwu = [[UILabel alloc] initWithFrame:CGRectMake(0, v_line6.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_puwuAndZhenwu.textColor = [UIColor orangeColor];
            lb_puwuAndZhenwu.text = @"无双/真无";
            lb_puwuAndZhenwu.font = [UIFont systemFontOfSize: 12.0];
            lb_puwuAndZhenwu.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_puwuAndZhenwu];
            lb_pumo = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, v_line6.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_pumo.textColor = [UIColor orangeColor];
            lb_pumo.text = @"普末";
            lb_pumo.font = [UIFont systemFontOfSize: 12.0];
            lb_pumo.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_pumo];
            lb_zhenmo = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, v_line6.frame.origin.y+5, SCREEN_WIDTH/4, 20)];
            lb_zhenmo.textColor = [UIColor orangeColor];
            lb_zhenmo.text = @"真末";
            lb_zhenmo.font = [UIFont systemFontOfSize: 12.0];
            lb_zhenmo.textAlignment = NSTextAlignmentCenter;
            [allXIshuView addSubview:lb_zhenmo];
            //--------------------------------无双--------------------------------
            //--------------------------------无双数值--------------------------------
            lb_puwuAndZhenwudata = [[UILabel alloc] initWithFrame:CGRectMake(0, lb_puwuAndZhenwu.frame.origin.y+20+5, SCREEN_WIDTH/4, 40)];
            lb_puwuAndZhenwudata.font = [UIFont systemFontOfSize: 12.0];
            lb_puwuAndZhenwudata.textAlignment = NSTextAlignmentCenter;
            [lb_puwuAndZhenwudata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_puwuAndZhenwudata.numberOfLines = 0;
            [allXIshuView addSubview:lb_puwuAndZhenwudata];
            lb_pumodata = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, lb_puwuAndZhenwu.frame.origin.y+20+5, SCREEN_WIDTH/4, 40)];
            lb_pumodata.font = [UIFont systemFontOfSize: 12.0];
            lb_pumodata.textAlignment = NSTextAlignmentCenter;
            [lb_pumodata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_pumodata.numberOfLines = 0;
            [allXIshuView addSubview:lb_pumodata];
            lb_zhenmodata = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, lb_puwuAndZhenwu.frame.origin.y+20+5, SCREEN_WIDTH/4, 40)];
            lb_zhenmodata.font = [UIFont systemFontOfSize: 12.0];
            lb_zhenmodata.textAlignment = NSTextAlignmentCenter;
            [lb_zhenmodata setLineBreakMode:NSLineBreakByWordWrapping];
            lb_zhenmodata.numberOfLines = 0;
            [allXIshuView addSubview:lb_zhenmodata];
            //--------------------------------无双数值--------------------------------
            int puwuAndZhenwuHeight = [self getLabelHeightWithLabel:lb_puwuAndZhenwudata AndString:[obj objectForKey:@"puwuAndZhenwu"] AndCount:4];
            [self setColorWithLable:lb_puwuAndZhenwudata AndString:[obj objectForKey:@"puwuAndZhenwu"] AndColorString:[obj objectForKey:@"puwuAndZhenwucolor"] AndHeight:puwuAndZhenwuHeight];
            
            int pumoHeight = [self getLabelHeightWithLabel:lb_pumodata AndString:[obj objectForKey:@"pumo"] AndCount:4];
            [self setColorWithLable:lb_pumodata AndString:[obj objectForKey:@"pumo"] AndColorString:[obj objectForKey:@"pumocolor"] AndHeight:pumoHeight];
            
            int zhenmoHeight = [self getLabelHeightWithLabel:lb_zhenmodata AndString:[obj objectForKey:@"zhenmo"] AndCount:4];
            [self setColorWithLable:lb_zhenmodata AndString:[obj objectForKey:@"zhenmo"] AndColorString:[obj objectForKey:@"zhenmocolor"] AndHeight:zhenmoHeight];
            //取得第6排最大高度
            NSArray *array6 = [NSArray arrayWithObjects:[NSNumber numberWithInt:puwuAndZhenwuHeight],[NSNumber numberWithInt:pumoHeight],[NSNumber numberWithInt:zhenmoHeight], nil];
            int maxHeight6 = [self getMaxHeightWithArray:array6];
            

            //设置所有系数承载的View的frame
            [allXIshuView setFrame:CGRectMake(0, lb_beizu.frame.origin.y+lb_beizu.frame.size.height+10, SCREEN_WIDTH, lb_zhenmodata.frame.origin.y+maxHeight6+10)];
            //设置scrollView的滚动范围
            int scrollHeight = allXIshuView.frame.origin.y+allXIshuView.frame.size.height+10;
            if (isShowedExplain) {
                scrollHeight = scrollHeight+60;
            }
            [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, scrollHeight)];
            
        }
        
    }];
    
    
    
}


- (void)setColorWithLable:(UILabel*)label AndString:(NSString*)string AndColorString:(NSString*)colorString AndHeight:(int)height
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSArray *array=[colorString componentsSeparatedByString:@"|"];
    for (int i = 0; i < array.count; i++) {
        NSArray *arrayData=[[array objectAtIndex:i] componentsSeparatedByString:@","];
        int a = [[arrayData objectAtIndex:0] intValue];
        int b = [[arrayData objectAtIndex:1] intValue];
        int c = [[arrayData objectAtIndex:2] intValue];
        switch (c) {
                // 白色（无属性）
            case 0:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(a,b)];
                break;
                // 蓝色 （带属性）
            case 1:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:0.41 blue:0.85 alpha:1] range:NSMakeRange(a,b)];
                break;
                // 红色 （自带炎属性）
            case 2:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(a,b)];
                break;
                // 青色 （自带冰属性）
            case 3:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(a,b)];
                break;
                // 紫色 （自带斩属性）
            case 4:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:1] range:NSMakeRange(a,b)];
                break;
                // 绿色 （自带风属性）
            case 5:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(a,b)];
                break;
                // 黄色 （自带雷属性）
            case 6:
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(a,b)];
                break;
                
            default:
                break;
        }
    }
    
    label.attributedText = str;
    
    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, height+5)];
    
    
    
    
    
}

- (void)refreshButtonPressed
{
    [self doHttp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"武器威力系数页面"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"武器威力系数页面"];
}


@end
