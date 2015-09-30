//
//  Renwu.h
//  wsol
//
//  Created by 王 李鑫 on 15/7/29.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Renwu : NSObject
@property (copy, nonatomic) NSString *renwuName;
@property (copy, nonatomic) NSString *renwuLevel;
@property int renwuId;

- (id)initWithRenwuName:(NSString *)nRenwuName
             RenwuLevel:(NSString *)nRenwuLevel
        RenwuId:(int)nRenwuId;

@end
