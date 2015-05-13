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
    //设置导航栏
    [[super leftItem] setTitle:@"菜单"];
    [[super rightItem] setTitle:@"刷新"];
    [super label].text = @"金牌武器上升值";
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
    
    
    weapons = [[NSMutableArray alloc] init];
    suggestWeapons = [[NSMutableArray alloc] init];
    self.weaponNamesR1 = [[NSMutableArray alloc] init];
    
    
    
    
    
    
    [self doHttp];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftAction
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

-(void)rightAction
{
    [self doHttp];
}


#pragma mark - Table view delegate
//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    wlxsVC = [[WeilixishuVC alloc] init];
    wlxsVC.hasNavBack = YES;
    
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        wlxsVC.weaponName = [self.suggesWeaponNamesR1 objectAtIndex:[indexPath row]];
    }
    else
    {
        wlxsVC.weaponName = [self.weaponNamesR1 objectAtIndex:[indexPath row]];
    }
    
    [self.navigationController pushViewController:wlxsVC animated:YES];
    
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
    return [weapons[indexPath.row] cellHeight];
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
        [cell setEntity:suggestWeapons[indexPath.row]];
    }
    else
    {
        [cell setEntity:weapons[indexPath.row]];
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
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
    self.suggesWeaponNamesR1 = [self.weaponNamesR1 filteredArrayUsingPredicate:resultPredicate];
    NSInteger count = [self.suggesWeaponNamesR1 count];
    [suggestWeapons removeAllObjects];
    for (int i = 0; i<count; i++) {
        NSString *name = [self.suggesWeaponNamesR1 objectAtIndex:i];
        NSInteger index = [self.weaponNamesR1 indexOfObject:name];
        [suggestWeapons addObject:[weapons objectAtIndex:index]];
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
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"WeaponJinpai"];
    bquery.limit = 1000;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
        }
        else {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
            [weapons removeAllObjects];
            [self.weaponNamesR1 removeAllObjects];
            
            
            for (BmobObject *obj in array) {
                JinpaiWeapon *weapon = [[JinpaiWeapon alloc] initWithBmobObject:obj];
                [weapons addObject:weapon];
                [self.weaponNamesR1 addObject:weapon.name];
            }
            //刷新表格控件
            [tableview reloadData];
            
            
        }
        
    }];
}

@end
