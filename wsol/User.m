//
//  User.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/19.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithfaceName:(NSString *)nFaceName AndFaceUrl:(NSString *)nFaceUrl
                 AndQq:(NSString *)nQq AndCity:(NSString *)nCity AndTiebaName:(NSString *)nTiebaName
           AndGameName:(NSString *)nGameName AndLastGeoPoint:(BmobGeoPoint *)nLastGeoPoint AndLastAddress:(NSString *)nLastAddress AndRegistOS:(NSString *)nRegistOS
{
    self = [super init];
    if (self) {
        self.faceName = nFaceName;
        self.faceUrl = nFaceUrl;
        self.qq = nQq;
        self.city = nCity;
        self.tiebaName = nTiebaName;
        self.gameName = nGameName;
        self.lastGeoPoint = nLastGeoPoint;
        self.lastAddress = nLastAddress;
        self.registOS = nRegistOS;
    }
    return self;
}

@end
