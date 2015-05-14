//
//  JinpaiWeaponTVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/12.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "JinpaiWeaponTVC.h"

@implementation JinpaiWeaponTVC

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEntity:(JinpaiWeapon *)entity ByMode:(int)mode
{
  
    
    self.weaponName.text = entity.name;
    if (mode == 0) {
        self.weaponDataR1.text = [NSString stringWithFormat:@"R1    %d  %d  %d  %d  %d",entity.g,entity.p,entity.f,entity.t,entity.w];
        self.weaponDataR2.text = [NSString stringWithFormat:@"R2    %d  %d  %d  %d  %d",entity.g+3,entity.p+3,entity.f+3,entity.t+3,entity.w+3];
        self.weaponDataR3.text = [NSString stringWithFormat:@"R3    %d  %d  %d  %d  %d",entity.g+6,entity.p+6,entity.f+6,entity.t+6,entity.w+6];
        self.weaponDataR4.text = [NSString stringWithFormat:@"R4    %d  %d  %d  %d  %d",entity.g+9,entity.p+9,entity.f+9,entity.t+9,entity.w+9];
        self.weaponDataR5.text = [NSString stringWithFormat:@"R5    %d  %d  %d  %d  %d",entity.g+12,entity.p+12,entity.f+12,entity.t+12,entity.w+12];
        self.weaponDataR6.text = [NSString stringWithFormat:@"R6    %d  %d  %d  %d  %d",entity.g+15,entity.p+15,entity.f+15,entity.t+15,entity.w+15];
        self.weaponDataR7.text = [NSString stringWithFormat:@"R7    %d  %d  %d  %d  %d",entity.g+18,entity.p+18,entity.f+18,entity.t+18,entity.w+18];
    }
    else {
        self.weaponDataR1.text = [NSString stringWithFormat:@"R1    %d  %d  %d  %d  %d",entity.g%10,entity.p%10,entity.f%10,entity.t%10,entity.w%10];
        self.weaponDataR2.text = [NSString stringWithFormat:@"R2    %d  %d  %d  %d  %d",(entity.g+3)%10,(entity.p+3)%10,(entity.f+3)%10,(entity.t+3)%10,(entity.w+3)%10];
        self.weaponDataR3.text = [NSString stringWithFormat:@"R3    %d  %d  %d  %d  %d",(entity.g+6)%10,(entity.p+6)%10,(entity.f+6)%10,(entity.t+6)%10,(entity.w+6)%10];
        self.weaponDataR4.text = [NSString stringWithFormat:@"R4    %d  %d  %d  %d  %d",(entity.g+9)%10,(entity.p+9)%10,(entity.f+9)%10,(entity.t+9)%10,(entity.w+9)%10];
        self.weaponDataR5.text = [NSString stringWithFormat:@"R5    %d  %d  %d  %d  %d",(entity.g+12)%10,(entity.p+12)%10,(entity.f+12)%10,(entity.t+12)%10,(entity.w+12)%10];
        self.weaponDataR6.text = [NSString stringWithFormat:@"R6    %d  %d  %d  %d  %d",(entity.g+15)%10,(entity.p+15)%10,(entity.f+15)%10,(entity.t+15)%10,(entity.w+15)%10];
        self.weaponDataR7.text = [NSString stringWithFormat:@"R7    %d  %d  %d  %d  %d",(entity.g+18)%10,(entity.p+18)%10,(entity.f+18)%10,(entity.t+18)%10,(entity.w+18)%10];
    }
    
    
    
    self.weaponDataBase.text = [NSString stringWithFormat:@"基础    %d  %d  %d  %d  %d",entity.g_base,entity.p_base,entity.f_base,entity.t_base,entity.w_base];
    self.weaponDataMoveAndJump.text = [NSString stringWithFormat:@"移动    %d   跳跃    %d",entity.move,entity.jump];
    
    entity.cellHeight = self.weaponDataMoveAndJump.frame.origin.y +self.weaponDataMoveAndJump.frame.size.height +10;
    
}

@end
