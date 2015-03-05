//
//  Transation.m
//  wsol
//
//  Created by 王 李鑫 on 15/3/5.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "Transation.h"

@implementation Transation
- (id)initWithTitle:(NSString *)nTitle
                Buy:(NSString *)nBuy
               Sell:(NSString *)nSell
                Url:(NSString *)nUrl
{
    self = [super init];
    if (self) {
        self.title = nTitle;
        self.buy = nBuy;
        self.sell = nSell;
        self.url = nUrl;   
    }
    return self;
}

@end
