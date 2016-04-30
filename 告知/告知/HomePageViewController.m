//
//  HomePageViewController.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/10.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "HomePageViewController.h"
#import "LoginVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "QYHttpRequest.h"
#import <UMSocial.h>
#import "QYUser.h"
#import "QueryUserInfo.h"
#import "QYAdvClassHttpRequest.h"
#import "AdvClassifyModel.h"
@interface HomePageViewController ()<UIScrollViewDelegate>
{
    UIView *HeaderView;//自定义区头
    HomePageViewController *homeVC;
}
@end

@implementation HomePageViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    UITapGestureRecognizer *clickswipeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickswipeGestureAction:)];
//    // 添加手势
//    [self.view addGestureRecognizer:clickswipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightswipeGestureAction:)];
    
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:rightSwipeGesture];

    _backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    TopIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, TOP_BAR)];
    TopIV.image = [UIImage imageNamed:@"banner"];
    [_backView addSubview:TopIV];
    
    //用户头像侧滑按钮，
    UIButton *UserHeadPicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [UserHeadPicBtn setImage:[UIImage imageNamed:@"loading_icon"] forState:(UIControlStateNormal)];
    [UserHeadPicBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, 10, 10, 0))];
    [UserHeadPicBtn addTarget:self action:@selector(UserHeadClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:UserHeadPicBtn];
    
    UIButton *locationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [locationBtn setTitle:@"长沙" forState:(UIControlStateNormal)];
    [locationBtn setImage:[UIImage imageNamed:@"location_icon"] forState:(UIControlStateNormal)];
    [locationBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, 0, 10, 0))];
    locationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [locationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
    [locationBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [locationBtn addTarget:self action:@selector(locationBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:locationBtn];
    
    HotAdvTV = [[UITableView alloc]initWithFrame:CGRectMake(0,TOP_BAR, WIDTH, HEIGHT-114) style:(UITableViewStylePlain)];
    HotAdvTV.delegate = self;
    HotAdvTV.dataSource = self;
    [HotAdvTV registerNib:[UINib nibWithNibName:@"VideoAdvTableCell" bundle:nil] forCellReuseIdentifier:@"VideoAdvCell"];
    [HotAdvTV registerNib:[UINib nibWithNibName:@"HotAdvTableViewCell" bundle:nil] forCellReuseIdentifier:@"HotAdvCell"];
    [HotAdvTV registerNib:[UINib nibWithNibName:@"HighestPriceAdvTVCell" bundle:nil] forCellReuseIdentifier:@"HighestPriceAdvCell"];
    [_backView addSubview:HotAdvTV];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [UserHeadPicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom);
        make.left.equalTo(TopIV.mas_left);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(0);
        make.right.equalTo(TopIV.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, 35));
    }];
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = BackGroundColor(230, 230, 230, 1);
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];
    //发单
    UIButton *ReceiptBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [ReceiptBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    ReceiptBtn.layer.masksToBounds = YES;
    ReceiptBtn.layer.cornerRadius = 4;
    ReceiptBtn.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [ReceiptBtn setTitle:@"发  单" forState:(UIControlStateNormal)];
    [ReceiptBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    ReceiptBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [ReceiptBtn addTarget:self action:@selector(LeafletsClick:) forControlEvents:(UIControlEventTouchUpInside)];
    ReceiptBtn.tag = 1;
    [bottomView addSubview:ReceiptBtn];
    
    UIButton *OrderBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [OrderBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    OrderBtn.layer.masksToBounds = YES;
    OrderBtn.layer.cornerRadius = 4;
    OrderBtn.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [OrderBtn setTitle:@"接  单" forState:(UIControlStateNormal)];
    [OrderBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    OrderBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [OrderBtn addTarget:self action:@selector(LeafletsClick:) forControlEvents:(UIControlEventTouchUpInside)];
    OrderBtn.tag = 2;
    [bottomView addSubview:OrderBtn];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 50));
    }];
    [ReceiptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(bottomView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5*2, 40));
    }];
    [OrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5*2, 40));
        make.right.equalTo(bottomView.mas_right).with.offset(-20);
    }];

    MaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    MaskView.backgroundColor = [UIColor grayColor];
    MaskView.alpha = 0.3;
    [self.view addSubview:MaskView];
    MaskView.hidden = YES;
    slideslip = [[SideslipView alloc]initWithFrame:CGRectMake(-WIDTH/4*3, 0, WIDTH/4*3, HEIGHT)];
    slideslip.delegate = self;
    [self.view addSubview:slideslip];
    
    [QYAdvClassHttpRequest requestQueryClassify:^(NSArray *dataArray) {
        self.dataArr = dataArray;
        [HotAdvTV reloadData];
    }];
}
//定位地址
-(void)locationBtnClick
{
    
}
//用户头像
-(void)UserHeadClick:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatCount:0];
    slideslip.frame = CGRectMake(0, 0, WIDTH/4*3, HEIGHT);
    [UIView commitAnimations];
    MaskView.hidden = NO;
}
#pragma mark 集合视图数据源协议方法
///区中有几个子项
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *VideoCellID = @"VideoCellID";
    //找出可以重用的子项
    VideoAdvCVCell *VideoCell =[collectionView dequeueReusableCellWithReuseIdentifier:VideoCellID forIndexPath:indexPath];
    
    //子项如何显示
    //NSString *imagename = [NSString stringWithFormat:@"%d",indexPath.item];
