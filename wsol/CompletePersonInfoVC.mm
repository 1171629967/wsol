//
//  CompletePersonInfoVC.m
//  wsol
//
//  Created by 王 李鑫 on 15/5/21.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "CompletePersonInfoVC.h"
#import "User.h"
#import "Utils.h"
#import "WLXAppDelegate.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>
#import "ZMImagePickerSource.h"
#import "LoginVC.h"



@interface CompletePersonInfoVC ()

@end

@implementation CompletePersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.type == 0) {
        [[super rightItem] setTitle:@"提交"];
        [super label].text = @"完善信息";
        self.bt_loginout.hidden = NO;
    }
    else if(self.type == 1){
        [[super leftItem] setTitle:@"菜单"];
        [[super rightItem] setTitle:@"修改"];
        [super label].text = @"我的信息";
        self.bt_loginout.hidden = NO;
        //设置当前登录用户信息
        [self setUserInfo];
    }
    else if(self.type == 2){
        [super label].text = self.user.nickName;
        self.bt_loginout.hidden = YES;
        //左上角返回按钮白色
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        self.navigationController.navigationBar.translucent = NO;
        
        //设置该用户的信息
        [self setUserInfo];
    }
    
    self.navigationProtal = self;
    self.scrollview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.scrollview.scrollEnabled = YES;
    self.scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, 700);

    //给头像控件添加点击
    self.iv_face.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickFace)];
    [self.iv_face addGestureRecognizer:singleTap];
    //给滚动控件添加点击
    self.scrollview.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel)];
    [self.scrollview addGestureRecognizer:singleTap2];
    
    //给登出按钮添加边框
    self.bt_loginout.layer.borderWidth = 1;
    self.bt_loginout.layer.borderColor = [[UIColor whiteColor]CGColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 设置用户信息 */
- (void)setUserInfo
{
    User *user;
    NSString *faceUrl;
    NSString *nickName;
    NSString *gameName;
    NSString *city;
    NSString *qq;
    NSString *tiebaName;
    if (self.type == 1) {
        user = (User *)[BmobUser getCurrentObject];
        faceUrl = [user objectForKey:@"faceUrl"];
        nickName = [user objectForKey:@"nickName"];
        gameName = [user objectForKey:@"gameName"];
        city = [user objectForKey:@"city"];
        qq = [user objectForKey:@"qq"];
        tiebaName = [user objectForKey:@"tiebaName"];
    }
    else if(self.type == 2){
        user = self.user;
        self.et_nickName.enabled = NO;
        self.et_gameName.enabled = NO;
        self.et_city.enabled = NO;
        self.et_qq.enabled = NO;
        self.et_tiebaName.enabled = NO;
        faceUrl = user.faceUrl;
        nickName = user.nickName;
        gameName = user.gameName;
        city = user.city;
        qq = user.qq;
        tiebaName = user.tiebaName;
    }
    //设置头像
    if (![Utils isBlankString:faceUrl]) {
        NSString *url=[NSString stringWithFormat:@"%@%@",faceUrl,@"?t=1&a=f42ab7d36b6c0ec9ee85440e61c071ec"];
        [self setFlickrPhoto:url AndImageView:(EGOImageView *)self.iv_face];
    }
    //设置别的属性
    self.et_nickName.text = nickName;
    self.et_gameName.text = gameName;
    self.et_city.text = city;
    self.et_qq.text = qq;
    self.et_tiebaName.text = tiebaName;
}

/** 头像点击后处理 */
-(void)clickFace
{
    if (self.type == 2) {
        return;
    }
    
    [ZMImagePickerSource chooseImageFromViewController:self allowEditing:YES imageMaxSizeLength:100 CompletionHandler:^(UIImage *image, NSDictionary *pickingMediainfo, BOOL *dismiss) {
        self.iv_face.image = image;
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        [BmobProFile uploadFileWithFilename:[NSString stringWithFormat:@"%@%@",[NSDate date],@"_faceImage.jpg"] fileData:data block:^(BOOL isSuccessful, NSError *error, NSString *filename, NSString *url) {
            if (isSuccessful) {
                //成功上传图片后区更新用户表中的头像信息
                [self updateUserFace:filename AndUrl:url];
            } else {
                if (error) {
                    NSLog(@"error %@",error);
                }
            }
        } progress:^(CGFloat progress) {
            //上传进度，此处可编写进度条逻辑
            NSLog(@"progress %f",progress);
        }];
        
    
    }];
}

/** 收起软键盘 */
-(void)cancel
{
    [self.view endEditing:YES];
}

-(void)leftAction
{
    if (self.type == 1) {
        [self.sideMenuViewController openMenuAnimated:YES completion:nil];
    }
}


/** 更新用户表中的头像信息 */
-(void)updateUserFace:(NSString *)faceName AndUrl:(NSString *)faceUrl
{
    User *bUser = (User *)[User getCurrentUser];
    //更新number为30
    [bUser setObject:faceName forKey:@"faceName"];
    [bUser setObject:faceUrl forKey:@"faceUrl"];
    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
       
    }];
}

-(void)rightAction
{
    if (self.type == 2) {
        return;
    }
    
    
    [self.view endEditing:YES];
    //非空判断
    if ([Utils isBlankString:self.et_nickName.text]) {
        HUD.mode = MBProgressHUDModeText;
        HUD.hidden = NO;
        HUD.labelText = @"请输入昵称";
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            HUD.hidden = YES;
        }];
        return;
    }
    
    
    
    HUD.mode = MBProgressHUDModeText;
    HUD.hidden = NO;
    User *user = (User *)[User getCurrentUser];
    [user setObject:self.et_nickName.text forKey:@"nickName"];
    [user setObject:self.et_gameName.text forKey:@"gameName"];
    [user setObject:self.et_qq.text forKey:@"qq"];
    [user setObject:self.et_tiebaName.text forKey:@"tiebaName"];
    [user setObject:self.et_city.text forKey:@"city"];
    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            HUD.labelText = @"提交成功";
            [HUD showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            } completionBlock:^{
                HUD.hidden = YES;
                //进入主页
                WLXAppDelegate *appDelegate = (WLXAppDelegate *)[[UIApplication sharedApplication] delegate];
                appDelegate.window.rootViewController = appDelegate.sideMenuViewController;
            }];
        }
        else {
            HUD.labelText = [error description];
            [HUD showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            } completionBlock:^{
                HUD.hidden = YES;
            }];
        }
    }];
}





- (void)setFlickrPhoto:(NSString*)flickrPhoto AndImageView:(EGOImageView *)imageView{
    imageView.imageURL = [NSURL URLWithString:flickrPhoto];
}



/** 账号登出 */
- (IBAction)loginOut:(id)sender {
    [User logout];
    WLXAppDelegate *appDelegate = (WLXAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    [appDelegate exitApplication];
    
    
    
    
//    appDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]];
}
@end
