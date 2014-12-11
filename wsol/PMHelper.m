//
//  PMHelper.m
//  PM_MonitorSystem
//
//  Created by GaoKai on 13-6-22.
//  Copyright (c) 2013年 PM. All rights reserved.
//

#import "PMHelper.h"
#import <CommonCrypto/CommonDigest.h>

#pragma mark ASIHTTPRequest
@implementation ASIHTTPRequest (JSON)

- (id)responseJsonDataWithKey:(NSString *)key
{
    NSDictionary *rootDic = [self responseJsonData];
    return [rootDic objectForKey:key];
}

- (NSDictionary *)responseJsonData
{
    //取得请求返回的二进制数据
    NSData *responseData = [self responseData];
    
    //把二进制数据转化为字典对象
    NSError *myError = nil;
    return [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&myError];
    
}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end

@implementation NSString (MD5)

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    NSMutableString *hash = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash lowercaseString];
}

@end
