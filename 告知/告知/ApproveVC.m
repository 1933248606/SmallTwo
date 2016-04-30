//
//  ApproveVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/21.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "ApproveVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "CertificationVC.h"
@interface ApproveVC ()
{
    UIView *_backView;
}
@end

@implementation ApproveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    UIImageView *TopIV = [UIImageView new];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UILabel *TitleLabel = [UILabel new];
    TitleLabel.text = @"商铺认证";
    TitleLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:TitleLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    UIImageView *FlowImageView = [UIImageView new];
    FlowImageView.image = [UIImage imageNamed:@"zhuce_03"];
    [_backView addSubview:FlowImageView];
    
    UIButton *ApproveBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [ApproveBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [ApproveBtn setTitle:@"开始认证" forState:(UIControlStateNormal)];
    [ApproveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    ApproveBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [ApproveBtn addTarget:self action:@selector(ApproveClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:ApproveBtn];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-HEIGHT/64);
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [FlowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(20);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(HEIGHT/2, HEIGHT/2));
    }];
    [ApproveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(FlowImageView.mas_bottom).with.offset(HEIGHT/13);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/12));
    }];
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ApproveClick
{
    CertificationVC *Certification = [CertificationVC new];
    [self.navigationController pushViewController:Certification animated:YES];
}

@end
