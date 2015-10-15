//
//  Yijian.m
//  wsol
//
//  Created by 王 李鑫 on 15/1/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "Yijian.h"

@implementation Yijian


- (id)initWithContent:(NSString *)nContent AndObjectId:(NSString *)nObjectId

{
    self = [super init];
    if (self) {
        self.content = nContent;
        self.objectId = nObjectId;
        
        CGSize maxSize = CGSizeMake(SCREEN_WIDTH-50, 5000);
        CGRect maxRect = [nContent boundingRectWithSize:maxSize
                                                       options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                                       context:nil];
        
        
        
//        CGSize labelSizeContent = {0, 0};
//        labelSizeContent = [nContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH-20, 5000)lineBreakMode:NSLineBreakByWordWrapping];
        
        
        self.contentHeight = maxRect.size.height+3;
        self.cellHeight = self.contentHeight+20;
        
        
    }
    return self;
}

@end
