//
//  AboutApp.h
//  wsol
//
//  Created by 王 李鑫 on 14-9-7.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadtxtVC : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textview;
@property (copy, nonatomic) NSString *txtName;
@property (copy, nonatomic) NSString *titleName;
@end