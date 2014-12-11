//
//  WeaponVC.m
//  WSOL
//
//  Created by 王 李鑫 on 14-8-30.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "WeaponVC.h"
#import "WeaponTVC.h"
#import "MobClick.h"
#import "TWTSideMenuViewController.h"

@interface WeaponVC ()

@end

@implementation WeaponVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    openItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = openItem;
    
    //初始化搜索控件
    searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    
    
    
    //初始化searchDisplayController
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    [searchDisplayController setSearchResultsDataSource:self];
    [searchDisplayController setSearchResultsDelegate:self];
    
    //改变navigationBar标题
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"金牌武器上升值";
    label.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView = label;
    
    

    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_background.png"]];
    searchDisplayController.searchResultsTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_background.png"]];
    
    
    //获取R1武器名称，金牌上升数值，存放到数组中
    NSString *name = weaponNameR1;
    NSString *g = weaponDateR1G;
    NSString *p = weaponDateR1P;
    NSString *f = weaponDateR1F;
    NSString *t = weaponDateR1T;
    NSString *w = weaponDateR1W;
    self.weaponNamesR1 = [name componentsSeparatedByString:@","];
    self.weaponDataR1G = [g componentsSeparatedByString:@","];
    self.weaponDataR1P = [p componentsSeparatedByString:@","];
    self.weaponDataR1F = [f componentsSeparatedByString:@","];
    self.weaponDataR1T = [t componentsSeparatedByString:@","];
    self.weaponDataR1W = [w componentsSeparatedByString:@","];
    
    //self.suggesWeaponNamesR1 = [name componentsSeparatedByString:@","];
    self.suggesWeaponDataR1G = [[NSMutableArray alloc] init];
    self.suggesWeaponDataR1P = [[NSMutableArray alloc] init];
    self.suggesWeaponDataR1F = [[NSMutableArray alloc] init];
    self.suggesWeaponDataR1T = [[NSMutableArray alloc] init];
    self.suggesWeaponDataR1W = [[NSMutableArray alloc] init];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)openButtonPressed
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}


#pragma mark - Table view delegate
//点击列表单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}

//返回列表需要展示多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        return [self.suggesWeaponNamesR1 count];
    }
    else
    {
        return [self.weaponNamesR1 count];
    }
}

//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    WeaponTVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"WeaponTVC" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[WeaponTVC class]]) {
                cell = (WeaponTVC *)o;
                break;
            }
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    int g;
    int p;
    int t;
    int f;
    int w;
    
    //区分是否是搜素结果列表
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        cell.weaponName.text = [self.suggesWeaponNamesR1 objectAtIndex:[indexPath row]];
        g = [[NSString stringWithFormat:@"%@",[self.suggesWeaponDataR1G objectAtIndex:[indexPath row]]] intValue];
        p = [[NSString stringWithFormat:@"%@",[self.suggesWeaponDataR1P objectAtIndex:[indexPath row]]] intValue];
        t = [[NSString stringWithFormat:@"%@",[self.suggesWeaponDataR1F objectAtIndex:[indexPath row]]] intValue];
        f = [[NSString stringWithFormat:@"%@",[self.suggesWeaponDataR1T objectAtIndex:[indexPath row]]] intValue];
        w = [[NSString stringWithFormat:@"%@",[self.suggesWeaponDataR1W objectAtIndex:[indexPath row]]] intValue];
    }
    else
    {
        cell.weaponName.text = [self.weaponNamesR1 objectAtIndex:[indexPath row]];
        g = [[NSString stringWithFormat:@"%@",[self.weaponDataR1G objectAtIndex:[indexPath row]]] intValue];
        p = [[NSString stringWithFormat:@"%@",[self.weaponDataR1P objectAtIndex:[indexPath row]]] intValue];
        t = [[NSString stringWithFormat:@"%@",[self.weaponDataR1F objectAtIndex:[indexPath row]]] intValue];
        f = [[NSString stringWithFormat:@"%@",[self.weaponDataR1T objectAtIndex:[indexPath row]]] intValue];
        w = [[NSString stringWithFormat:@"%@",[self.weaponDataR1W objectAtIndex:[indexPath row]]] intValue];
    }
    
    
    cell.weaponDataR1.text = [NSString stringWithFormat:@"R1   %d%d%d%d%d",g,p,t,f,w];
    cell.weaponDataR2.text = [NSString stringWithFormat:@"%d%d%d%d%d   R2",(g+3)%10,(p+3)%10,(t+3)%10,(f+3)%10,(w+3)%10];
    cell.weaponDataR3.text = [NSString stringWithFormat:@"R3   %d%d%d%d%d",(g+6)%10,(p+6)%10,(t+6)%10,(f+6)%10,(w+6)%10];
    cell.weaponDataR4.text = [NSString stringWithFormat:@"%d%d%d%d%d   R4",(g+9)%10,(p+9)%10,(t+9)%10,(f+9)%10,(w+9)%10];
    cell.weaponDataR5.text = [NSString stringWithFormat:@"R5   %d%d%d%d%d",(g+12)%10,(p+12)%10,(t+12)%10,(f+12)%10,(w+12)%10];
    cell.weaponDataR6.text = [NSString stringWithFormat:@"%d%d%d%d%d   R6",(g+15)%10,(p+15)%10,(t+15)%10,(f+15)%10,(w+15)%10];
    cell.weaponDataR7.text = [NSString stringWithFormat:@"R7   %d%d%d%d%d",(g+18)%10,(p+18)%10,(t+18)%10,(f+18)%10,(w+18)%10];
    
    return cell;
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
}


/** 谓词匹配搜索内容 */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate *resultPredicate = [NSPredicate                                    predicateWithFormat:@"SELF contains[cd] %@",                                     searchText];
    self.suggesWeaponNamesR1 = [self.weaponNamesR1 filteredArrayUsingPredicate:resultPredicate];
    NSInteger count = [self.suggesWeaponNamesR1 count];
    [self.suggesWeaponDataR1G removeAllObjects];
    [self.suggesWeaponDataR1P removeAllObjects];
    [self.suggesWeaponDataR1F removeAllObjects];
    [self.suggesWeaponDataR1T removeAllObjects];
    [self.suggesWeaponDataR1W removeAllObjects];
    for (int i = 0; i<count; i++) {
        NSString *name = [self.suggesWeaponNamesR1 objectAtIndex:i];
        NSInteger index = [self.weaponNamesR1 indexOfObject:name];
        
        NSString *g = [self.weaponDataR1G objectAtIndex:index];
        NSString *p = [self.weaponDataR1P objectAtIndex:index];
        NSString *f = [self.weaponDataR1F objectAtIndex:index];
        NSString *t = [self.weaponDataR1T objectAtIndex:index];
        NSString *w = [self.weaponDataR1W objectAtIndex:index];
        [self.suggesWeaponDataR1G addObject:g];
        [self.suggesWeaponDataR1P addObject:p];
        [self.suggesWeaponDataR1F addObject:f];
        [self.suggesWeaponDataR1T addObject:t];
        [self.suggesWeaponDataR1W addObject:w];
    }
    
    
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




@end
