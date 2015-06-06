//
//  MenuTableVC.h
//  wsol
//
//  Created by 王 李鑫 on 14-9-9.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMScrollingTicker.h"
#import "ASIHTTPRequest.h"
#import <BaiduMapAPI/BMapKit.h>
#import <BmobSDK/Bmob.h>


@interface MenuTableVC : UITableViewController<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    NSString *currentMenuString;
    NSArray *typesArray;
    NSArray *menusArray;
    DMScrollingTicker *scrollingTicker;
    BMKLocationService* _locService;
    BMKGeoCodeSearch *_searcher;
    
    BmobGeoPoint *point;
}


@end