//    VideoCell.PriceLabel.text = @"单价：";
//    VideoCell.CollectionIV.image = [UIImage imageNamed:@"night9.jpg"];
//    VideoCell.TitleLabel.text = @"农夫山泉矿泉水";
    return VideoCell;
}
//子项被点击的时候，该方法被调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"被点击了");

}
#pragma mark -表的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 120;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 120;
    }
    
        return 100;
}
#pragma mark --自定义表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    HeaderView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    if (section == 0) {
        //水平的滚动视图，展示轮播图片
        LoopScrollview *scrollView = [[LoopScrollview alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
        
        scrollView.images = @[[UIImage imageNamed:@"night8.jpg"],[UIImage imageNamed:@"night9.jpg"],[UIImage imageNamed:@"night10.jpg"],];
        scrollView.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        scrollView.pageControl.frame = CGRectMake(WIDTH/4, 100, WIDTH/2,20);
        [HeaderView addSubview:scrollView];
    }
    if (section == 1) {
        HeaderView.backgroundColor = [UIColor whiteColor];
        NSArray *classifyIconArr = @[@"home_cf_cy",@"home_cf_gw",@"home_cf_xx",@"home_cf_zp",@"home_cf_jd",@"home_cf_fc",@"find_icon",@"home_cf_qt",];
        for (int j = 0; j < 2; j++)
        {
            for (int i = 0 ; i < 4; i++)
            {
                UIButton  *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                btn.frame =CGRectMake(i*WIDTH/4, j*60, WIDTH/4, 60);
                [btn  setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
                btn.tag = i+j*4;
                [btn addTarget:self action:@selector(classifyClick:) forControlEvents:(UIControlEventTouchUpInside)];
                [HeaderView addSubview:btn];
                UIImageView *imgView = [[UIImageView alloc]init];
                imgView.image = [UIImage imageNamed:[classifyIconArr objectAtIndex:i*2+j]];
                [btn addSubview:imgView];
                [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(btn.mas_centerX);
                    make.top.equalTo(btn.mas_top).with.offset(5);
                    make.size.mas_equalTo(CGSizeMake(30, 30));
                }];
                UILabel *label = [[UILabel alloc]init];
                label.text = [NSString stringWithFormat:@"%@",self.dataArr[i+4*j]];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:12];
                [btn addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(btn.mas_centerX);
                    make.bottom.equalTo(btn.mas_bottom).with.offset(-5);
                    make.height.mas_equalTo(15);
                }];

            }
        }

        
    }
    if (section == 2) {
        UIButton *videoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        videoBtn.frame = CGRectMake(0, 0, WIDTH, 40);
        [videoBtn addTarget:self action:@selector(videoClick) forControlEvents:(UIControlEventTouchUpInside)];
        [HeaderView addSubview:videoBtn];
        
        UIImageView *VideoIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 16, 16)];
        VideoIV.image = [UIImage imageNamed:@"vido_icon"];
        [videoBtn addSubview:VideoIV];
        
        UILabel *VideoLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, WIDTH/5, 40)];
        VideoLabel.text = @"视频广告";
        VideoLabel.font = [UIFont systemFontOfSize:14];
        [videoBtn addSubview:VideoLabel];
        [self createRedIcon];
    }
    if (section == 3) {
        
        UIImageView *PricesHeighsetIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 16, 16)];
        PricesHeighsetIV.image = [UIImage imageNamed:@"icon_price"];
        [HeaderView addSubview:PricesHeighsetIV];
        UILabel *HeighsetAdvLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, WIDTH/5, 40)];
        HeighsetAdvLabel.text = @"单价最高";
        HeighsetAdvLabel.font = [UIFont systemFontOfSize:14];
        [HeaderView addSubview:HeighsetAdvLabel];
        [self createRedIcon];
    }
    
    return HeaderView;
}
#pragma mark --分区返回的cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 0;
    }
    else if (section == 2) {
        return 1;
    }
        return 5;
}
#pragma mark --每个区的单元格显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        VideoAdvTableCell *Videocell = [tableView dequeueReusableCellWithIdentifier:@"VideoAdvCell"];
        //首先，声明一个集合视图滚动的方式(相当于button)
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //添加子项大小
        flowLayout.itemSize = CGSizeMake(150, 120);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //创建集合视图
        myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 120) collectionViewLayout:flowLayout];
        myCollectionView.delegate = self;
        myCollectionView.dataSource = self;
        myCollectionView.backgroundColor = [UIColor whiteColor];
        //注册单元格
        [myCollectionView registerNib:[UINib nibWithNibName:@"VideoAdvCVCell" bundle:nil] forCellWithReuseIdentifier:@"VideoCellID"];
        [Videocell addSubview:myCollectionView];
        return Videocell;
        
        
    }
    NSArray *IconArr = @[@"label_no1",@"label_no2",@"label_no3",@"label_no4",@"label_no5"];
        HighestPriceAdvTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HighestPriceAdvCell"];
    cell.Sequence_IV.image = [UIImage imageNamed:[IconArr objectAtIndex:indexPath.row]];
        return cell;
}
#pragma mark -- 区头随单元格滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 40;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}
-(void)createRedIcon
{
    UIImageView *redIcon_IV = [[UIImageView alloc]init];
    redIcon_IV.image = [UIImage imageNamed:@"home_icon_more"];
    [HeaderView addSubview:redIcon_IV];
    [redIcon_IV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(HeaderView.mas_bottom).with.offset(-10);
        make.right.equalTo(HeaderView.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];

}
#pragma mark -- 广告分类
-(void)classifyClick:(UIButton*)btn
{
    switch (btn.tag) {
        case 0:
            orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        case 1:
            orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        case 2:
            orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        case 3:
            orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        case 4:
            orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        case 5:
            orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        case 6:
            orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        case 7:
            orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        default:
            break;
    }
}
/*
视频广告
*/
-(void)videoClick
{
    orderVC = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:orderVC animated:YES];
}
/*
用户发单
接单
*/
#pragma mark -AboutReleaseAndOrder
-(void)LeafletsClick:(UIButton*)button
{
    switch (button.tag) {
        case 1:
            AdvTypeVC = [[ChooseAdvTypeVC alloc]init];
            [self.navigationController pushViewController:AdvTypeVC animated:YES];
            break;
        case 2:
            NSLog(@"接单");
            orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        default:
            break;
    }
}
//点击手势
//- (void)ClickswipeGestureAction:(UISwipeGestureRecognizer *)sender {
//    [UIView animateWithDuration:0.5 animations:^{
//        slideslip.frame = CGRectMake(-WIDTH/4*3, 0, WIDTH/4*3, HEIGHT);
//    }];
//    MaskView.hidden = YES;
//}
//右滑动手势
- (void)rightswipeGestureAction:(UISwipeGestureRecognizer *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        slideslip.frame = CGRectMake(0, 0, WIDTH/4*3, HEIGHT);
    }];
    MaskView.hidden = NO;
}

