//
//  Utils.m
//  wsol
//
//  Created by 王 李鑫 on 14/12/11.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import "Utils.h"
#import "CJSONDeserializer.h"
#import "Pianzi.h"

@implementation Utils
+ (NSMutableArray *)JsonToPianzis:(NSString *)json AndPianziNames:(NSMutableArray *)pianziNames;
{
    NSError *error;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSDictionary *rootDic = [[CJSONDeserializer deserializer] deserialize:[json dataUsingEncoding:NSUTF8StringEncoding] error:&error];
    NSArray *dicarray = [rootDic objectForKey:@"pianzis"];
    
    for (NSDictionary *dic in dicarray) {
        NSString *name = [dic objectForKey:@"name"];
        NSString *jietu = [dic objectForKey:@"jietu"];
        NSString *zhengjuurl = [dic objectForKey:@"zhengjuurl"];
        NSString *beizhu = [dic objectForKey:@"beizhu"];
        [pianziNames addObject:name];
        Pianzi *pianzi = [[Pianzi alloc] initWithName:name Jietu:jietu Zhengjuurl:zhengjuurl Beizhu:beizhu];
        [array addObject:pianzi];
    }
    
    return array;
}

+ (int)totalPianziPages:(NSString *)json
{
    NSError *error;
    NSDictionary *rootDic = [[CJSONDeserializer deserializer] deserialize:[json dataUsingEncoding:NSUTF8StringEncoding] error:&error];
    NSNumber *page = (NSNumber *)[rootDic objectForKey:@"totalPianziPage"];
    int p = [page intValue];
    return p;
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


@end
