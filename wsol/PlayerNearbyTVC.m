//
//  PlayerNearbyTVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/6/2.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "PlayerNearbyTVC.h"

@implementation PlayerNearbyTVC

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setFlickrPhoto:(NSString*)flickrPhoto AndImageView:(EGOImageView *)imageView{
    imageView.imageURL = [NSURL URLWithString:flickrPhoto];
}

- (void)willMoveToSuperview:(UIView *)newSuperview AndImageView:(EGOImageView *)imageView{
    [super willMoveToSuperview:newSuperview];
    
    if(!newSuperview) {
        [imageView cancelImageLoad];
    }
}

@end
