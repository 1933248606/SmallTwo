//
//  SeekPswVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/25.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "SeekPswVC.h"
#import "Masonry.h"
#import "Tool_h.h"
@interface SeekPswVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
}

@end

@implementation SeekPswVC

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
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(returnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    UILabel *PaySetLabel = [UILabel new];
    PaySetLabel.text = @"找回密码";
    PaySetLabel.textColor = [UIColor whiteColor];
    PaySetLabel.textAlignment = NSTextAlignmentCenter;
    PaySetLabel.font = [UIFont systemFontOfSize:20];
    [TopIV addSubview:PaySetLabel];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"手  机  号:";
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:phoneLabel];
    
    UILabel *verificationLabel = [[UILabel alloc]init];
    verificationLabel.text = @"验  证  码:";
    verificationLabel.textAlignment = NSTextAlignmentCenter;
    verificationLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:verificationLabel];
    
    UILabel *setPswLabel = [[UILabel alloc]init];
    setPswLabel.text = @"设置密码:";
    setPswLabel.textAlignment = NSTextAlignmentCenter;
    setPswLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:setPswLabel];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(10);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 40));
    }];
    [verificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 40));
    }];
    [setPswLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificationLabel.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 40));
    }];
    
    UITextField *phoneTF = [[UITextField alloc]init];
    phoneTF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:phoneTF];
    
    UITextField *verificationTF = [[UITextField alloc]init];
    verificationTF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:verificationTF];
    
    UITextField *setPswTF = [[UITextField alloc]init];
    setPswTF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:setPswTF];
    
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel.mas_top);
        make.left.equalTo(phoneLabel.mas_right);
        make.right.equalTo(_backView.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    [verificationTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificationLabel.mas_top);
        make.left.equalTo(phoneLabel.mas_right);
        make.right.equalTo(_backView.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    [setPswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(setPswLabel.mas_top);
        make.left.equalTo(phoneLabel.mas_right);
        make.right.equalTo(_backView.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *AmendBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [AmendBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [AmendBtn setTitle:@"修改" forState:(UIControlStateNormal)];
    AmendBtn.layer.masksToBounds = YES;
    AmendBtn.layer.cornerRadius = 6;
    AmendBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [AmendBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [AmendBtn addTarget:self action:@selector(AmendClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:AmendBtn];

    UIButton *VerificationBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    VerificationBtn.backgroundColor = [UIColor grayColor];
    [VerificationBtn setBackgroundImage:[UIImage imageNamed:@"my_money_border"] forState:(UIControlStateNormal)];
    VerificationBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [VerificationBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [VerificationBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [VerificationBtn addTarget:self action:@selector(VerificationClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:VerificationBtn];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [PaySetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.centerX.equalTo(TopIV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 20));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TopIV.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [AmendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(setPswTF.mas_bottom).with.offset(30);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    [VerificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificationTF.mas_top);
        make.right.equalTo(verificationTF.mas_right).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, 40));
    }];
    
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//获取验证码
-(void)VerificationClick
{
    
}
-(void)AmendClick
{
    
}

@end
