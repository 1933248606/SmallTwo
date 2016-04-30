//
//  AuditVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/22.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "AuditVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "ApproveAccessVC.h"
@interface AuditVC ()

@end

@implementation AuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *_backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    UIImageView *TopIV = [UIImageView new];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UILabel *TitleLabel = [UILabel new];
    TitleLabel.text = @"商铺认证";
    TitleLabel.textColor = [UIColor whiteColor];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:TitleLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    UIButton *MerOrderBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [MerOrderBtn setTitle:@"分类" forState:(UIControlStateNormal)];
    [MerOrderBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [MerOrderBtn addTarget:self action:@selector(MerOrderClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:MerOrderBtn];
    
    
    UIImageView *AuditorIV = [UIImageView new];
    AuditorIV.image = [UIImage imageNamed:@"picture_audit"];
    [_backView addSubview:AuditorIV];
    
    UILabel *AuditLabel = [UILabel new];
    AuditLabel.text = @"系统审核中...";
    AuditLabel.textAlignment = NSTextAlignmentLeft;
    AuditLabel.font = [UIFont systemFontOfSize:20];
    [_backView addSubview:AuditLabel];
    
    UILabel *promptLabel = [UILabel new];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.text = @"*一个工作日内~我们将尽快审核您所提交的认证资料哦";
    [_backView addSubview:promptLabel];
    
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
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [AuditorIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(HEIGHT/6);
        make.left.equalTo(_backView.mas_left).with.offset(WIDTH/5);
        make.size.mas_equalTo(CGSizeMake(WIDTH/6, WIDTH/6));
    }];
    [AuditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(AuditorIV.mas_centerY);
        make.left.equalTo(AuditorIV.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/2, HEIGHT/13));
    }];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AuditLabel.mas_bottom).with.offset(HEIGHT/7);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/15));
    }];
    [MerOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom);
        make.right.equalTo(TopIV.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)MerOrderClick
{
    ApproveAccessVC *approveAccess = [[ApproveAccessVC alloc]init];
    [self.navigationController pushViewController:approveAccess animated:YES];
}

@end
