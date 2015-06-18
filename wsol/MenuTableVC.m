//
//  MenuTableVC.m
//  wsol
//
//  Created by 王 李鑫 on 14-9-9.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "MenuTableVC.h"
#import "TWTSideMenuViewController.h"
#import "JinpaiWeaponVC.h"
#import "LoadtxtVC.h"
#import "LoadhtmlVC.h"
#import "WuxuVC.h"
#import "MeizhouhuodongVC.h"
#import "PianzimingdanVC.h"
#import "PMHelper.h"
#import "YijianVC.h"
#import "ShowYijianVC.h"
#import "NeizhengdengjiVC.h"
#import "MusicListVC.h"
#import "TransationVC.h"
#import "User.h"
#import "PlayerNearbyVC.h"
#import "CompletePersonInfoVC.h"

@interface MenuTableVC ()

@end

@implementation MenuTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentMenuString = @"金牌武器上升值";
    
    UIImageView *iv_back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_background"]];
    self.tableView.backgroundView = iv_back;
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSelectionStyleNone];
    
    if (IOS7_OR_LATER) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
        self.tabBarController.tabBar.translucent = NO;
    }
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *typeURL = [bundle URLForResource:@"typePlist" withExtension:@"plist"];
    NSURL *menuURL = [bundle URLForResource:@"menuPlist" withExtension:@"plist"];
    typesArray = [NSArray arrayWithContentsOfURL:typeURL];
    menusArray = [NSArray arrayWithContentsOfURL:menuURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPaomadeng) name:@"loadPaomadeng" object:nil];
    
    [self loadPaomadeng];
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
}





//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    point = [[BmobGeoPoint alloc] initWithLongitude:userLocation.location.coordinate.longitude WithLatitude:userLocation.location.coordinate.latitude];
    
    
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
    

}





//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      NSString *address = result.address;
          User *bUser = (User *)[User getCurrentUser];
          [bUser setObject:point forKey:@"lastGeoPoint"];
          [bUser setObject:address forKey:@"lastAddress"];
          [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
              
          }];
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}



/** 跑马灯公告 */
- (void)loadPaomadeng
{
    
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Information"];
    [bquery whereKey:@"type" equalTo:@"gonggao_ios"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            
        }
        else {
            BmobObject *obj = [array objectAtIndex:0];
            NSString *des = [obj objectForKey:@"des"];
            if (![des isEqualToString:@""]) {
                scrollingTicker = [[DMScrollingTicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-16, SCREEN_WIDTH, 16)];
                scrollingTicker.backgroundColor = [UIColor whiteColor];
                [self.sideMenuViewController.view addSubview:scrollingTicker];
                
                
                NSMutableArray *l = [[NSMutableArray alloc] init];
                LPScrollingTickerLabelItem *label = [[LPScrollingTickerLabelItem alloc] initWithTitle:des description:@""];
                [label layoutSubviews];
                [l addObject:label];
                
                
                [scrollingTicker beginAnimationWithViews:l
                                               direction:LPScrollingDirection_FromRight
                                                   speed:40
                                                   loops:99999
                                            completition:^(NSUInteger loopsDone, BOOL isFinished) {
                                                
                                            }];
            }
            
            
            
        }
        
    }];
    
    
}




