//
//  JinpaiWeapon.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/12.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "JinpaiWeapon.h"


@implementation JinpaiWeapon


- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.pinyin = [coder decodeObjectForKey:@"pinyin"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.g = [[coder decodeObjectForKey:@"g"] intValue];
        self.p = [[coder decodeObjectForKey:@"p"] intValue];
        self.f = [[coder decodeObjectForKey:@"f"] intValue];
        self.t = [[coder decodeObjectForKey:@"t"] intValue];
        self.w = [[coder decodeObjectForKey:@"w"] intValue];
        self.g_base = [[coder decodeObjectForKey:@"g_base"] intValue];
        self.p_base = [[coder decodeObjectForKey:@"p_base"] intValue];
        self.f_base = [[coder decodeObjectForKey:@"f_base"] intValue];
        self.t_base = [[coder decodeObjectForKey:@"t_base"] intValue];
        self.w_base = [[coder decodeObjectForKey:@"w_base"] intValue];
        self.move = [[coder decodeObjectForKey:@"move"] intValue];
        self.jump = [[coder decodeObjectForKey:@"jump"] intValue];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.pinyin forKey:@"pinyin"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:[NSNumber numberWithInt:self.g] forKey:@"g"];
    [coder encodeObject:[NSNumber numberWithInt:self.p] forKey:@"p"];
    [coder encodeObject:[NSNumber numberWithInt:self.f] forKey:@"f"];
    [coder encodeObject:[NSNumber numberWithInt:self.t] forKey:@"t"];
    [coder encodeObject:[NSNumber numberWithInt:self.w] forKey:@"w"];
    [coder encodeObject:[NSNumber numberWithInt:self.g_base] forKey:@"g_base"];
    [coder encodeObject:[NSNumber numberWithInt:self.p_base] forKey:@"p_base"];
    [coder encodeObject:[NSNumber numberWithInt:self.f_base] forKey:@"f_base"];
    [coder encodeObject:[NSNumber numberWithInt:self.t_base] forKey:@"t_base"];
    [coder encodeObject:[NSNumber numberWithInt:self.w_base] forKey:@"w_base"];
    [coder encodeObject:[NSNumber numberWithInt:self.move] forKey:@"move"];
    [coder encodeObject:[NSNumber numberWithInt:self.jump] forKey:@"jump"];
}



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
