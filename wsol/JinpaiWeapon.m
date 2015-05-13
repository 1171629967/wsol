//
//  JinpaiWeapon.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/12.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "JinpaiWeapon.h"


@implementation JinpaiWeapon

- (id)initWithBmobObject:(BmobObject *)bmobObject
{
    self = [super init];
    if (self) {
        self.pinyin = [bmobObject objectForKey:@"pinyin"];
        self.name = [bmobObject objectForKey:@"name"];
        self.g = [[bmobObject objectForKey:@"g"] intValue];
        self.p = [[bmobObject objectForKey:@"p"] intValue];
        self.f = [[bmobObject objectForKey:@"f"] intValue];
        self.t = [[bmobObject objectForKey:@"t"] intValue];
        self.w = [[bmobObject objectForKey:@"w"] intValue];
        self.g_base = [[bmobObject objectForKey:@"g_base"] intValue];
        self.p_base = [[bmobObject objectForKey:@"p_base"] intValue];
        self.f_base = [[bmobObject objectForKey:@"f_base"] intValue];
        self.t_base = [[bmobObject objectForKey:@"t_base"] intValue];
        self.w_base = [[bmobObject objectForKey:@"w_base"] intValue];
        self.move = [[bmobObject objectForKey:@"move"] intValue];
        self.jump = [[bmobObject objectForKey:@"jump"] intValue];
    }
    return self;
}

@end
