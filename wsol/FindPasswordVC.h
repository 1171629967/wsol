//
//  FindPasswordVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/12/7.
//  Copyright © 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"

@interface FindPasswordVC : BaseViewController<NavigationProtal>
{
    UIScrollView *scrollView;
    //UIView *container;
    
    
    UIView *v_line1;
    UILabel *lb_userName;
    UITextField *tf_userName;
    UIView *v_line2;
    
    UIButton *bt_send;
    UILabel *lb_des;

}

@end
