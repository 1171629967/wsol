//
//  PMHelper.h
//  PM_MonitorSystem
//
//  Created by GaoKai on 13-6-22.
//  Copyright (c) 2013年 PM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

#pragma mark ASIHTTPRequest
@interface ASIHTTPRequest (JSON)

/*
 函数功能：获得ASIHTTPRequest对象返回的json数据
 参数：
    key：所需数据对应的key值
 作者：高凯
 日期：2013-6-13
*/
- (id)responseJsonDataWithKey:(NSString *)key;

/*
 函数功能：获得ASIHTTPRequest对象返回的json数据
 作者：高凯
 日期：2013-6-15
*/
- (NSDictionary *)responseJsonData;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;

@end

#pragma mark NSString
@interface NSString (MD5)

/*
 函数功能：对字符串进行MD5加密
 作者：高凯
 日期：2013-6-15
*/
- (NSString *)MD5;

@end
