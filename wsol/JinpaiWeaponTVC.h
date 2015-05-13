//
//  JinpaiWeaponTVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/5/12.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JinpaiWeapon.h"

@interface JinpaiWeaponTVC : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *weaponName;
@property (weak, nonatomic) IBOutlet UILabel *weaponDataR1;
@property (weak, nonatomic) IBOutlet UILabel *weaponDataR2;
@property (weak, nonatomic) IBOutlet UILabel *weaponDataR3;
@property (weak, nonatomic) IBOutlet UILabel *weaponDataR4;
@property (weak, nonatomic) IBOutlet UILabel *weaponDataR5;
@property (weak, nonatomic) IBOutlet UILabel *weaponDataR6;
@property (weak, nonatomic) IBOutlet UILabel *weaponDataR7;
@property (weak, nonatomic) IBOutlet UILabel *weaponDataBase;
@property (weak, nonatomic) IBOutlet UILabel *weaponDataMoveAndJump;


@property (nonatomic) int cellHeight;

- (void)setEntity:(JinpaiWeapon *)entity;

@end
