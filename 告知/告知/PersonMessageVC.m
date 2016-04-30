//
//  PersonMessageVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/24.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "PersonMessageVC.h"
#import "Masonry.h"
#import "Tool_h.h"
@interface PersonMessageVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
}
@end

@implementation PersonMessageVC

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
    
    UILabel *TopLabel = [UILabel new];
    TopLabel.text = @"消息";
    TopLabel.font = [UIFont systemFontOfSize:24];
    TopLabel.textAlignment = NSTextAlignmentCenter;
    TopLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:TopLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [TopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-HEIGHT/48);
        make.centerX.equalTo(TopIV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/6, HEIGHT/24));
    }];
    
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TopIV.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];

    
}
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
