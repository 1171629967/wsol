//
//  WeaponVC.h
//  WSOL
//
//  Created by 王 李鑫 on 14-8-30.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeaponVC : UITableViewController <UISearchBarDelegate,UISearchDisplayDelegate>
{
    int weaponsTypeCount;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
}

@property (strong, nonatomic) NSArray *weaponNamesR1;
@property (strong, nonatomic) NSArray *weaponDataR1G;
@property (strong, nonatomic) NSArray *weaponDataR1P;
@property (strong, nonatomic) NSArray *weaponDataR1F;
@property (strong, nonatomic) NSArray *weaponDataR1T;
@property (strong, nonatomic) NSArray *weaponDataR1W;

@property (strong, nonatomic) NSArray *suggesWeaponNamesR1;
@property (strong, nonatomic) NSMutableArray *suggesWeaponDataR1G;
@property (strong, nonatomic) NSMutableArray *suggesWeaponDataR1P;
@property (strong, nonatomic) NSMutableArray *suggesWeaponDataR1F;
@property (strong, nonatomic) NSMutableArray *suggesWeaponDataR1T;
@property (strong, nonatomic) NSMutableArray *suggesWeaponDataR1W;




@end
