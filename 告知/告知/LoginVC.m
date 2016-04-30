//
//  LoginVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/15.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "LoginVC.h"
#import "Masonry.h"
#import "CustomButton.h"
#import "RegisterVC.h"
#import "Tool_h.h"
#import "RetrievePswVC.h"
#import "Interface.h"
#import <SVProgressHUD.h>
#import "PersonCenterVC.h"
#import <IosApi.h>
#import "QYHttpRequest.h"
#import "QYUser.h"
@interface LoginVC ()
{
    UIImageView *TopIV;
    UITextField *TelTextfield;
    UITextField *PswTextfield;
    Interface *interface;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *_backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    TopIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, TOP_BAR)];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    UILabel *topLabel = [UILabel new];
    topLabel.text = @"微广告";
    topLabel.font = FONT(20);
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:topLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    UIImageView *TelImageView = [UIImageView new];
    TelImageView.image = [UIImage imageNamed:@"my_money_border"];
    [_backView addSubview:TelImageView];
    UILabel *TelLabel = [UILabel new];
    TelLabel.text = @"手机号：";
    TelLabel.textAlignment = NSTextAlignmentRight;
    TelLabel.textColor = [UIColor grayColor];
    [TelImageView addSubview:TelLabel];
    
    TelTextfield = [UITextField new];
    TelTextfield.placeholder = @"＋86";
    [_backView addSubview:TelTextfield];
    
    UIImageView *PSWImageView = [UIImageView new];
    PSWImageView.image = [UIImage imageNamed:@"my_money_border"];
    [_backView addSubview:PSWImageView];
    UILabel *PSWLabel = [UILabel new];
    PSWLabel.text = @"密    码：";
    PSWLabel.textAlignment = NSTextAlignmentRight;
    PSWLabel.textColor = [UIColor grayColor];
    [PSWImageView addSubview:PSWLabel];
    PswTextfield = [UITextField new];
    PswTextfield.secureTextEntry = YES;
    [_backView addSubview:PswTextfield];
    UIButton *LoginBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    LoginBtn.layer.masksToBounds = YES;
    LoginBtn.layer.cornerRadius = 6;
    [LoginBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [LoginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    LoginBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [LoginBtn addTarget:self action:@selector(LoginClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:LoginBtn];
    
    
    UIButton *ForgetPswBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [ForgetPswBtn setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
    ForgetPswBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    ForgetPswBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [ForgetPswBtn addTarget:self action:@selector(SearchClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:ForgetPswBtn];
    
    UIButton *ImmediatelyBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [ImmediatelyBtn setTitle:@"立即注册" forState:(UIControlStateNormal)];
    ImmediatelyBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [ImmediatelyBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [ImmediatelyBtn addTarget:self action:@selector(RegisterClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:ImmediatelyBtn];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, HEIGHT/20));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom);
        make.left.equalTo(TopIV.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [TelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(HEIGHT/24);
        make.centerX.equalTo(TopIV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    [PSWImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TelImageView.mas_bottom);
        make.centerX.equalTo(TopIV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    [TelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(TelImageView.mas_centerY);
        make.left.equalTo(TelImageView.mas_left).with.offset(WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(70, HEIGHT/24));
    }];
    [PSWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(PSWImageView.mas_centerY);
        make.left.equalTo(PSWImageView.mas_left).with.offset(WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(70, HEIGHT/24));
    }];
    [TelTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(TelImageView.mas_centerY);
        make.left.equalTo(TelLabel.mas_right).with.offset(WIDTH/64);
        make.size.mas_equalTo(CGSizeMake(WIDTH/2, HEIGHT/24));
    }];
    [PswTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(PSWImageView.mas_centerY);
        make.left.equalTo(PSWLabel.mas_right).with.offset(WIDTH/64);
        make.size.mas_equalTo(CGSizeMake(WIDTH/2, HEIGHT/24));
    }];
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.top.equalTo(PSWImageView.mas_bottom).with.offset(HEIGHT/24);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/15, HEIGHT/13));
    }];
    [ForgetPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(LoginBtn.mas_bottom).with.offset(HEIGHT/24);
        make.left.equalTo(LoginBtn.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, HEIGHT/24));
    }];
    [ImmediatelyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(LoginBtn.mas_bottom).with.offset(HEIGHT/24);
        make.right.equalTo(LoginBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, HEIGHT/24));
    }];
    
    interface = [Interface newInterface];
}

-(void)ReturnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//注册
-(void)RegisterClick
{
    RegisterVC *registerViewController = [RegisterVC new];
    [self.navigationController pushViewController:registerViewController animated:YES];
}
//登录
-(void)LoginClick
{
    
    [self checkTel:TelTextfield.text];
    QYUser *user = [[QYUser alloc]init];
    user.username = TelTextfield.text;
    user.psw = PswTextfield.text;
    [QYHttpRequest requestToLoginWithUser:user completion:^(NSString *error, BOOL isSuccess) {
        if (error) {
            //NSLog(@"%@",error);
        }
        if (isSuccess) {
            NSLog(@"登录成功。。。。。。。。。");
        }
    }];
    PersonCenterVC *personCenterVC = [[PersonCenterVC alloc]init];
    [self.navigationController pushViewController:personCenterVC animated:YES];

}
//电话号码
- (BOOL)checkTel:(NSString *)mobileNumbel

{
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        NSLog(@"手机号验证可用");
        return YES;
    }
    SHOW_ALERT(@"请输入正确的手机号码");
    return NO;
    
    
}
//找回密码
-(void)SearchClick
{
    RetrievePswVC *amendVC = [[RetrievePswVC alloc]init];
    [self.navigationController pushViewController:amendVC animated:YES];
}


@end
