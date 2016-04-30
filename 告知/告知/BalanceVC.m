//
//  BalanceVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/24.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "BalanceVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "RechargeVC.h"
#import "WithdrawalVC.h"
@interface BalanceVC ()
{
    UIView     *_backview;          //用于做屏幕适配的视图
    UIImageView     *_topIV;      //顶栏视图
}

@end

@implementation BalanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _backview = [UIView new];
    _backview.backgroundColor = BackGroundColor(240, 240, 240, 1);;
    [self.view addSubview:_backview];
    _topIV = [UIImageView new];
    _topIV.image = [UIImage imageNamed:@"banner"];
    _topIV.userInteractionEnabled = YES;
    [_backview addSubview:_topIV];
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"账户余额";
    topLabel.textColor = [UIColor whiteColor];
    topLabel.font = [UIFont systemFontOfSize:18];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [_topIV addSubview:topLabel];
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_topIV addSubview:ReturnBtn];
    
    UIButton *BalanceWaterBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [BalanceWaterBtn setTitle:@"收支流水" forState:(UIControlStateNormal)];
    [BalanceWaterBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [BalanceWaterBtn addTarget:self action:@selector(BalanceWaterClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_topIV addSubview:BalanceWaterBtn];
    UIImageView *PurseIV = [UIImageView new];
    PurseIV.image = [UIImage imageNamed:@"my_mony_remaining_money_03"];
    [_backview addSubview:PurseIV];
    
    UILabel *RMBLabel = [[UILabel alloc]init];
    RMBLabel.text = @"￥";
    RMBLabel.font = [UIFont systemFontOfSize:24];
    [_backview addSubview:RMBLabel];
    
    UILabel *BalanceLabel = [UILabel new];
    BalanceLabel.text = @"0.00";
    BalanceLabel.font = [UIFont systemFontOfSize:24];
    [_backview addSubview:BalanceLabel];
    
    UIButton *RechargeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    RechargeBtn.layer.masksToBounds = YES;
    RechargeBtn.layer.cornerRadius = 6;
    [RechargeBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [RechargeBtn setTitle:@"充值" forState:(UIControlStateNormal)];
    [RechargeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    RechargeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [RechargeBtn addTarget:self action:@selector(RechargeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backview addSubview:RechargeBtn];
    
    UIButton *WithdrawalBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    WithdrawalBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    WithdrawalBtn.layer.masksToBounds = YES;
    WithdrawalBtn.layer.cornerRadius = 6;
    WithdrawalBtn.backgroundColor = [UIColor whiteColor];
    [WithdrawalBtn setTitle:@"提现" forState:(UIControlStateNormal)];
    [WithdrawalBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [WithdrawalBtn addTarget:self action:@selector(WithdrawalClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backview addSubview:WithdrawalBtn];
    
    
    [_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [_topIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backview.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topIV.mas_centerX);
        make.bottom.equalTo(_topIV.mas_bottom).with.offset(-WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, HEIGHT/24));
    }];
    
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_topIV.mas_bottom);
        make.left.equalTo(_topIV.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [PurseIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topIV.mas_bottom).with.offset(HEIGHT/6);
        make.centerX.equalTo(_backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(HEIGHT/4, HEIGHT/4));
    }];
    [RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PurseIV.mas_bottom).with.offset(HEIGHT/24);
        make.centerX.equalTo(_backview.mas_centerX).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [BalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PurseIV.mas_bottom).with.offset(HEIGHT/24);
        make.left.equalTo(RMBLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH/6, 30));
    }];
    [RechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(RMBLabel.mas_bottom).with.offset(HEIGHT/24);
        make.centerX.equalTo(_backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    [WithdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(RechargeBtn.mas_bottom).with.offset(HEIGHT/48);
        make.centerX.equalTo(_backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    [BalanceWaterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_topIV.mas_bottom).with.offset(-WIDTH/64);
        make.right.equalTo(_topIV.mas_right).with.offset(-WIDTH/64);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, WIDTH/15));
    }];

}
-(void)ReturnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//收支流水
-(void)BalanceWaterClick
{
    
}
//充值
-(void)RechargeClick
{
    RechargeVC *rechargeVC = [RechargeVC new];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}
//提现
-(void)WithdrawalClick
{
    WithdrawalVC *withdralVC = [WithdrawalVC new];
    [self.navigationController pushViewController:withdralVC animated:YES];
}
@end