/*
 代理方法-->实现首页跳转
 账号管理 我的广告 我的钱包 我的店铺 我的圈子 
 向左滑动手势，蒙版消失
*/
#pragma mark --SliderDelegate
-(void)delegateClick:(int)buttonTag
{
    if (buttonTag == 1)
    {
        myAdv = [[AdvertisingVC alloc]init];
        [self.navigationController pushViewController:myAdv animated:YES];
    }
    if (buttonTag == 2)
    {
        myPurse = [[MoneyVC alloc]init];
        [self.navigationController pushViewController:myPurse animated:YES];
    }
    if (buttonTag == 3)
    {
        personMessageVC = [[PersonMessageVC alloc]init];
        [self.navigationController pushViewController:personMessageVC animated:YES];
    }
    if (buttonTag == 4)
    {
        Myfriends = [[FriendViewController alloc]init];
        [self.navigationController pushViewController:Myfriends animated:YES];
        QYUser *user = [[QYUser alloc]init];
        NSString *userId = [[NSUserDefaults standardUserDefaults]valueForKey:UserId];
        user.userId = userId;
        [QYHttpRequest queryMyfocusInfo:user];
    }
    if (buttonTag == 5) {
        [UMSocialSnsService presentSnsIconSheetView:self
            appKey:@"570f2d9c67e58e0c24000b55"
              shareText:@"分享至"
             shareImage:nil
        shareToSnsNames:[NSArray arrayWithObjects:UMShareToRenren,UMShareToQzone,UMShareToTencent,UMShareToQQ,nil]
               delegate:nil];
    }
    if (buttonTag == 6) {
        moreVC = [[MoreVC alloc]init];
        [self.navigationController pushViewController:moreVC animated:YES];
    }
    if (buttonTag == 7)
    {
        MaskView.hidden = YES;
    }
    if (buttonTag == 8)
    {
        BOOL isNeedLogin = [QYHttpRequest isNeedLogin];
        if (isNeedLogin) {
            LoginVC *loginVC = [[LoginVC alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else{
            personCenterVC = [[PersonCenterVC alloc]init];
            [self.navigationController pushViewController:personCenterVC animated:YES];
            QYUser *user = [[QYUser alloc]init];
            NSString *userId = [[NSUserDefaults standardUserDefaults]valueForKey:UserId];
            user.userId = userId;
            [QYHttpRequest queryPersonInfo:user WithBlock:^(NSArray *dataArray) {
                for (QueryUserInfo *queryuser in dataArray) {
                    personCenterVC.editTF_nick.text = queryuser.userName;
                    personCenterVC.editTF_sex.text = queryuser.sex;
                    personCenterVC.editTF_age.text = queryuser.age;
                    personCenterVC.editTF_address.text = queryuser.address;
                    personCenterVC.editTF_email.text = queryuser.email;
                    personCenterVC.editTF_industry.text = queryuser.business;
                    personCenterVC.editTF_company.text = queryuser.companyName;
                    personCenterVC.editTF_link.text = queryuser.link;
                    personCenterVC.editTF_info.text = queryuser.info;
                    personCenterVC.integral_countLabel.text = queryuser.points;
                    
                }
            }];
        }
        
    }
}

@end