-(void)viewWillAppear:(BOOL)animated {
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    _locService.delegate = nil;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [typesArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [menusArray objectAtIndex:section];
    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *array = [menusArray objectAtIndex:section];
    
    static NSString *identifier = @"myIdentifier";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [array objectAtIndex:row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    // Configure the cell...
    
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    //headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor whiteColor];
    //headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:24];
    headerLabel.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    headerLabel.text = [typesArray objectAtIndex:section];
    return headerLabel;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    
    NSUInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSArray *array = [menusArray objectAtIndex:section];
    NSString *menuString = [array objectAtIndex:row];
    
    if ([currentMenuString isEqualToString:menuString] ){
        if ([currentMenuString isEqualToString:@"更换主题"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            int currentTheme = (int)[userDefaults integerForKey:UserDefaultsKey_CurrentAppTheme];
            if (currentTheme == 6) {
                currentTheme = 0;
            }
            else {
                currentTheme ++;
            }
            [userDefaults setInteger:currentTheme forKey:UserDefaultsKey_CurrentAppTheme];
            //发出通知，更换APP主题
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_CHANGE_APP_THEME object:nil];
        }
        else {
             [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
        }
    }
    else
    {
        currentMenuString = menuString;
        UINavigationController *controller;
        
        if ([currentMenuString isEqualToString:@"金牌上升和威力系数"]) {
            controller = [[UINavigationController alloc] initWithRootViewController:[[JinpaiWeaponVC alloc] init]];
        }
//        else if([currentMenuString isEqualToString:@"任务报酬一览"]){
//            LoadhtmlVC *htmlVC = [[LoadhtmlVC alloc] init];
//            htmlVC.htmlName = @"renwubaochou";
//            htmlVC.titleName = @"任务报酬一览";
//            controller = [[UINavigationController alloc] initWithRootViewController:htmlVC];
//        }
        
        else if([currentMenuString isEqualToString:@"个人信息"]){
            CompletePersonInfoVC *cptVC = [[CompletePersonInfoVC alloc] init];
            cptVC.type = 1;
            controller = [[UINavigationController alloc] initWithRootViewController:cptVC];
        }
        else if([currentMenuString isEqualToString:@"内政等级表"]){
            controller = [[UINavigationController alloc] initWithRootViewController:[[NeizhengdengjiVC alloc] init]];
        }
        else if([currentMenuString isEqualToString:@"副将技能和属性"]){
            LoadtxtVC *txtVC = [[LoadtxtVC alloc] init];
            txtVC.txtName = @"fujiang";
            txtVC.titleName = @"副将技能和属性";
            controller = [[UINavigationController alloc] initWithRootViewController:txtVC];
        }
        
        else if([currentMenuString isEqualToString:@"关于APP"]){
            LoadtxtVC *txtVC = [[LoadtxtVC alloc] init];
            txtVC.txtName = @"aboutapp";
            txtVC.titleName = @"关于APP";
            controller = [[UINavigationController alloc] initWithRootViewController:txtVC];
        }
        else if([currentMenuString isEqualToString:@"每周活动"]){
            controller = [[UINavigationController alloc] initWithRootViewController:[[MeizhouhuodongVC alloc] init]];
        }
        else if([currentMenuString isEqualToString:@"骗子名单"]){
            controller = [[UINavigationController alloc] initWithRootViewController:[[PianzimingdanVC alloc] init]];
        }
        else if([currentMenuString isEqualToString:@"意见和建议"]){
            controller = [[UINavigationController alloc] initWithRootViewController:[[YijianVC alloc] init]];
        }
        else if([currentMenuString isEqualToString:@"玩家意见一览"]){
            controller = [[UINavigationController alloc] initWithRootViewController:[[ShowYijianVC alloc] init]];
        }
//        else if([currentMenuString isEqualToString:@"游戏BGM音乐"]){
//            controller = [[UINavigationController alloc] initWithRootViewController:[[MusicListVC alloc] init]];
//        }
        else if([currentMenuString isEqualToString:@"吧主担保交易"]){
            controller = [[UINavigationController alloc] initWithRootViewController:[[TransationVC alloc] init]];
        }
        else if([currentMenuString isEqualToString:@"附近的玩家"]){
            controller = [[UINavigationController alloc] initWithRootViewController:[[PlayerNearbyVC alloc] init]];
        }
        else if([currentMenuString isEqualToString:@"更换主题"]){
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            int currentTheme = (int)[userDefaults integerForKey:UserDefaultsKey_CurrentAppTheme];
            if (currentTheme == 6) {
                currentTheme = 0;
            }
            else {
                currentTheme ++;
            }
            [userDefaults setInteger:currentTheme forKey:UserDefaultsKey_CurrentAppTheme];
            //发出通知，更换APP主题
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_CHANGE_APP_THEME object:nil];
        }
        
        
        if (![currentMenuString isEqualToString:@"更换主题"]) {
            [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
        }
        
        
    }
    
    
}


@end
