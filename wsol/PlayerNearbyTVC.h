//
//  PlayerNearbyTVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/6/2.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface PlayerNearbyTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb_km;
@property (weak, nonatomic) IBOutlet UILabel *lb_nickName;

- (void)setFlickrPhoto:(NSString*)flickrPhoto AndImageView:(EGOImageView *)imageView;

@end
