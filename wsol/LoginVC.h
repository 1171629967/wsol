//
//  LoginVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/5/19.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *bt_login;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bt_regist;
- (IBAction)regist:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bt_cancel;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *et_userName;
@property (weak, nonatomic) IBOutlet UITextField *et_password;

@end
