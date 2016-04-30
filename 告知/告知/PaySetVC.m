//
//  PaySetVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/18.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "PaySetVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "CustomBtn.h"
#import "SeekPswVC.h"
#import "AmendPayVC.h"
@interface PaySetVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
}
@end

@implementation PaySetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    TopIV = [UIImageView new];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UIButton *returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [returnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:returnBtn];
    
    UILabel *PaySetLabel = [UILabel new];
    PaySetLabel.text = @"支付设置";
    PaySetLabel.textColor = [UIColor whiteColor];
    PaySetLabel.font = [UIFont systemFontOfSize:20];
    [TopIV addSubview:PaySetLabel];
    
    CustomBtn *AmendBtn = [CustomBtn buttonWithType:(UIButtonTypeSystem)];
    AmendBtn.backgroundColor = [UIColor whiteColor];
    [AmendBtn addTarget:self action:@selector(AmendClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:AmendBtn];
    
    UIImageView *AmendIV = [UIImageView new];
    AmendIV.image = [UIImage imageNamed:@"my_money_change_password"];
    [AmendBtn addSubview:AmendIV];
    
    UILabel *AmendLabel = [UILabel new];
    AmendLabel.text = @"修改支付密码";
    [AmendBtn addSubview:AmendLabel];
    
    CustomBtn *FindBtn = [CustomBtn buttonWithType:(UIButtonTypeSystem)];
    FindBtn.backgroundColor = [UIColor whiteColor];
    [FindBtn addTarget:self action:@selector(FindClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:FindBtn];
    
    UIImageView *FindImageView = [UIImageView new];
    FindImageView.image = [UIImage imageNamed:@"my_money_back_password"];
    [FindBtn addSubview:FindImageView];
    
    UILabel *FindLabel = [UILabel new];
    FindLabel.text = @"找回支付密码";
    [FindBtn addSubview:FindLabel];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TopIV.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [PaySetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.top.equalTo(TopIV.mas_top).with.offset(HEIGHT/24);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-HEIGHT/48);
    }];
    [AmendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(HEIGHT/48);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/11));
    }];
    [AmendIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(AmendBtn.mas_centerY);
        make.left.mas_equalTo(AmendBtn.mas_left).with.offset(WIDTH/64);
        make.size.mas_equalTo(CGSizeMake(WIDTH/8, WIDTH/8));
    }];
    [AmendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(AmendBtn.mas_centerY);
        make.left.equalTo(AmendIV.mas_right).with.offset(HEIGHT/48);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, HEIGHT/48));
    }];
    
    [FindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AmendBtn.mas_bottom).with.offset(HEIGHT/180);
        make.right.equalTo(_backView.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/11));
    }];
    [FindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(FindBtn.mas_centerY);
        make.left.mas_equalTo(AmendBtn.mas_left).with.offset(WIDTH/64);
        make.size.mas_equalTo(CGSizeMake(WIDTH/8, WIDTH/8));
    }];
    [FindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(FindBtn.mas_centerY);
        make.left.equalTo(FindImageView.mas_right).with.offset(HEIGHT/48);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, HEIGHT/48));
    }];
    
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//修改支付密码
-(void)AmendClick
{
    AmendPayVC *amendPayPswVC = [AmendPayVC new];
    [self.navigationController pushViewController:amendPayPswVC animated:YES];
}
//找回支付密码
-(void)FindClick
{
    SeekPswVC *seekvc = [SeekPswVC new];
    [self.navigationController pushViewController:seekvc animated:YES];
}

@end
