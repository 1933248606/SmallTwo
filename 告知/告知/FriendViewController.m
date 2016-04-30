//
//  FriendViewController.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/10.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "FriendViewController.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "FocusTVCell.h"
#import "OthersSeeVC.h"
#import "QYHttpRequest.h"
#import "QYUser.h"
@interface FriendViewController ()
{
    UIView         *_backview;
    UIButton       *_btn;
    UIImageView    *TopIV;
    BOOL           isSelected;
    UISegmentedControl *segment;
}


@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _backview = [[UIView alloc]init];
    _backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backview];
    
    TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backview addSubview:TopIV];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];

        [_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backview.mas_top);
        make.centerX.equalTo(_backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 64));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TopIV.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    
    segment = [[UISegmentedControl alloc]initWithItems:@[@"关注的人",@"我的粉丝",]];
    segment.tintColor = [UIColor whiteColor];
    segment.layer.masksToBounds = YES;
    segment.layer.cornerRadius = 6;
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segSelected:) forControlEvents:(UIControlEventValueChanged)];
    [TopIV addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/2, 30));
    }];
    self.focusTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 250) style:(UITableViewStylePlain)];
    _focusTV.delegate = self;
    _focusTV.dataSource = self;
    //去除分割线
    _focusTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_focusTV registerNib:[UINib nibWithNibName:@"FocusTVCell" bundle:nil] forCellReuseIdentifier:@"focusCell"];
    [self.view addSubview:_focusTV];
    
    self.focusTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(droploadData)];
    [_focusTV.mj_header beginRefreshing];
    self.focusTV.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullloadData)];
}
//下拉刷新
-(void)droploadData
{
    [self.focusTV.mj_header endRefreshing];
}
//上拉更多
-(void)pullloadData
{
    
}
//返回按钮
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)segSelected:(UISegmentedControl*)seg
{
    if (seg.selectedSegmentIndex == 0) {
        [_focusTV reloadData];
        
    }else if (seg.selectedSegmentIndex == 1){
        QYUser *user = [[QYUser alloc]init];
        NSString *userId = [[NSUserDefaults standardUserDefaults]valueForKey:UserId];
        user.userId = userId;
        [QYHttpRequest queryMyfansInfo:user];
        [_focusTV reloadData];
    }
    
}
#pragma mark --表的数据源，代理协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (segment.selectedSegmentIndex == 0) {
        return 3;
    }
    else (segment.selectedSegmentIndex = 1); {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FocusTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"focusCell"];
    if (segment.selectedSegmentIndex == 0) {
        cell.userNameLabel.text = @"关注我的人都有钱";
    }
    if (segment.selectedSegmentIndex == 1) {
        cell.userNameLabel.text = @"一大波粉丝来了!!!!";
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OthersSeeVC *otherSeeVC = [[OthersSeeVC alloc]init];
    [self.navigationController pushViewController:otherSeeVC animated:YES];
}



@end
