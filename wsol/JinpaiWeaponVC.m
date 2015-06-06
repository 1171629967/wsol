//
//  JinpaiWeaponVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/11.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "JinpaiWeaponVC.h"
#import "JinpaiWeaponTVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"
#import "WLXAppDelegate.h"
#import <BmobSDK/Bmob.h>
#import "JinpaiWeapon.h"
#import "UITableView+FDTemplateLayoutCell.h"


@interface JinpaiWeaponVC ()

@end


@implementation JinpaiWeaponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    currentMode = (int)[userDefaults integerForKey:UserDefaultsKey_jinpaiWeaponMode];
    
   
    
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    //[[super rightItem] setTitle:@"刷新"];
    [super label].text = @"金牌武器上升值";
    self.navigationProtal = self;
    
    
    
    //给nagigationBar的右边添加两个按钮
    NSMutableArray *mycustomButtons = [[NSMutableArray alloc] init];
    UIBarButtonItem *myButton1 = [[UIBarButtonItem alloc]
                                   initWithTitle:@"刷新"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(doHttp)];
    myButton1.width = 30;
    [myButton1 setTintColor:[UIColor whiteColor]];
    [mycustomButtons addObject: myButton1];
    UIBarButtonItem *myButton2 = [[UIBarButtonItem alloc]
                                   initWithTitle:@"变化"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(changeMode)];
    myButton2.width = 30;
    [myButton2 setTintColor:[UIColor whiteColor]];
    [mycustomButtons addObject: myButton2];
    
    mycustomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(220.0f, 0.0f,80.0f, 44.0f)];
    mycustomToolBar.barStyle = UIBarStyleDefault;  
    [mycustomToolBar setItems:mycustomButtons animated:YES];  
    [mycustomToolBar sizeToFit];
    mycustomToolBar.backgroundColor = [UIColor clearColor];
    for (UIView *view in [mycustomToolBar subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    [self.navigationController.navigationBar addSubview:mycustomToolBar];
    
    
    
    
    
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
    tableview.tableHeaderView.backgroundColor = [UIColor clearColor];
   
    
    
    //初始化searchDisplayController
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    [searchDisplayController setSearchResultsDataSource:self];
    [searchDisplayController setSearchResultsDelegate:self];
    searchDisplayController.searchResultsTableView.backgroundColor = [UIColor clearColor];
    searchDisplayController.searchBar.backgroundColor = [UIColor clearColor];
    
    
    
    
    
   
    
    
    weapons = [[NSMutableArray alloc] init];
    suggestWeapons = [[NSMutableArray alloc] init];
    
    
    [self doHttp];
 
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (mycustomToolBar) {
         mycustomToolBar.hidden = NO;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) refreshView:(UIRefreshControl *)refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"更新数据中..."];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"上次更新日期 %@",
                             [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [self doHttp];
}







-(void)leftAction
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

-(void)rightAction
{
    //[self doHttp];
}

//新旧两种模式的变化
-(void)changeMode
{
    if (currentMode == 0) {
        currentMode = 1;
    }
    else
    {
        currentMode = 0;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:currentMode forKey:UserDefaultsKey_jinpaiWeaponMode];
    [tableview reloadData];
}


#pragma mark - Table view delegate
//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    wlxsVC = [[WeilixishuVC alloc] init];
    wlxsVC.hasNavBack = YES;
    
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        wlxsVC.weaponName = [[suggestWeapons objectAtIndex:[indexPath row]] name];
    }
    else
    {
        wlxsVC.weaponName = [[weapons objectAtIndex:[indexPath row]] name];
    }
    
    [self.navigationController pushViewController:wlxsVC animated:YES];
    
    mycustomToolBar.hidden = YES;
    //取消单元格被选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//返回列表需要展示多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        return [suggestWeapons count];
    }
    else
    {
        return [weapons count];
    }
}

//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return [weapons[indexPath.row] cellHeight];
    return 220;
}

//单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString * cellId = @"JinpaiWeaponTVC";
        JinpaiWeaponTVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"JinpaiWeaponTVC" owner:self options:nil];
            for (NSObject *o in objects) {
                if ([o isKindOfClass:[JinpaiWeaponTVC class]]) {
                    cell = (JinpaiWeaponTVC *)o;
                    break;
                }
            }
        }
    
    
  
    
    cell.backgroundColor = [UIColor clearColor];
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        [cell setEntity:suggestWeapons[indexPath.row] ByMode:currentMode];
    }
    else
    {
        [cell setEntity:weapons[indexPath.row] ByMode:currentMode];
    }
    return cell;
}











#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    // Return YES to cause the search result table view to be reloaded.
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar                                                      selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    // Return YES to cause the search result table view to be reloaded.
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]                                 scope:[[self.searchDisplayController.searchBar scopeButtonTitles]                                       objectAtIndex:searchOption]];
    return YES;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
    /*
     Bob: Because the searchResultsTableView will be released and allocated automatically, so each time we start to begin search, we set its delegate here.
     */
    [searchDisplayController.searchResultsTableView setDelegate:self];
    
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    [searchBar resignFirstResponder];
    tableview.hidden = NO;
}


/** 谓词匹配搜索内容 */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    

    
    [suggestWeapons removeAllObjects];
    for (JinpaiWeapon *jinpaiWeapon in weapons) {
        NSRange foundObj=[[jinpaiWeapon name] rangeOfString:[searchText lowercaseString] options:NSCaseInsensitiveSearch];
        NSRange foundObj_pinyin=[[jinpaiWeapon pinyin] rangeOfString:[searchText lowercaseString] options:NSCaseInsensitiveSearch];
        if (foundObj.length>0 || foundObj_pinyin.length >0) {
            [suggestWeapons addObject:jinpaiWeapon];
        }
    }
    
    
    
    tableview.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"金牌武器上升值页面"];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"金牌武器上升值页面"];
}

- (void)doHttp
{
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"WeaponJinpai"];
    bquery.limit = 1000;
    [bquery orderByAscending:@"weaponId"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [activityIndicator stopAnimating];
        activityIndicator.hidden = YES;
        if (error) {
            
        }
        else {
           
            [weapons removeAllObjects];
     
            for (BmobObject *obj in array) {
                JinpaiWeapon *weapon = [[JinpaiWeapon alloc] initWithBmobObject:obj];
                [weapons addObject:weapon];
                
            }
            
            
            //刷新表格控件
            [tableview reloadData];     
        }
        
    }];
}

@end
