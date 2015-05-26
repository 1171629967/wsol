//
//  JinpaiWeaponVC.h
//  wsol
//
//  Created by 王 李鑫 on 15/5/11.
//  Copyright (c) 2015年 wlx. All rights reserved.
//

#import "BaseViewController.h"
#import "WeilixishuVC.h"
#import "JinpaiWeaponTVC.h"

@interface JinpaiWeaponVC : BaseViewController<UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate,UISearchDisplayDelegate,NavigationProtal>
{
    int weaponsTypeCount;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
    WeilixishuVC *wlxsVC;
    UITableView *tableview;
   
    
    NSMutableArray *weapons;
    NSMutableArray *suggestWeapons;
    
    UIToolbar *mycustomToolBar;
    
    int currentMode;
}



//@property (strong, nonatomic) NSMutableArray *weaponNamesR1;
//@property (strong, nonatomic) NSArray *suggesWeaponNamesR1;
//@property (strong, nonatomic) NSMutableArray *weaponNamesR1_pinyin;
//@property (strong, nonatomic) NSArray *suggesWeaponNamesR1_pinyin;


@property (copy, nonatomic) JinpaiWeaponTVC *prototypeCell;


@end
