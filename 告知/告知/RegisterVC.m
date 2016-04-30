//
//  RegisterVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/9.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "RegisterVC.h"
#import "Tool_h.h"
#import <SVProgressHUD.h>
#import "QYHttpRequest.h"
#import "QYUser.h"
#import "Interface.h"
@interface RegisterVC ()
{
    Interface *interface;
    NSInteger time;
    NSTimer *timer;
    UIButton *Verificationbtn;
}
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _protocol_highlightedIV.hidden = YES;
}
- (IBAction)GainVerificationCodeBtn:(id)sender {
    
    if ([self checkTel:_phoneTF.text] == NO) {
        SHOW_ALERT(@"请先输入手机号");
    }
    else if (_PswTF.text.length == 0){
        SHOW_ALERT(@"请先设置密码");
    }
    else if (_PswTF.text.length < 6 || _PswTF.text.length >18){
        SHOW_ALERT(@"密码不得小于6位或大于18位");
    }
    else if ([_PswTF.text isEqualToString:_ConfirmTF.text] == NO)
    {
        SHOW_ALERT(@"确认密码与密码不一致");
        return;
    }
    else{
        QYUser *user = [[QYUser alloc]init];
        user.username = _phoneTF.text;
        user.psw = _PswTF.text;
        [QYHttpRequest requestToGetGainWithUser:user];
        time = 90;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getAgain) userInfo:nil repeats:YES];
        [timer fire];
        Verificationbtn = (UIButton*)sender;
        [Verificationbtn setTitle:@"90" forState:(UIControlStateNormal)];

    }
    
}
-(void)getAgain
{
    time--;
    NSString *str = [NSString stringWithFormat:@"%ld",(long)time];
    [Verificationbtn setTitle:str forState:UIControlStateNormal];
    [Verificationbtn setEnabled:NO];
    if (time == 0)
    {
        [timer invalidate];
        timer = nil;
        [Verificationbtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [Verificationbtn setEnabled:YES];
    }
}
- (IBAction)RegisterBtn:(id)sender {
    if ([self checkTel:_phoneTF.text] == NO) {
        SHOW_ALERT(@"请输入正确的手机号码");
        return;
    }
    else if (_PswTF.text.length == 0)
    {
        SHOW_ALERT(@"密码不能为空");
        return;
    }
    else if (_PswTF.text.length < 6){
        SHOW_ALERT(@"密码长度不能小于6位");
        return;
    }
    else if (_PswTF.text.length > 18){
        SHOW_ALERT(@"密码长度不能小于6位");
        return;
    }
    else if ([_PswTF.text isEqualToString:_ConfirmTF.text] == NO)
    {
        SHOW_ALERT(@"密码与确认密码不一致");
        return;
    }
    QYUser *user = [[QYUser alloc]init];
    user.username = _phoneTF.text;
    user.psw = _PswTF.text;
    user.verification = _SecurityTF.text;
    [QYHttpRequest requestToRegisteWithUser:user];
    
}
- (IBAction)ReturnBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [timer invalidate];
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
- (IBAction)userProtocolClick:(id)sender {
}

@end
