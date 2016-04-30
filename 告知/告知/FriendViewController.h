//
//  FriendViewController.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/10.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
@interface FriendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView  *focusTV;;
@end
