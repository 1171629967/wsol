//
//  YijianVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/1/9.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YijianVC : UIViewController<UITextViewDelegate>
{
    UIActivityIndicatorView *activityIndicator;
    
    UILabel *lb_des;
    UILabel *lb_tiebaName;
    UILabel *lb_gameName;
    UILabel *lb_qq;
    
    UITextView *tf_tiebaName;
    UITextView *tf_gameName;
    UITextView *tf_qq;
    UITextView *tf_yijian;
    
    UILabel *lb_hidTieba;
    UILabel *lb_hidGame;
    UILabel *lb_hidQQ;
    UILabel *lb_hidYijian;
    
    UIScrollView *scrollView;
    
    
}

@end