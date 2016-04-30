//
//  RechargeVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/24.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "RechargeVC.h"
#import "Masonry.h"
#import "Tool_h.h"
@interface RechargeVC ()
{
    UIView     *_backview;          //用于做屏幕适配的视图
    UIImageView     *_topIV;      //顶栏视图
}

@end

@implementation RechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backview = [[UIView alloc]init];
    _backview.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backview];
    _topIV = [[UIImageView alloc]init];
    _topIV.image = [UIImage imageNamed:@"banner"];
    _topIV.userInteractionEnabled = YES;
    [_backview addSubview:_topIV];
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"充值";
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
    
    UIImageView *BackIV = [[UIImageView alloc]init];
    BackIV.image = [UIImage imageNamed:@"my_money_border"];
    BackIV.userInteractionEnabled = YES;
    [_backview addSubview:BackIV];
    
    UILabel *MoneyLabel = [[UILabel alloc]init];
    MoneyLabel.text = @"金额";
    MoneyLabel.font = [UIFont systemFontOfSize:14];
    [BackIV addSubview:MoneyLabel];
    
    UITextField *TextField = [[UITextField alloc]init];
    TextField.placeholder = @"请输入充值金额";
    TextField.font = [UIFont systemFontOfSize:12];
    [BackIV addSubview:TextField];
    
    NSArray *IconArr = @[@"icon_weibo",@"icon_weixin",];
    
    NSArray *PayNameArr = @[@"支付宝钱包支付",@"微信钱包支付",];
    for (int i=0; i<2; i++)
    {
        UIImageView *PayIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, HEIGHT/11+95+45*i, WIDTH, 45)];
        PayIV.image = [UIImage imageNamed:@"my_money_border"];
        PayIV.userInteractionEnabled = YES;
        [_backview addSubview:PayIV];
        
        UIImageView *PayPicIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, HEIGHT/11+105+40*i, 25, 25)];
        PayPicIV.image = [UIImage imageNamed:[IconArr objectAtIndex:i]];
        [self.view addSubview:PayPicIV];
        
        UILabel *PayNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, HEIGHT/11+110+40*i, WIDTH/3, 20)];
        PayNameLabel.text = [PayNameArr objectAtIndex:i];
        PayNameLabel.font = [UIFont systemFontOfSize:14];
        [_backview addSubview:PayNameLabel];
    }
    
    UIButton *AffirmPayBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    AffirmPayBtn.layer.masksToBounds = YES;
    AffirmPayBtn.layer.cornerRadius = 6;
    AffirmPayBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [AffirmPayBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [AffirmPayBtn setTitle:@"确认支付" forState:(UIControlStateNormal)];
    [AffirmPayBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [AffirmPayBtn addTarget:self action:@selector(AffirmPayClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backview addSubview:AffirmPayBtn];
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
    [BackIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topIV.mas_bottom).with.offset(15);
        make.centerX.equalTo(_backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 45));
    }];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BackIV.mas_top).with.offset(10);
        make.left.equalTo(BackIV.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 25));
    }];
    [TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BackIV.mas_top).with.offset(10);
        make.left.equalTo(MoneyLabel.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 25));
    }];
    [AffirmPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backview.mas_centerX);
        make.centerY.equalTo(_backview.mas_centerY).with.offset(HEIGHT/24);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//确认支付
-(void)AffirmPayClick
{
    
}

@end
