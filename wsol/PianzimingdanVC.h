//
//  PianzimingdanVC.h
//  wsol
//
//  Created by 王 李鑫 on 14/12/10.
//  Copyright (c) 2014年 wlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "EGOImageView.h"


@interface PianzimingdanVC : UITableViewController <UISearchBarDelegate,UISearchDisplayDelegate,UIScrollViewDelegate>
{
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
    UIActivityIndicatorView *activityIndicator;
     EGOImageView* imageView;
}
@property (strong, nonatomic) NSMutableArray *pianzis;
@property (strong, nonatomic) NSMutableArray *suggesPianzis;

@property (strong, nonatomic) NSMutableArray *pianziNames;
@property (strong, nonatomic) NSMutableArray *suggesPianziNames;



@end
