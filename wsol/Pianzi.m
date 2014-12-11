//
//  Pianzi.m
//  wsol
//
//  Created by 王 李鑫 on 14/12/11.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "Pianzi.h"

@implementation Pianzi

- (id)initWithName:(NSString *)nName
             Jietu:(NSString *)nJietu
        Zhengjuurl:(NSString *)nZhengjuurl
            Beizhu:(NSString *)nBeizhu
{
    self = [super init];
    if (self) {
        self.name = nName;
        self.jietu = nJietu;
        self.zhengjuurl = nZhengjuurl;
        self.beizhu = nBeizhu;
        
        CGSize labelSizeZhengju = {0, 0};
        labelSizeZhengju = [nZhengjuurl sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(150.0, 5000)lineBreakMode:UILineBreakModeWordWrap];
        self.zhengjuHeight = labelSizeZhengju.height+5;
        
        CGSize labelSizeBeizhu = {0, 0};
        labelSizeBeizhu = [nBeizhu sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(150.0, 5000)lineBreakMode:UILineBreakModeWordWrap];
        self.beizhuHeight = labelSizeBeizhu.height+5;
        
        self.cellHeight = 46 + 10 + self.zhengjuHeight + 10 + self.beizhuHeight + 10;
        if (self.cellHeight < 100) {
            self.cellHeight = 100;
        }
    }
    return self;
}

@end
