//
//  MenuTableVC.m
//  wsol
//
//  Created by 王 李鑫 on 14-9-9.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "MenuTableVC.h"
#import "TWTSideMenuViewController.h"
#import "WeaponVC.h"
#import "LoadhtmlVC.h"
#import "LoadtxtVC.h"
#import "WuxuVC.h"
#import "MeizhouhuodongVC.h"

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
    
    if ([currentMenuString isEqualToString:menuString]) {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
    else
    {
        currentMenuString = menuString;
        UINavigationController *controller;
        
        if ([currentMenuString isEqualToString:@"金牌武器上升值"]) {
          controller = [[UINavigationController alloc] initWithRootViewController:[[WeaponVC alloc] init]];            
        }
        else if([currentMenuString isEqualToString:@"任务报酬一览"]){
            LoadhtmlVC *htmlVC = [[LoadhtmlVC alloc] init];
            htmlVC.htmlName = @"renwubaochou";
            htmlVC.titleName = @"任务报酬一览";
            controller = [[UINavigationController alloc] initWithRootViewController:htmlVC];
        }

        
        else if([currentMenuString isEqualToString:@"内政等级表"]){
            LoadhtmlVC *htmlVC = [[LoadhtmlVC alloc] init];
            htmlVC.htmlName = @"renwudengji";
            htmlVC.titleName = @"内政等级表";
            controller = [[UINavigationController alloc] initWithRootViewController:htmlVC];
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
        
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
        
    }
    
    
}


@end
