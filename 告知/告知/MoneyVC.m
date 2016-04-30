//
//  MoneyVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/11.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "MoneyVC.h"
#import "CustomBtn.h"
#import "Masonry.h"
#import "Tool_h.h"

#import "PaySetVC.h"
#import "BalanceVC.h"
@interface MoneyVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
    UIButton *btn;
}
@end

@implementation MoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    TopIV = [UIImageView new];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.frame = CGRectMake(0, 0, WIDTH, HEIGHT/4);
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UIImageView *HeadView = [UIImageView new];
    HeadView.image = [UIImage imageNamed:@"my_Headportrait"];
    [TopIV addSubview:HeadView];
    
    UIButton *returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [returnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 5, 0)];    [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:returnBtn];
    
    UILabel *NickNameLabel = [[UILabel alloc]init];
    NickNameLabel.text = @"12345678911";
    NickNameLabel.textColor = [UIColor whiteColor];
    NickNameLabel.textAlignment = NSTextAlignmentCenter;
    [TopIV addSubview:NickNameLabel];
    
    UIView *blackView = [[UIView alloc]init];
    blackView.backgroundColor = BackGroundColor(70, 70, 70, 1);
    [_backView addSubview:blackView];
    
    UIImageView *balance_IV = [[UIImageView alloc]init];
    balance_IV.image = [UIImage imageNamed:@"my_yue"];
    [blackView addSubview:balance_IV];
    
    UILabel *BalanceLabel = [[UILabel alloc]init];
    BalanceLabel.text = @"余额";
    BalanceLabel.textColor = [UIColor whiteColor];
    [balance_IV addSubview:BalanceLabel];
    
    UILabel *RMBLabel = [[UILabel alloc]init];
    RMBLabel.text = @"0.00";
    RMBLabel.textColor = [UIColor whiteColor];
    RMBLabel.textAlignment = NSTextAlignmentCenter;
    [blackView addSubview:RMBLabel];
    
    UIButton *BankcardBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [BankcardBtn addTarget:self action:@selector(BankcardClick) forControlEvents:(UIControlEventTouchUpInside)];
    [blackView addSubview:BankcardBtn];
    
    UIImageView *BankcardImageView = [[UIImageView alloc]init];
    BankcardImageView.image = [UIImage imageNamed:@"my_money_withdrawal(1)"];
    [BankcardBtn addSubview:BankcardImageView];
    UILabel *rechargeLabel = [[UILabel alloc]init];
    rechargeLabel.text = @"充值及提现";
    rechargeLabel.textColor = [UIColor whiteColor];
    rechargeLabel.textAlignment = NSTextAlignmentCenter;
    [BankcardBtn addSubview:rechargeLabel];
    
    UIImageView *divider_IV = [[UIImageView alloc]init];
    divider_IV.image = [UIImage imageNamed:@"bottom_line"];
    [blackView addSubview:divider_IV];
    
    NSArray *titleArr = @[@"累计佣金",@"累计消费",@"累计充值",@"累计提现",];
    NSArray *moneyArr = @[@"￥15.50",@"￥15.50",@"￥15.50",@"￥15.50",];
    
    for (int i = 0; i < 4; i++) {
        btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(WIDTH/4*i, HEIGHT/4+HEIGHT/6+20, WIDTH/4, WIDTH/4);
        [btn setBackgroundImage:[UIImage imageNamed:@"my_money_border"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.tag = i+1;
        [_backView addSubview:btn];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH/4, 20)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = FONT(12);
        titleLabel.text = [titleArr objectAtIndex:i];
        [btn addSubview:titleLabel];
        UILabel *RMB_Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, WIDTH/4, 20)];
        RMB_Label.textColor = [UIColor purpleColor];
        RMB_Label.textAlignment = NSTextAlignmentCenter;
        RMB_Label.font = FONT(12);
        RMB_Label.text = [moneyArr objectAtIndex:i];
        [btn addSubview:RMB_Label];
    }
    
    CustomBtn *PayBtn = [CustomBtn buttonWithType:(UIButtonTypeSystem)];
    PayBtn.backgroundColor = [UIColor whiteColor];
    [PayBtn addTarget:self action:@selector(PayClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:PayBtn];
    
    UIImageView *Pay_IV = [UIImageView new];
    Pay_IV.image = [UIImage imageNamed:@"my_money_Payment-Settings"];
    [PayBtn addSubview:Pay_IV];
    
    UILabel *PaySetLabel = [UILabel new];
    PaySetLabel.text = @"支付设置";
    PaySetLabel.textColor = [UIColor grayColor];
    [PayBtn addSubview:PaySetLabel];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_top).with.offset(WIDTH/10);
        make.left.equalTo(TopIV.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [HeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(returnBtn.mas_top);
        make.centerX.equalTo(TopIV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, WIDTH/5));
    }];
    [NickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.top.equalTo(HeadView.mas_bottom).with.offset(WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, WIDTH/20));
    }];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/6));
    }];
    [divider_IV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blackView.mas_centerX);
        make.centerY.equalTo(blackView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(2, HEIGHT/8));
    }];
    [balance_IV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blackView.mas_top).with.offset(WIDTH/35);
        make.left.equalTo(blackView.mas_left).offset(WIDTH/6);
        make.size.mas_equalTo(CGSizeMake(WIDTH/7,WIDTH/7));
    }];
    [BankcardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blackView.mas_top).with.offset(WIDTH/35);
        make.right.equalTo(blackView.mas_right).offset(-WIDTH/6);
        make.size.mas_equalTo(CGSizeMake(WIDTH/7, WIDTH/7));
    }];
    [BalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balance_IV.mas_bottom).with.offset(5);
        make.right.equalTo(balance_IV.mas_centerX);
        make.height.mas_equalTo(20);;
    }];
    [RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(BalanceLabel.mas_centerY);
        make.left.equalTo(BalanceLabel.mas_right);
        make.height.mas_equalTo(20);
    }];
    [BankcardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BankcardBtn.mas_top);
        make.centerX.equalTo(BankcardBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/7, WIDTH/7));
    }];
    [rechargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BankcardBtn.mas_bottom).with.offset(5);
        make.centerX.equalTo(BankcardBtn.mas_centerX);
        make.height.mas_equalTo(20);
    }];
    [PayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).with.offset(HEIGHT/18);
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 50));
    }];
    [Pay_IV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(PayBtn.mas_centerY);
        make.left.equalTo(PayBtn.mas_left).with.offset(WIDTH/64);
        make.size.mas_equalTo(CGSizeMake(WIDTH/12, WIDTH/12));
    }];
    [PaySetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(PayBtn.mas_centerY);
        make.left.equalTo(Pay_IV.mas_right).with.offset(WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, HEIGHT/24));
    }];
    
}
-(void)BankcardClick
{
    BalanceVC *balanceVC = [BalanceVC new];
    [self.navigationController pushViewController:balanceVC animated:YES];

}

-(void)PayClick
{
    NSLog(@"按钮被点击了");
    PaySetVC *paysetVC = [[PaySetVC alloc]init];
    [self.navigationController pushViewController:paysetVC animated:YES];
}
-(void)btnClick:(UIButton*)button
{
    switch (button.tag) {
        case 1:
            NSLog(@"累计佣金");
            break;
        case 2:
            NSLog(@"累计消费");
            break;
        case 3:
            NSLog(@"累计充值");
            break;
        case 4:
            NSLog(@"累计提现");
            break;
        default:
            break;
    }
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
