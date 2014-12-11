//
//  Pianzi.h
//  wsol
//
//  Created by 王 李鑫 on 14/12/11.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pianzi : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *jietu;
@property (copy, nonatomic) NSString *zhengjuurl;
@property (copy, nonatomic) NSString *beizhu;

@property (nonatomic,retain) UIImage * imgData;

@property int zhengjuHeight;
@property int beizhuHeight;
@property int cellHeight;

- (id)initWithName:(NSString *)nName
              Jietu:(NSString *)nJietu
            Zhengjuurl:(NSString *)nZhengjuurl
  Beizhu:(NSString *)nBeizhu;

@end
