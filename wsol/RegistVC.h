//
//  RegistVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/5/20.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"

@interface RegistVC : BaseViewController
- (IBAction)cancle:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *et_userName;
@property (weak, nonatomic) IBOutlet UITextField *et_password;
@property (weak, nonatomic) IBOutlet UIButton *bt_cancel;
@property (weak, nonatomic) IBOutlet UIButton *bt_rigistConfirm;

- (IBAction)registConfirm:(id)sender;

@end
