//
//  Yijian.h
//  wsol
//
//  Created by 王 李鑫 on 15/1/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Yijian : NSObject

@property (copy, nonatomic) NSString *content;


@property int cellHeight;
@property int contentHeight;

- (id)initWithContent:(NSString *)nContent
             
        ;

@end
