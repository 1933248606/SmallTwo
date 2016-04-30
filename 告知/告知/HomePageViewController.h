//
//  HomePageViewController.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/10.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideslipView.h"
#import "PersonCenterVC.h"                     //个人中心
#import "OrderViewController.h"                //接单
#import "ChooseAdvTypeVC.h"                    //发单
#import "AdvertisingVC.h"                      //我的广告
#import "MoneyVC.h"                            //我的钱包
#import "PersonMessageVC.h"                    //消息中心
#import "FriendViewController.h"               //我的圈子
#import "OthersSeeVC.h"                        //个人中心
#import "MoreVC.h"                             //更多
#import "LoopScrollview.h"                     //水平滚动轮播
#import "VideoAdvCVCell.h"                     //自定义集合视图(关于视频)
#import "VideoAdvTableCell.h"                  //自定义单元格(关于视频)
#import "HotAdvTableViewCell.h"                //自定义单元格(关于热门广告)
#import "HighestPriceAdvTVCell.h"              //自定义单元格(关于单价最高)

@interface HomePageViewController : UIViewController<SlideslipDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    UIImageView              *TopIV;
    UIView                   *_backView;
    UICollectionView         *myCollectionView;
    UIView                   *MaskView;//添加一层蒙版
    SideslipView             *slideslip;//侧滑
    OrderViewController      *orderVC;
    ChooseAdvTypeVC          *AdvTypeVC;
    PersonCenterVC           *personCenterVC;
    AdvertisingVC            *myAdv;
    MoneyVC                  *myPurse;
    PersonMessageVC          *personMessageVC;
    FriendViewController     *Myfriends;
    MoreVC                   *moreVC;
    OthersSeeVC              *OthersSee;
    UITableView              *HotAdvTV;
}
@property(nonatomic,retain)NSArray *dataArr;
@end
