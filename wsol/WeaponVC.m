//
//  WeaponVC.m
//  WSOL
//
//  Created by 王 李鑫 on 14-8-30.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "WeaponVC.h"
#import "WeaponTVC.h"

@interface WeaponVC ()

@end

@implementation WeaponVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"金牌武器上升值";
    
    
    label.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView = label;
    
    
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weapon_appreciate_listview_back.png"]];
    
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
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.weaponNamesR1 count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

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
    cell.weaponName.text = [self.weaponNamesR1 objectAtIndex:[indexPath row]];
    
    
    int g = [[NSString stringWithFormat:@"%@",[self.weaponDataR1G objectAtIndex:[indexPath row]]] intValue];
    int p = [[NSString stringWithFormat:@"%@",[self.weaponDataR1P objectAtIndex:[indexPath row]]] intValue];
    int t = [[NSString stringWithFormat:@"%@",[self.weaponDataR1F objectAtIndex:[indexPath row]]] intValue];
    int f = [[NSString stringWithFormat:@"%@",[self.weaponDataR1T objectAtIndex:[indexPath row]]] intValue];
    int w = [[NSString stringWithFormat:@"%@",[self.weaponDataR1W objectAtIndex:[indexPath row]]] intValue];
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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
