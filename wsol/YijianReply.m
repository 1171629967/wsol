//
//  YijianReply.m
//  wsol
//
//  Created by 王 李鑫 on 15/10/10.
//  Copyright © 2015年 wlx. All rights reserved.
//

#import "YijianReply.h"

@implementation YijianReply

- (id)initWithContent:(NSString *)nContent AndFrom:(int) nfrom

{
    self = [super init];
    if (self) {
        self.content = nContent;
        self.from = nfrom;
        
        if (self.from == 0) {
            self.finalReply = [NSString stringWithString:nContent];
        }
        else if(self.from == 1){
            self.finalReply = [NSString stringWithFormat:@"%@  %@",@"作者回复:",nContent];
        }
        
       CGSize maxSize = CGSizeMake(SCREEN_WIDTH-20, 5000);
       CGRect maxRect = [self.finalReply boundingRectWithSize:maxSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                                 context:nil];
        
        
        
//        CGSize labelSizeContent = {0, 0};
//        labelSizeContent = [self.finalReply sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH-20, 5000)lineBreakMode:NSLineBreakByWordWrapping];
        self.contentHeight = maxRect.size.height +1;
        self.cellHeight = self.contentHeight + 20;
    }
    return self;
}


@end
