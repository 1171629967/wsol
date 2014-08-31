//
//  WeaponVC.h
//  WSOL
//
//  Created by 王 李鑫 on 14-8-30.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeaponVC : UITableViewController
{
    int weaponsTypeCount;
}

@property (strong, nonatomic) NSArray *weaponNamesR1;
@property (strong, nonatomic) NSArray *weaponDataR1G;
@property (strong, nonatomic) NSArray *weaponDataR1P;
@property (strong, nonatomic) NSArray *weaponDataR1F;
@property (strong, nonatomic) NSArray *weaponDataR1T;
@property (strong, nonatomic) NSArray *weaponDataR1W;



@end
