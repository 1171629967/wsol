//
//  Utils.h
//  wsol
//
//  Created by 王 李鑫 on 14/12/11.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSMutableArray *)JsonToPianzis:(NSString *)json AndPianziNames:(NSMutableArray *)pianziNames;

+ (int)totalPianziPages:(NSString *)json ;

//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;


@end
