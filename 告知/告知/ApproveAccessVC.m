//
//  ApproveAccessVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/22.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "ApproveAccessVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "CertificationVC.h"
@interface ApproveAccessVC ()
{
    UIView *_backView;
}
@end

@implementation ApproveAccessVC

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
    
    UIImageView *AccessIV = [UIImageView new];
    AccessIV.image = [UIImage imageNamed:@"picture_complete"];
    [_backView addSubview:AccessIV];
    
    
    UILabel *label = [UILabel new];
    label.text = @"认证成功";
    label.font = [UIFont systemFontOfSize:20];
    [_backView addSubview:label];
    
    UIButton *ThoroughBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [ThoroughBtn setBackgroundImage:[UIImage imageNamed:@"banner(1)"] forState:(UIControlStateNormal)];
    [ThoroughBtn setTitle:@"完善店铺信息" forState:(UIControlStateNormal)];
    ThoroughBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [ThoroughBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [ThoroughBtn addTarget:self action:@selector(ThoroughClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:ThoroughBtn];
    
    UIButton *PublishBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [PublishBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [PublishBtn setTitle:@"去发布广告" forState:(UIControlStateNormal)];
    PublishBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [PublishBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [PublishBtn addTarget:self action:@selector(PublishClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:PublishBtn];
    
    
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
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-HEIGHT/64);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, HEIGHT/24));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopIV.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [AccessIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(HEIGHT/9);
        make.centerX.equalTo(_backView.mas_centerX).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(WIDTH/7, WIDTH/7));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(HEIGHT/7);
        make.centerX.equalTo(_backView.mas_centerX).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, HEIGHT/30));
    }];
    [ThoroughBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).with.offset(HEIGHT/4);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    [PublishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ThoroughBtn.mas_bottom).with.offset(HEIGHT/10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    
    
    
    
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ThoroughClick
{
    CertificationVC *certication = [CertificationVC new];
    [self.navigationController pushViewController:certication animated:YES];
}
-(void)PublishClick
{
    
}


@end
