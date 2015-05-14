//
//  PianzimingdanVC.m
//  wsol
//
//  Created by 王 李鑫 on 14/12/10.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "PianzimingdanVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import "PMHelper.h"
#import "Pianzi.h"
#import "Utils.h"
#import "PianziTVC.h"
#import "WLXAppDelegate.h"
#import <BmobSDK/Bmob.h>




@interface PianzimingdanVC ()
{
    CGRect frame_first;
    
    UIImageView *fullImageView;
    UIScrollView *sv;
}

@end

@implementation PianzimingdanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"骗子名单";
    self.navigationProtal = self;
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    

    
    //初始化搜索控件
    searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [searchBar sizeToFit];
    tableview.tableHeaderView = searchBar;
    
    
    
    //初始化searchDisplayController
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    [searchDisplayController setSearchResultsDataSource:self];
    [searchDisplayController setSearchResultsDelegate:self];
    searchDisplayController.searchResultsTableView.backgroundColor = [UIColor clearColor];
    

   
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);//只能设置中心，不能设置大小
    activityIndicator.hidden = YES;
    [self.view addSubview:activityIndicator];
    
    
       
    self.pianzis = [[NSMutableArray alloc] init];
    self.suggesPianzis = [[NSMutableArray alloc] init];
    self.pianziNames = [[NSMutableArray alloc] init];
    self.suggesPianziNames = [[NSMutableArray alloc] init];
    [self doHttp];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        return [self.suggesPianzis count];
    }
    else
    {
        return [self.pianzis count];
    }
}

//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Pianzi *pianzi;
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        pianzi = [self.suggesPianzis objectAtIndex:[indexPath row]];
    }
    else
    {
        pianzi = [self.pianzis objectAtIndex:[indexPath row]];
    }
    return pianzi.cellHeight;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    PianziTVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"PianziTVC" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[PianziTVC class]]) {
                cell = (PianziTVC *)o;
                
                imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"120.png"]];
                imageView.frame = CGRectMake(10.0f, 10.0f, 80.0f, 80.0f);
                [cell.contentView addSubview:imageView];
                
                break;
            }
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    Pianzi *pianzi;
    
    //区分是否是搜素结果列表
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        pianzi = [self.suggesPianzis objectAtIndex:[indexPath row]];
    }
    else
    {
        pianzi = [self.pianzis objectAtIndex:[indexPath row]];
    }
    
    
    
    //设置截图
    [cell setFlickrPhoto:pianzi.jietu AndImageView:imageView];
    
    //给头像添加点击监听
    imageView.userInteractionEnabled=YES;
    imageView.tag=9999;
    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTap:)];
    [imageView addGestureRecognizer:singleTap1];
    //给证据链接添加点击监听
    cell.zhengju.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openUrl:)];
    [cell.zhengju addGestureRecognizer:singleTap2];
    
    
    //名字
    cell.name.text = pianzi.name;
    //证据
    if ([Utils isBlankString:pianzi.zhengjuurl]) {
        cell.zhengjuText.hidden = YES;
        cell.zhengju.hidden = YES;
    }
    else
    {
        cell.zhengjuText.hidden = NO;
        cell.zhengju.hidden = NO;
        cell.zhengju.text = pianzi.zhengjuurl;
        
    }
    //备注
    if ([Utils isBlankString:pianzi.beizhu]) {
        cell.beizhuText.hidden = YES;
        cell.beizhu.hidden = YES;
    }
    else
    {
        cell.beizhuText.hidden = NO;
        cell.beizhu.hidden = NO;
        cell.beizhu.text = pianzi.beizhu;
        
    }
    
    
    cell.zhengju.userInteractionEnabled=YES;
    cell.zhengju.frame = CGRectMake(145, 54, 150, pianzi.zhengjuHeight);
    cell.beizhu.frame = CGRectMake(145, 54+pianzi.zhengjuHeight+10, 150, pianzi.beizhuHeight);
    cell.beizhuText.frame = CGRectMake(105, cell.beizhu.frame.origin.y+5, 40, 20);
    
  
    return cell;
}






#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    // Return YES to cause the search result table view to be reloaded.
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar                                                      selectedScopeButtonIndex]]];
    currentTableViewType = 1;
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    // Return YES to cause the search result table view to be reloaded.
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]  scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    currentTableViewType = 1;
    return YES;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
    /*
     Bob: Because the searchResultsTableView will be released and allocated automatically, so each time we start to begin search, we set its delegate here.
     */
    [searchDisplayController.searchResultsTableView setDelegate:self];
    
}

//搜索框cancel的时候回调
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    [searchBar resignFirstResponder];
    currentTableViewType = 0;
    tableview.hidden = NO;
}


/** 谓词匹配搜索内容 */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    [self.suggesPianziNames removeAllObjects];
    [self.suggesPianzis removeAllObjects];
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",                                     searchText];
    NSArray *array = [self.pianziNames filteredArrayUsingPredicate:resultPredicate];
    [self.suggesPianziNames addObjectsFromArray:array];
    NSInteger count = [self.suggesPianziNames count];
    [self.suggesPianzis removeAllObjects];
    
    for (int i = 0; i<count; i++) {
        NSString *name = [self.suggesPianziNames objectAtIndex:i];
        NSInteger index = [self.pianziNames indexOfObject:name];
        
        Pianzi *pianzi = [self.pianzis objectAtIndex:index];
        [self.suggesPianzis addObject:pianzi];
    }
    tableview.hidden = YES;
}





- (void)doHttp{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Pianzi"];
    bquery.limit = 1000;
    [bquery orderByAscending:@"pianziId"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            [self.pianzis removeAllObjects];
            [self.suggesPianzis removeAllObjects];
            [self.pianziNames removeAllObjects];
            [self.suggesPianziNames removeAllObjects];
            
            
            for (BmobObject *obj in array) {
                NSString *name = [obj objectForKey:@"name"];
                NSString *jietu = [obj objectForKey:@"jietu"];
                NSString *zhengjuurl = [obj objectForKey:@"zhengjuurl"];
                NSString *beizhu = [obj objectForKey:@"beizhu"];
                
                [self.pianziNames addObject:name];
                Pianzi *pianzi = [[Pianzi alloc] initWithName:name Jietu:jietu Zhengjuurl:zhengjuurl Beizhu:beizhu];
                [self.pianzis addObject:pianzi];
            }
            //刷新表格控件
            [tableview reloadData];
            
            
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
    [MobClick beginLogPageView:@"骗子名单页面"];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"骗子名单页面"];
}



- (void)openUrl:(UITapGestureRecognizer *)gestureRecognizer
{
    UITextView *tv = (UITextView *)[gestureRecognizer view];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tv.text]];
}




-(void)actionTap:(UITapGestureRecognizer *)sender{
    UITableView *currentTableView;
    if (currentTableViewType == 0) {
        currentTableView = tableview;
    }
    else if (currentTableViewType == 1)
    {
        currentTableView = searchDisplayController.searchResultsTableView;
    }
    
    CGPoint location = [sender locationInView:currentTableView];
    NSIndexPath *indexPath  = [currentTableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = (UITableViewCell *)[currentTableView  cellForRowAtIndexPath:indexPath];
    UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:9999];
    
    
    if (imageView.image == nil) {
        return;
    }
    
    frame_first=CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y+imageView.frame.origin.y-currentTableView.contentOffset.y, imageView.frame.size.width, imageView.frame.size.height);
    

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

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return fullImageView;
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
