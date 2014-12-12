//
//  PianziTVC.h
//  wsol
//
//  Created by 王 李鑫 on 14/12/11.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface PianziTVC : UITableViewCell



@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *zhengjuText;
@property (strong,nonatomic) IBOutlet UITextView *zhengju;


@property (strong, nonatomic) IBOutlet UILabel *beizhuText;

@property (strong, nonatomic) IBOutlet UITextView *beizhu;

- (void)setFlickrPhoto:(NSString*)flickrPhoto AndImageView:(EGOImageView *)imageView;

@end
