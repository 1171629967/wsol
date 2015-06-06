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
                 AndQq:(NSString *)nQq AndCity:(NSString *)nCity  AndNickName:(NSString *)nNickName AndTiebaName:(NSString *)nTiebaName
           AndGameName:(NSString *)nGameName AndLastGeoPoint:(BmobGeoPoint *)nLastGeoPoint AndLastAddress:(NSString *)nLastAddress AndRegistOS:(NSString *)nRegistOS AndAddressHeight:(float) nAddressHeight
{
    self = [super init];
    if (self) {
        self.faceName = nFaceName;
        self.faceUrl = nFaceUrl;
        self.qq = nQq;
        self.city = nCity;
        self.nickName = nNickName;
        self.tiebaName = nTiebaName;
        self.gameName = nGameName;
        self.lastGeoPoint = nLastGeoPoint;
        self.lastAddress = nLastAddress;
        self.registOS = nRegistOS;
        self.addressHeight = nAddressHeight;
    }
    return self;
}

@end
