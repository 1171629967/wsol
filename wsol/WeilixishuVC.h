//
//  WeilixishuVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/1/8.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WeilixishuVC : BaseViewController<NavigationProtal>
{
    //是否已经显示了系数说明
    BOOL isShowedExplain;
    BOOL isHaveWeaponDes;

    
    UIScrollView *scrollView;
    UIView *container;
    UILabel *lb_weaponName;
    UIButton *bt_explain;
    UILabel *lb_explainContent;
    UILabel *lb_beizu;
    UILabel *lb_weaponDes;

    
    UIView *allXIshuView;
    
    UIView *v_line1;
    UIView *v_line2;
    UIView *v_line3;
    UIView *v_line4;
    UIView *v_line5;
    UIView *v_line6;
    
    
    UIView *v_N1_N6;
    UIView *v_E6_E9;
    UIView *v_C2_C5;
    UIView *v_D_JC;
    UIView *v_tu_ba;
    UIView *v_puwu_zhenmo;
    UIView *v_N1data_N6data;
    UIView *v_E6data_E9data;
    UIView *v_C2data_C5data;
    UIView *v_Ddata_JCdata;
    UIView *v_tudata_badata;
    UIView *v_puwudata_zhenmodata;
    
    UILabel *lb_N1;
    UILabel *lb_N2;
    UILabel *lb_N3;
    UILabel *lb_N4;
    UILabel *lb_N5;
    UILabel *lb_N6;
    UILabel *lb_N1data;
    UILabel *lb_N2data;
    UILabel *lb_N3data;
    UILabel *lb_N4data;
    UILabel *lb_N5data;
    UILabel *lb_N6data;
    
    UILabel *lb_E6;
    UILabel *lb_E7;
    UILabel *lb_E8;
    UILabel *lb_E9;
    UILabel *lb_E6data;
    UILabel *lb_E7data;
    UILabel *lb_E8data;
    UILabel *lb_E9data;
    
    UILabel *lb_C2;
    UILabel *lb_C3;
    UILabel *lb_C4;
    UILabel *lb_C5;
    UILabel *lb_C2data;
    UILabel *lb_C3data;
    UILabel *lb_C4data;
    UILabel *lb_C5data;
    
    UILabel *lb_D;
    UILabel *lb_JA;
    UILabel *lb_JC;
    UILabel *lb_Ddata;
    UILabel *lb_JAdata;
    UILabel *lb_JCdata;
    
    UILabel *lb_tu;
    UILabel *lb_dun;
    UILabel *lb_sui;
    UILabel *lb_zhen;
    UILabel *lb_wei;
    UILabel *lb_ba;
    UILabel *lb_tudata;
    UILabel *lb_dundata;
    UILabel *lb_suidata;
    UILabel *lb_zhendata;
    UILabel *lb_weidata;
    UILabel *lb_badata;
    
    UILabel *lb_puwuAndZhenwu;
    UILabel *lb_pumo;
    UILabel *lb_zhenmo;
    UILabel *lb_puwuAndZhenwudata;
    UILabel *lb_pumodata;
    UILabel *lb_zhenmodata;

    
    int margin;
}

@property (copy, nonatomic) NSString *weaponName;


@end
