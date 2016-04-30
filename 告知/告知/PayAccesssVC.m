//
//  PayAccesssVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/18.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "PayAccesssVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "AdvertisingVC.h"
@interface PayAccesssVC ()
{
    UIView *_backView;
}
@end

@implementation PayAccesssVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    UIImageView *TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    
    UILabel *jumpLabel = [[UILabel alloc]init];
    jumpLabel.text = @"即将跳转到我的广告...等待1秒";
    jumpLabel.textAlignment = NSTextAlignmentCenter;
    jumpLabel.textColor = [UIColor grayColor];
    [_backView addSubview:jumpLabel];
    [jumpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.centerY.equalTo(_backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 30));
    }];
    UIButton *jumpToMyAdvBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [jumpToMyAdvBtn setTitle:@"直接跳转到我的广告!" forState:(UIControlStateNormal)];
    [jumpToMyAdvBtn addTarget:self action:@selector(jumpToMyAdvClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:jumpToMyAdvBtn];
    [jumpToMyAdvBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jumpLabel.mas_bottom);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 20));
    }];
}
-(void)jumpToMyAdvClick
{
    //UIWindow *window = [UIApplication sharedApplication].delegate.window;
    AdvertisingVC *adertisingVC = [[AdvertisingVC alloc]init];
    [self.navigationController pushViewController:adertisingVC animated:YES];
    //window.rootViewController = adertisingVC;
}

@end
