//
//  PayAdvVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/16.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "PayAdvVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "PayAccesssVC.h"
#import "RechargeVC.h"
#import "LrdPasswordAlertView.h"
@interface PayAdvVC ()
{
    UIImageView *bright_mark_1;//支付状态->高亮状态
    UIImageView *bright_mark_2;
    BOOL        isChange;
    BOOL        payChange;
    UIView      *MaskView;
}
@end

@implementation PayAdvVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *_backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    MaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/2)];
    MaskView.backgroundColor = [UIColor grayColor];
    MaskView.alpha = 0.3;
    [self.view addSubview:MaskView];
    MaskView.hidden = YES;

    
    UIImageView *TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UILabel *TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"支付";
    TitleLabel.font = [UIFont systemFontOfSize:20];
    TitleLabel.textColor = [UIColor whiteColor];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [TopIV addSubview:TitleLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom);
        make.left.equalTo(TopIV.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(WIDTH/6, 25));
    }];
    
    UILabel *advertisingLabel = [[UILabel alloc]init];
    advertisingLabel.text = @"  基本广告费：";
    advertisingLabel.textAlignment = NSTextAlignmentRight;
    advertisingLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:advertisingLabel];
    
    UILabel *rmbLabel = [[UILabel alloc]init];
    rmbLabel.textColor = [UIColor redColor];
    rmbLabel.text = @"500.00";
    rmbLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:rmbLabel];
    
    UILabel *yuanLabel = [[UILabel alloc]init];
    yuanLabel.text = @"元";
    yuanLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:yuanLabel];
    
    [advertisingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom);
        make.left.equalTo(_backView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3+10, 40));
    }];
    [rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom);
        make.left.equalTo(advertisingLabel.mas_right);
        make.height.mas_equalTo(40);
    }];
    [yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom);
        make.left.equalTo(rmbLabel.mas_right);
        make.right.equalTo(_backView.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *costDetailsLabel = [[UILabel alloc]init];
    costDetailsLabel.text = @"    基本广告费*（1+10%服务费）= 广告总价";
    costDetailsLabel.font = [UIFont systemFontOfSize:14];
    costDetailsLabel.textColor = [UIColor grayColor];
    costDetailsLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:costDetailsLabel];
    
    [costDetailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(advertisingLabel.mas_bottom);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 30));
    }];
    
    UILabel *totalPricesLabel = [[UILabel alloc]init];
    totalPricesLabel.text = @"   广告总价：";
    totalPricesLabel.font = [UIFont systemFontOfSize:20];
    totalPricesLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:totalPricesLabel];
    
    UILabel *rmb_Label = [[UILabel alloc]init];
    rmb_Label.text = @"550.00";
    rmb_Label.textColor = [UIColor redColor];
    rmb_Label.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:rmb_Label];
    
    UILabel *yuan_Label = [[UILabel alloc]init];
    yuan_Label.text = @"元";
    yuan_Label.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:yuan_Label];

    [totalPricesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(costDetailsLabel.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3+10, 40));
    }];
    [rmb_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(costDetailsLabel.mas_bottom);
        make.left.equalTo(totalPricesLabel.mas_right);
        make.height.mas_equalTo(40);
    }];
    [yuan_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(costDetailsLabel.mas_bottom);
        make.left.equalTo(rmb_Label.mas_right);
        make.right.equalTo(_backView.mas_right);
        make.height.mas_equalTo(40);
    }];

    UILabel *choosePayLabel = [[UILabel alloc]init];
    choosePayLabel.text = @"   选择支付方式";
    choosePayLabel.backgroundColor =  [UIColor whiteColor];
    [_backView addSubview:choosePayLabel];
    [choosePayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalPricesLabel.mas_bottom).with.offset(10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    
    UIButton *wechatBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    wechatBtn.backgroundColor = [UIColor whiteColor];
    [wechatBtn addTarget:self action:@selector(payClickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    wechatBtn.tag = 2;
    [_backView addSubview:wechatBtn];
    
    UIButton *balancePayBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    balancePayBtn.backgroundColor = [UIColor whiteColor];
    [balancePayBtn addTarget:self action:@selector(payClickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    balancePayBtn.tag = 1;
    [_backView addSubview:balancePayBtn];
    UILabel *balancePayLabel = [[UILabel alloc]init];
    balancePayLabel.text = @"余额支付";
    [balancePayBtn addSubview:balancePayLabel];
    
    UILabel *usable_BalanceLabel = [[UILabel alloc]init];
    usable_BalanceLabel.text = @"可用余额：";
    usable_BalanceLabel.textColor = [UIColor grayColor];
    usable_BalanceLabel.font = FONT(12);
    [balancePayBtn addSubview:usable_BalanceLabel];
    
    UILabel *balance_RMBLabel = [[UILabel alloc]init];
    balance_RMBLabel.text = @"50元";
    balance_RMBLabel.textColor = [UIColor grayColor];
    balance_RMBLabel.font = FONT(12);
    [balancePayBtn addSubview:balance_RMBLabel];
    
    UIImageView *dark_mark_1 = [[UIImageView alloc]init];
    dark_mark_1.image = [UIImage imageNamed:@"pay_noselected"];
    [balancePayBtn addSubview:dark_mark_1];
    
    bright_mark_1 = [[UIImageView alloc]init];
    bright_mark_1.image = [UIImage imageNamed:@"pay_selected"];
    [balancePayBtn addSubview:bright_mark_1];
    bright_mark_1.hidden = YES;
    
    [balancePayBtn addSubview:balancePayLabel];
    [balancePayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(choosePayLabel.mas_bottom).with.offset(1);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 50));
    }];
    [balancePayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balancePayBtn.mas_top).with.offset(5);
        make.left.equalTo(balancePayBtn.mas_left).with.offset(10);
        make.height.mas_equalTo(30);
    }];
    [usable_BalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(balancePayLabel.mas_left);
        make.top.equalTo(balancePayLabel.mas_bottom);
        make.height.mas_equalTo(15);
    }];
    [balance_RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(usable_BalanceLabel.mas_right);
        make.top.equalTo(balancePayLabel.mas_bottom);
        make.height.mas_equalTo(15);
    }];
    [dark_mark_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(balancePayBtn.mas_centerY);
        make.right.equalTo(balancePayBtn.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [bright_mark_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(balancePayBtn.mas_centerY);
        make.right.equalTo(balancePayBtn.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    /*
     当余额支付，余额不足时，点击按钮跳转到充值界面
     这里给Button的标题加了-->下划线
     */
    UIButton *rechargeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"去充值"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [rechargeBtn setAttributedTitle:str forState:UIControlStateNormal];
    [rechargeBtn addTarget:self action:@selector(rechargeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [balancePayBtn addSubview:rechargeBtn];
    
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balance_RMBLabel.mas_top);
        make.left.equalTo(balance_RMBLabel.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 15));
    }];
    
    
    UIImageView *wechatIV = [[UIImageView alloc]init];
    wechatIV.image = [UIImage imageNamed:@"iconfont_weixin@3x"];
    [wechatBtn addSubview:wechatIV];

    UILabel *wechatLabel = [[UILabel alloc]init];
    wechatLabel.text = @"微信支付";
    [wechatBtn addSubview:wechatLabel];
    
    UIImageView *dark_mark_2 = [[UIImageView alloc]init];
    dark_mark_2.image = [UIImage imageNamed:@"pay_noselected"];
    [wechatBtn addSubview:dark_mark_2];
    
    bright_mark_2 = [[UIImageView alloc]init];
    bright_mark_2.image = [UIImage imageNamed:@"pay_selected"];
    [wechatBtn addSubview:bright_mark_2];
    bright_mark_2.hidden = YES;
    
    
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balancePayBtn.mas_bottom).with.offset(1);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 50));
    }];
    [wechatIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wechatBtn.mas_centerY);
        make.left.equalTo(wechatBtn.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wechatBtn.mas_centerY);
        make.left.equalTo(wechatIV.mas_right).with.offset(10);
    }];
    [dark_mark_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wechatBtn.mas_centerY);
        make.right.equalTo(wechatBtn.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [bright_mark_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wechatBtn.mas_centerY);
        make.right.equalTo(wechatBtn.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    UIButton *confirmPayBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    confirmPayBtn.layer.masksToBounds = YES;
    confirmPayBtn.layer.cornerRadius = 6;
    [confirmPayBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [confirmPayBtn setTitle:@"确认支付" forState:(UIControlStateNormal)];
    [confirmPayBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [confirmPayBtn addTarget:self action:@selector(confirmPayClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:confirmPayBtn];
    [confirmPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wechatBtn.mas_bottom).with.offset(20);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, 40));
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 6;
    saveBtn.backgroundColor = BackGroundColor(170, 170, 170, 1);
    [saveBtn setTitle:@"暂不支付，保存草稿到我的广告" forState:(UIControlStateNormal)];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmPayBtn.mas_bottom).with.offset(10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, 40));
    }];
    isChange = NO;
    payChange = NO;
}
////取消支付
//-(void)CancelClick
//{
//    if (payChange == YES) {
//        MaskView.hidden  = YES;
//        payChange = NO;
//    }
//}
//确认支付
-(void)confirmPayClick
{
    LrdPasswordAlertView *testView = [[LrdPasswordAlertView alloc] initWithFrame:self.view.bounds];
    testView.titleName = @"请输入支付密码";
    testView.fontSize = 17.f;
    testView.block = ^(NSString *text){
        NSLog(@"%@",text);
        
    };
    [testView pop];}
-(void)rechargeClick
{
    NSLog(@"去充值");
    RechargeVC *rechargeVC = [[RechargeVC alloc]init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)payClickBtn:(UIButton*)button
{
    switch (button.tag) {
        case 1:
//            if (isChange == NO) {
//                bright_mark_1.hidden = NO;
//                bright_mark_2.hidden = YES;
//                isChange = YES;
//            }
//            else if (isChange == YES){
//                bright_mark_1.hidden = YES;
//                isChange = NO;
//            }
            break;
        case 2:
            if (isChange == NO) {
                bright_mark_2.hidden = NO;
                bright_mark_1.hidden = YES;
                isChange = YES;
            }
            else if (isChange == YES){
                bright_mark_2.hidden = YES;
                isChange = NO;
            }
            break;
        default:
            break;
    }
}
//保存广告草稿
-(void)saveClick
{
    NSLog(@"草稿保存");
}
@end
