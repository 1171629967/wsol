//
//  YijianReply.h
//  wsol
//
//  Created by 王 李鑫 on 15/10/10.
//  Copyright © 2015年 wlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YijianReply : NSObject

@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *finalReply;

@property int from;


@property int cellHeight;
@property int contentHeight;


- (id)initWithContent:(NSString *)nContent AndFrom:(int) nfrom;

@end
