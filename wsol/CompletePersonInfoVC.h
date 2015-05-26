//
//  CompletePersonInfoVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/5/21.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"

@interface CompletePersonInfoVC : BaseViewController<NavigationProtal>
{
    //图片2进制路径
    NSString* filePath;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIImageView *iv_face;
@property (weak, nonatomic) IBOutlet UITextField *et_nickName;
@property (weak, nonatomic) IBOutlet UITextField *et_gameName;
@property (weak, nonatomic) IBOutlet UITextField *et_qq;
@property (weak, nonatomic) IBOutlet UITextField *et_tiebaName;
@property (weak, nonatomic) IBOutlet UITextField *et_city;
@property (weak, nonatomic) IBOutlet UIButton *bt_loginout;
- (IBAction)loginOut:(id)sender;

/** 0:来自注册   1：当前登录用户主页   2:别的用户主页 */
@property (nonatomic) int type;
@property (copy, nonatomic) NSString *personNick;





@end
