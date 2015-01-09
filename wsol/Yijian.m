//
//  Yijian.m
//  wsol
//
//  Created by 王 李鑫 on 15/1/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "Yijian.h"

@implementation Yijian


- (id)initWithContent:(NSString *)nContent

{
    self = [super init];
    if (self) {
        self.content = nContent;
        
        
        
        CGSize labelSizeContent = {0, 0};
        labelSizeContent = [nContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 5000)lineBreakMode:UILineBreakModeWordWrap];
        self.contentHeight = labelSizeContent.height+10;
        self.cellHeight = self.contentHeight+20;
        
        
        
    }
    return self;
}

@end
