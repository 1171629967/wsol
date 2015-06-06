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



////限制一定宽度得到高度
+ (float)getTextHeight:(NSString *)text linebreakMode:(NSLineBreakMode)linebreakMode font:(UIFont *)font width:(float)width{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              font, NSFontAttributeName,
                                              nil];
        CGSize size2 = [text boundingRectWithSize:CGSizeMake(width, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil].size;
        return size2.height;
    }
    
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 3000) lineBreakMode:linebreakMode];
    return  size.height;
}

+ (float)getWidth:(NSString *)text font:(UIFont *)font{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        return [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]].width;
        
        //        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        //        CGSize sizeUp7 = [text boundingRectWithSize:CGSizeMake(1000, 25) options:NSStringDrawingUsesFontLeading attributes:attributesDictionary context:nil].size;
        //        return sizeUp7.width;
    }
    
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(1000, 25) lineBreakMode:1];
    return  size.width;
}


@end
