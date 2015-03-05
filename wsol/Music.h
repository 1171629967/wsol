//
//  Music.h
//  wsol
//
//  Created by 王 李鑫 on 15/2/10.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface Music : NSObject

@property  BmobFile *musicFile;
@property (copy, nonatomic) NSString *musicName;
@property int musicId;
@property (copy, nonatomic) NSString *musicContent;

@property int cellHeight;
@property int contentHeight;

- (id)initWithMusicFile:(BmobFile *)nMusicFile AndMusicName:(NSString *)nMusicName AndMusicId:(int)nMusicId;



@end
