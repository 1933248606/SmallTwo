//
//  ChooseAdvTypeVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/17.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "ChooseAdvTypeVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "ReleaseGraphic.h"
#import "ReleaseVideoVC.h"
@interface ChooseAdvTypeVC ()
{
    UIView *_backView;
    ReleaseGraphic *releasegraphicVC;
    ReleaseVideoVC *releaseVideoVC;
}

@end

@implementation ChooseAdvTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    UIImageView *backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    backIV.image = [UIImage imageNamed:@"pic_jiedan_background_2x"];
    [_backView addSubview:backIV];
    
    UIImageView *TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UILabel *TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"发布广告";
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
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 25));
    }];
    
    UIButton *graphicBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [graphicBtn setBackgroundImage:[UIImage imageNamed:@"select_txt_pic"] forState:(UIControlStateNormal)];
    [graphicBtn addTarget:self action:@selector(releaseClick:) forControlEvents:(UIControlEventTouchUpInside)];
    graphicBtn.tag = 1;
    [_backView addSubview:graphicBtn];
    
    [graphicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView.mas_centerY).with.offset(HEIGHT/14);
        make.left.equalTo(_backView.mas_left).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, WIDTH/3));
    }];
    
    UIButton *videoBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [videoBtn setBackgroundImage:[UIImage imageNamed:@"select_vedio_pic"] forState:(UIControlStateNormal)];
    [videoBtn addTarget:self action:@selector(releaseClick:) forControlEvents:(UIControlEventTouchUpInside)];
    videoBtn.tag = 2;
    [_backView addSubview:videoBtn];
    [videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView.mas_centerY).with.offset(HEIGHT/14);
        make.right.equalTo(_backView.mas_right).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, WIDTH/3));
    }];
    
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)releaseClick:(UIButton*)button
{
    switch (button.tag) {
        case 1:
            releasegraphicVC = [[ReleaseGraphic alloc]init];
            [self.navigationController pushViewController:releasegraphicVC animated:YES];
            break;
        case 2:
            releaseVideoVC = [[ReleaseVideoVC alloc]init];
            [self.navigationController pushViewController:releaseVideoVC animated:YES];
            break;
        default:
            break;
    }
}
@end
