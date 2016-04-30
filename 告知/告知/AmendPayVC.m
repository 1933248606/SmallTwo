//
//  AmendPayVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/25.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "AmendPayVC.h"
#import "Masonry.h"
#import "Tool_h.h"
@interface AmendPayVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
}

@end

@implementation AmendPayVC

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
    
    UILabel *oldPswLabel = [[UILabel alloc]init];
    oldPswLabel.text = @"原  密  码：";
    oldPswLabel.textAlignment = NSTextAlignmentCenter;
    oldPswLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:oldPswLabel];
    
    UILabel *newPswLabel = [[UILabel alloc]init];
    newPswLabel.text = @"新  密  码：";
    newPswLabel.textAlignment = NSTextAlignmentCenter;
    newPswLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:newPswLabel];
    
    UILabel *confirmNewPswLabel = [[UILabel alloc]init];
    confirmNewPswLabel.text = @"确认新密码：";
    confirmNewPswLabel.textAlignment = NSTextAlignmentCenter;
    confirmNewPswLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:confirmNewPswLabel];
    
    [oldPswLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(10);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 40));
    }];
    [newPswLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPswLabel.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 40));
    }];
    [confirmNewPswLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newPswLabel.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 40));
    }];
    
    UITextField *oldPswTF = [[UITextField alloc]init];
    oldPswTF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:oldPswTF];
    
    UITextField *newPswTF = [[UITextField alloc]init];
    newPswTF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:newPswTF];
    
    UITextField *confirmPswTF = [[UITextField alloc]init];
    confirmPswTF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:confirmPswTF];
    
    [oldPswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPswLabel.mas_top);
        make.left.equalTo(oldPswLabel.mas_right);
        make.right.equalTo(_backView.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    [newPswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newPswLabel.mas_top);
        make.left.equalTo(oldPswLabel.mas_right);
        make.right.equalTo(_backView.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    [confirmPswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmNewPswLabel.mas_top);
        make.left.equalTo(oldPswLabel.mas_right);
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
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, HEIGHT/24));
    }];
    
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TopIV.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [AmendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmNewPswLabel.mas_bottom).with.offset(30);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//修改
-(void)AmendClick
{
    
}

@end
