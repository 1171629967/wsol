//
//  Music.m
//  wsol
//
//  Created by 王 李鑫 on 15/2/10.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "Music.h"

@implementation Music


- (id)initWithMusicFile:(BmobFile *)nMusicFile AndMusicName:(NSString *)nMusicName AndMusicId:(int)nMusicId{
    self = [super init];
    if (self) {
        self.musicFile = nMusicFile;
        self.musicId = nMusicId;
        self.musicName = nMusicName;
        
        
        self.musicContent = [NSString stringWithFormat:@"%d%@%@%@",self.musicId,@".",self.musicName,@".mp3"];
        CGSize labelSizeContent = {0, 0};
        labelSizeContent = [self.musicContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 5000)lineBreakMode:UILineBreakModeWordWrap];
        self.contentHeight = labelSizeContent.height+10;
        self.cellHeight = self.contentHeight+20;
        
        
    }
    return self;
}


@end
