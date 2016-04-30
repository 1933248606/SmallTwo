//
//  AmendPswVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/24.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "AmendPswVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "QYHttpRequest.h"
#import "QYUser.h"
@interface AmendPswVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
    UITextField *phone_TF;
    UITextField *ver_TF;
    UITextField *psw_TF;
    NSInteger time;
    NSTimer *timer;
    UIButton *VerBtn;
}
@end

@implementation AmendPswVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    TopIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, TOP_BAR)];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"修改密码";
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
    
    UILabel *phone_Label = [[UILabel alloc]init];
    phone_Label.text = @"手  机  号：";
    phone_Label.textAlignment = NSTextAlignmentCenter;
    phone_Label.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:phone_Label];
    
    UILabel *verLabel = [[UILabel alloc]init];
    verLabel.text = @"验  证  码：";
    verLabel.textAlignment = NSTextAlignmentCenter;
    verLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:verLabel];
    
    UILabel *confirmNewPswLabel = [[UILabel alloc]init];
    confirmNewPswLabel.text = @"新  密  码：";
    confirmNewPswLabel.textAlignment = NSTextAlignmentCenter;
    confirmNewPswLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:confirmNewPswLabel];
    
    [phone_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(10);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 40));
    }];
    [verLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phone_Label.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 40));
    }];
    [confirmNewPswLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verLabel.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 40));
    }];
    
    phone_TF = [[UITextField alloc]init];
    phone_TF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:phone_TF];
    
    ver_TF = [[UITextField alloc]init];
    ver_TF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:ver_TF];
    
    psw_TF = [[UITextField alloc]init];
    psw_TF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:psw_TF];
    
    [phone_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phone_Label.mas_top);
        make.left.equalTo(phone_Label.mas_right).with.offset(1);
        make.right.equalTo(_backView.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    [ver_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verLabel.mas_top);
        make.left.equalTo(phone_Label.mas_right).with.offset(1);
        make.right.equalTo(_backView.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    [psw_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmNewPswLabel.mas_top);
        make.left.equalTo(phone_Label.mas_right).with.offset(1);
        make.right.equalTo(_backView.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
    }];

    VerBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    VerBtn.backgroundColor = [UIColor grayColor];
    [VerBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [VerBtn setTitleColor:BackGroundColor(240, 240, 240, 1) forState:(UIControlStateNormal)];
    [VerBtn addTarget:self action:@selector(VerificationCodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:VerBtn];
    
    [VerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ver_TF.mas_centerY);
        make.right.equalTo(ver_TF.mas_right).with.offset(-5);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *AmendBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [AmendBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    AmendBtn.layer.masksToBounds = YES;
    AmendBtn.layer.cornerRadius = 6;
    [AmendBtn setTitle:@"修改" forState:(UIControlStateNormal)];
    AmendBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [AmendBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [AmendBtn addTarget:self action:@selector(AmendClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:AmendBtn];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, HEIGHT/24));
    }];
    
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom);
        make.left.equalTo(TopIV.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [AmendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(psw_TF.mas_bottom).with.offset(10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//获取验证码
-(void)VerificationCodeClick
{
    if ([self checkTel:phone_TF.text] == NO) {
        SHOW_ALERT(@"请输入正确的手机号码");
        return;
    }
    else{
        QYUser *user = [[QYUser alloc]init];
        user.username = phone_TF.text;
        [QYHttpRequest requestToGetGainWithUser:user];
        time = 90;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getAgain) userInfo:nil repeats:YES];
        [timer fire];
        [VerBtn setTitle:@"90" forState:(UIControlStateNormal)];
    }
    
    
}
-(void)getAgain
{
    time--;
    NSString *str = [NSString stringWithFormat:@"%ld",(long)time];
    [VerBtn setTitle:str forState:UIControlStateNormal];
    [VerBtn setEnabled:NO];
    if (time == 0)
    {
        [timer invalidate];
        timer = nil;
        [VerBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [VerBtn setEnabled:YES];
    }
}

//修改
-(void)AmendClick
{
    QYUser *user = [[QYUser alloc]init];
    user.username = phone_TF.text;
    user.verification = ver_TF.text;
    user.psw = psw_TF.text;
    [QYHttpRequest requestModifyPassword:user];
/*
密码修改成功以后弹出提示框
*/
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
    return NO;
}

@end
