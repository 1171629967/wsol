//
//  JinpaiWeapon.h
//  wsol
//
//  Created by 王 李鑫 on 15/5/12.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface JinpaiWeapon : NSObject <NSCoding>

@property (copy, nonatomic) NSString *pinyin;
@property (copy, nonatomic) NSString *name;
@property (nonatomic) int g;
@property (nonatomic) int p;
@property (nonatomic) int f;
@property (nonatomic) int t;
@property (nonatomic) int w;
@property (nonatomic) int g_base;
@property (nonatomic) int p_base;
@property (nonatomic) int f_base;
@property (nonatomic) int t_base;
@property (nonatomic) int w_base;
@property (nonatomic) int move;
@property (nonatomic) int jump;

@property (nonatomic) int cellHeight;


- (id)initWithBmobObject:(BmobObject *)bmobObject;

@end
