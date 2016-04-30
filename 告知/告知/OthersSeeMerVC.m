//
//  OthersSeeMerVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/25.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "OthersSeeMerVC.h"
#import "Masonry.h"
#import "Tool_h.h"
@interface OthersSeeMerVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
}

@end

@implementation OthersSeeMerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    TopIV = [UIImageView new];
    TopIV.image = [UIImage imageNamed:@"my_background"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    UIImageView *HeadImage = [UIImageView new];
    HeadImage.image = [UIImage imageNamed:@"my_Headportrait"];
    [TopIV addSubview:HeadImage];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [ReturnBtn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:ReturnBtn];
    
    UILabel *NickNameLabel = [UILabel new];
    NickNameLabel.text = @"12345678912";
    NickNameLabel.textColor = [UIColor whiteColor];
    NickNameLabel.textAlignment = NSTextAlignmentCenter;
    [TopIV addSubview:NickNameLabel];
    
    UILabel *CredibilityLabel = [UILabel new];
    CredibilityLabel.text = @"关注";
    CredibilityLabel.textAlignment = NSTextAlignmentCenter;
    CredibilityLabel.font = [UIFont systemFontOfSize:16];
    CredibilityLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:CredibilityLabel];
    
    UILabel *FocusLabel = [UILabel new];
    FocusLabel.text = @"关注";
    FocusLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:FocusLabel];
    
    UILabel *FocusCountLabel = [UILabel new];
    FocusCountLabel.text = @"100";
    FocusCountLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:FocusCountLabel];
    
    UILabel *FansLabel = [UILabel new];
    FansLabel.text = @"粉丝";
    FansLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:FansLabel];
    
    UILabel *FansCountLabel = [UILabel new];
    FansCountLabel.text = @"100";
    FansCountLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:FansCountLabel];
    
    UIImageView *WhiteBackIV = [UIImageView new];
    WhiteBackIV.image = [UIImage imageNamed:@"my_money_border"];
    WhiteBackIV.userInteractionEnabled = YES;
    [_backView addSubview:WhiteBackIV];
    
    NSArray *MerDetailsArr = @[@"商家地址:",@"所属行业:",@"商家网址:",];
    for (int i = 0; i<3; i++)
    {
        UILabel *MerLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/32, HEIGHT/48+HEIGHT/22*i, WIDTH/5, HEIGHT/48)];
        MerLabel.text = [MerDetailsArr objectAtIndex:i];
        MerLabel.textAlignment = NSTextAlignmentLeft;
        MerLabel.font = [UIFont systemFontOfSize:12];
        [WhiteBackIV addSubview:MerLabel];
        
        UILabel *MerDetailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5+10, HEIGHT/48+HEIGHT/22*i, WIDTH-WIDTH/4, HEIGHT/48)];
        MerDetailsLabel.backgroundColor = [UIColor orangeColor];
        [WhiteBackIV addSubview:MerDetailsLabel];
    }
    
    UIImageView *VideoIV = [UIImageView new];
    VideoIV.image = [UIImage imageNamed:@"my_money_border"];
    VideoIV.userInteractionEnabled = YES;
    [_backView addSubview:VideoIV];
    
    UILabel *MerVideoLabel = [UILabel new];
    MerVideoLabel.text = @"商家视频:";
    MerVideoLabel.font = [UIFont systemFontOfSize:12];
    MerVideoLabel.textAlignment = NSTextAlignmentLeft;
    [VideoIV addSubview:MerVideoLabel];
    
    for (int i=0; i<3; i++)
    {
        UIImageView *AdvIV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/5+WIDTH/4*i, HEIGHT/22, WIDTH/5,WIDTH/5)];
        AdvIV.image = [UIImage imageNamed:@"banner"];
        [VideoIV addSubview:AdvIV];
    }
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backView.mas_centerX);
        make.top.equalTo(_backView.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/3));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).with.offset(WIDTH/15);
        make.left.equalTo(_backView.mas_left).with.offset(WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(WIDTH/16, WIDTH/16));
    }];
    
    [HeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.top.equalTo(TopIV.mas_top).with.offset(HEIGHT/24);
        make.size.mas_equalTo(CGSizeMake(WIDTH/6, WIDTH/6));
    }];
    
    [NickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX .equalTo(_backView.mas_centerX);
        make.top.equalTo(HeadImage.mas_bottom).with.offset(HEIGHT/48);
        make.size.mas_equalTo(CGSizeMake(WIDTH/2, HEIGHT/24));
    }];
    [CredibilityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NickNameLabel.mas_bottom).with.offset(HEIGHT/48);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, HEIGHT/22));
    }];
    
    [FocusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CredibilityLabel.mas_bottom).with.offset(HEIGHT/48);
        make.right.equalTo(FocusCountLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/7, 20));
    }];
    [FocusCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CredibilityLabel.mas_bottom).with.offset(HEIGHT/48);
        make.right.equalTo(TopIV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/8,20));
    }];
    [FansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CredibilityLabel.mas_bottom).with.offset(HEIGHT/48);
        make.left.equalTo(FocusCountLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH/7, 20));
    }];
    [FansCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CredibilityLabel.mas_bottom).with.offset(HEIGHT/48);
        make.left.equalTo(FansLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH/8, 20));
    }];
    [WhiteBackIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/6));
    }];
    
    [VideoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(WhiteBackIV.mas_bottom).with.offset(10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/5));
    }];
    [MerVideoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(VideoIV.mas_top).with.offset(5);
        make.left.equalTo(VideoIV.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/6, HEIGHT/24));
    }];
    
    
}
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
