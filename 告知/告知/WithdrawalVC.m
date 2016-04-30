//
//  WithdrawalVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/25.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "WithdrawalVC.h"
#import "Masonry.h"
#import "Tool_h.h"
@interface WithdrawalVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
}

@end

@implementation WithdrawalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"提现";
    topLabel.textColor = [UIColor whiteColor];
    topLabel.font = [UIFont systemFontOfSize:18];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [TopIV addSubview:topLabel];
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    UILabel *WithdrawalLabel = [UILabel new];
    WithdrawalLabel.text = @"提现金额";
    WithdrawalLabel.textAlignment = NSTextAlignmentCenter;
    WithdrawalLabel.backgroundColor = [UIColor whiteColor];
    WithdrawalLabel.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:WithdrawalLabel];
    
    UITextField *textField = [UITextField new];
    textField.placeholder = @"  可提现金额36.00元";
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:12];
    [_backView addSubview:textField];
    
    UILabel *PromptLabel = [UILabel new];
    PromptLabel.text = @"每笔限额XXXX元，本日还可以转出3次";
    PromptLabel.textColor = [UIColor grayColor];
    PromptLabel.font = [UIFont systemFontOfSize:11];
    [_backView addSubview:PromptLabel];

    
    UIButton *WeChatbtn = [[UIButton alloc]init];
    WeChatbtn.backgroundColor = [UIColor whiteColor];
    [WeChatbtn setTitle:@"提现到微信账号" forState:(UIControlStateNormal)];
    [WeChatbtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [WeChatbtn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 0, 0, 100))];
    [WeChatbtn addTarget:self action:@selector(BtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:WeChatbtn];
    
    UIButton *PromptBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    PromptBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    PromptBtn.layer.masksToBounds = YES;
    PromptBtn.layer.cornerRadius = 6;
    [PromptBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [PromptBtn setTitle:@"确认提现" forState:(UIControlStateNormal)];
    [PromptBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [PromptBtn addTarget:self action:@selector(PromptClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:PromptBtn];
    
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(WIDTH/6, HEIGHT/24));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom);
        make.left.equalTo(TopIV.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [WithdrawalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(10);
        make.left.equalTo(_backView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(10);
        make.left.equalTo(WithdrawalLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4*3, 40));
    }];
    [PromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(WithdrawalLabel.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/2+WIDTH/10, 20));
    }];
    [WeChatbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PromptLabel.mas_bottom).with.offset(10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    [PromptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(WeChatbtn.mas_bottom).with.offset(10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//提现到微信账号
-(void)BtnClick
{
    
}
//提现余额
-(void)PromptClick
{
    
}

@end
