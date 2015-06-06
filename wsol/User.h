//
//  User.h
//  wsol
//
//  Created by 王 李鑫 on 15/5/19.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <BmobSDK/Bmob.h>




@interface User : BmobUser

/** 保存在服务器的头像名称 */
@property (copy, nonatomic) NSString *faceName;
@property (copy, nonatomic) NSString *faceUrl;
@property (copy, nonatomic) NSString *qq;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *tiebaName;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *gameName;
@property (nonatomic) BmobGeoPoint *lastGeoPoint;
@property (copy, nonatomic) NSString *lastAddress;
@property (copy, nonatomic) NSString *registOS;

@property float addressHeight;



- (id)initWithfaceName:(NSString *)nFaceName AndFaceUrl:(NSString *)nFaceUrl
                 AndQq:(NSString *)nQq AndCity:(NSString *)nCity  AndNickName:(NSString *)nNickName AndTiebaName:(NSString *)nTiebaName
           AndGameName:(NSString *)nGameName AndLastGeoPoint:(BmobGeoPoint *)nLastGeoPoint AndLastAddress:(NSString *)nLastAddress AndRegistOS:(NSString *)nRegistOS AndAddressHeight:(float) nAddressHeight;

@end
