//
//  PlayerNearbyVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/6/2.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "PlayerNearbyVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import <BmobSDK/Bmob.h>
#import "PlayerNearbyTVC.h"
#import "User.h"
#import "Utils.h"
#import <BaiduMapAPI/BMapKit.h>
#import "CompletePersonInfoVC.h"
#import "WLXAppDelegate.h"


@interface PlayerNearbyVC ()
{
    CGRect frame_first;
    
    UIImageView *fullImageView;
    UIScrollView *sv;
}

@end

@implementation PlayerNearbyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"附近的玩家";
    self.navigationProtal = self;
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-20-20)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    
    
    players = [[NSMutableArray alloc] init];
    
    [self doHttp];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    
    User *currentUser = (User *)[BmobUser getCurrentObject];
    BmobQuery *bquery = [BmobUser query];
    [bquery whereKey:@"lastGeoPoint" nearGeoPoint:[currentUser objectForKey:@"lastGeoPoint"] withinKilometers:10000];
    [bquery whereKey:@"username" notEqualTo:[currentUser objectForKey:@"username"]];
    [bquery setLimit:10000];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [activityIndicator stopAnimating];
        activityIndicator.hidden = YES;
        if (error) {
            
        }
        else {
            [players removeAllObjects];
            
            for (BmobObject *obj in array) {
                NSString *faceName = [obj objectForKey:@"faceName"];
                NSString *faceUrl = [obj objectForKey:@"faceUrl"];
                NSString *qq = [obj objectForKey:@"qq"];
                NSString *city = [obj objectForKey:@"city"];
                NSString *tiebaName = [obj objectForKey:@"tiebaName"];
                NSString *nickName = [obj objectForKey:@"nickName"];
                NSString *gameName = [obj objectForKey:@"gameName"];
                NSString *lastAddress = [obj objectForKey:@"lastAddress"];
                NSString *registOS = [obj objectForKey:@"registOS"];
                BmobGeoPoint *lastGeoPoint = (BmobGeoPoint *)[obj objectForKey:@"lastGeoPoint"];
                
                float addressHeight = [Utils getTextHeight:lastAddress linebreakMode:NSLineBreakByCharWrapping font:[UIFont systemFontOfSize:12] width:200];
                
                User *player = [[User alloc] initWithfaceName:faceName AndFaceUrl:faceUrl AndQq:qq AndCity:city  AndNickName:nickName AndTiebaName:tiebaName AndGameName:gameName AndLastGeoPoint:lastGeoPoint AndLastAddress:lastAddress AndRegistOS:registOS AndAddressHeight:addressHeight];
                [players addObject:player];
            }
            //刷新表格控件
            [tableview reloadData];
        }
    }];
    
}

//返回多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [players count];
}


//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *player = [players objectAtIndex:[indexPath row]];
    float height = 50 + player.addressHeight + 10;
    if (height >= 110) {
        return height;
    }
    else {
        return 110;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * cellId = @"cellId";
    PlayerNearbyTVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"PlayerNearbyTVC" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[PlayerNearbyTVC class]]) {
                cell = (PlayerNearbyTVC *)o;
                
                iv_face = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"avator_default.png"]];
                iv_face.frame = CGRectMake(20.0f, 20.0f, 50.0f, 50.0f);
                [cell.contentView addSubview:iv_face];
                
                lb_address = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 20)];
                lb_address.numberOfLines = 0;
                lb_address.lineBreakMode = NSLineBreakByCharWrapping;
                lb_address.textColor = [UIColor whiteColor];
                lb_address.font = [UIFont systemFontOfSize:12.0];
                [cell.contentView addSubview:lb_address];
                
                break;
            }
        }
    }
    
    
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    User *user = [players objectAtIndex:[indexPath row]];
    
    cell.lb_nickName.text = user.nickName;
    lb_address.text = user.lastAddress;
    
    CGRect frame = lb_address.frame;
    frame.size.height = user.addressHeight+10;
    lb_address.frame = frame;
    
    
    //头像
    NSString *url=[NSString stringWithFormat:@"%@%@",user.faceUrl,@"?t=1&a=f42ab7d36b6c0ec9ee85440e61c071ec"];
    //设置截图
    [cell setFlickrPhoto:url AndImageView:iv_face];
    //给头像添加点击监听
    iv_face.userInteractionEnabled=YES;
    iv_face.tag=9999;
    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTap:)];
    [iv_face addGestureRecognizer:singleTap1];
    
    
    User *currentUser = (User *)[BmobUser getCurrentObject];
    BmobGeoPoint *currentGeo = [currentUser objectForKey:@"lastGeoPoint"];
    BmobGeoPoint *userGeo = user.lastGeoPoint;
    //设置距离
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(currentGeo.latitude,currentGeo.longitude));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(userGeo.latitude,userGeo.longitude));
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    cell.lb_km.text = [NSString stringWithFormat:@"%.1f%@",(float)(distance/1000),@"km"];
    
    
    return cell;
}





- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"附近的玩家"];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"附近的玩家"];
}

//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    completePersonInfoVC = [[CompletePersonInfoVC alloc] init];
    completePersonInfoVC.hasNavBack = YES;
    completePersonInfoVC.type = 2;
    completePersonInfoVC.user = [players objectAtIndex:[indexPath row]];
    
    
    
    [self.navigationController pushViewController:completePersonInfoVC animated:YES];
    
    
    //取消单元格被选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(void)leftAction
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

-(void)rightAction
{
    [self doHttp];
}


-(void)actionTap:(UITapGestureRecognizer *)sender{
    
    CGPoint location = [sender locationInView:tableview];
    NSIndexPath *indexPath  = [tableview indexPathForRowAtPoint:location];
    UITableViewCell *cell = (UITableViewCell *)[tableview  cellForRowAtIndexPath:indexPath];
    UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:9999];
    
    
    if (imageView.image == nil) {
        return;
    }
    
    frame_first=CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y+imageView.frame.origin.y-tableview.contentOffset.y, imageView.frame.size.width, imageView.frame.size.height);
    
    
    sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    sv.delegate = self;
    sv.maximumZoomScale = 1.5;
    sv.minimumZoomScale = 1.0;
    sv.bounces = NO;
    sv.zoomScale = 1.0;
    sv.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
    sv.backgroundColor = [UIColor clearColor];
    
    fullImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    fullImageView.backgroundColor=[UIColor blackColor];
    fullImageView.userInteractionEnabled=YES;
    [fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap2:)]];
    fullImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    if (![fullImageView superview]) {
        fullImageView.image=imageView.image;
        
        [self.view.window addSubview:sv];
        [sv addSubview:fullImageView];
        
        fullImageView.frame=frame_first;
        [UIView animateWithDuration:0.5 animations:^{
            fullImageView.frame=CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden=YES;
        }];
    }
}

-(void)actionTap2:(UITapGestureRecognizer *)sender{
    [UIView animateWithDuration:0.5 animations:^{
        fullImageView.frame=frame_first;
    } completion:^(BOOL finished) {
        [fullImageView removeFromSuperview];
        [sv removeFromSuperview];
    }];
    [UIApplication sharedApplication].statusBarHidden=NO;
}










@end
