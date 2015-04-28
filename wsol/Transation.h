//
//  Transation.h
//  wsol
//
//  Created by 王 李鑫 on 15/3/5.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transation : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *url;





- (id)initWithTitle:(NSString *)nTitle
            Url:(NSString *)nUrl;

@end
