//
//  Renwu.m
//  wsol
//
//  Created by 王 李鑫 on 15/7/29.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "Renwu.h"

@implementation Renwu


- (id)initWithRenwuName:(NSString *)nRenwuName
             RenwuLevel:(NSString *)nRenwuLevel
                RenwuId:(int)nRenwuId
{
    self = [super init];
    if (self) {
        self.renwuId = nRenwuId;
        self.renwuName = nRenwuName;
        self.renwuLevel = nRenwuLevel;
    }
    return self;

}

@end
