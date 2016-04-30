//
//  OthersSeeVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/25.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "OthersSeeVC.h"
#import "Masonry.h"
#import "Tool_h.h"
@interface OthersSeeVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
}
@end

@implementation OthersSeeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"my_background"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UILabel *NickNameLabel = [[UILabel alloc]init];
    NickNameLabel.text = @"致尚科技有限公司";
    NickNameLabel.textAlignment = NSTextAlignmentCenter;
    [TopIV addSubview:NickNameLabel];
    
    UIImageView *certification_IV = [[UIImageView alloc]init];
    certification_IV.image = [UIImage imageNamed:@"dynamic_firm"];
    [TopIV addSubview:certification_IV];
    
    UIButton *focusBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [focusBtn setBackgroundImage:[UIImage imageNamed:@"Cancel_the attention"] forState:(UIControlStateNormal)];
    [focusBtn addTarget:self action:@selector(FocusClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:focusBtn];
    
    UIImageView *HeadImage = [[UIImageView alloc]init];
    HeadImage.image = [UIImage imageNamed:@"my_Headportrait"];
    [TopIV addSubview:HeadImage];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 5, 0)];
    [ReturnBtn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];

    UILabel *integralLabel = [[UILabel alloc]init];
    integralLabel.text = @"积分：";
    integralLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:integralLabel];
    
    UILabel *integral_countLabel = [[UILabel alloc]init];
    integral_countLabel.text = @"1082";
    integral_countLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:integral_countLabel];
    
    UILabel *dividerLabel = [[UILabel alloc]init];
    dividerLabel.backgroundColor = [UIColor whiteColor];
    [TopIV addSubview:dividerLabel];
    
    UILabel *FocusLabel = [[UILabel alloc]init];
    FocusLabel.text = @"关注";
    FocusLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:FocusLabel];
    
    UILabel *FocusCountLabel = [[UILabel alloc]init];
    FocusCountLabel.text = @"100";
    FocusCountLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:FocusCountLabel];
    
    UILabel *FansLabel = [[UILabel alloc]init];
    FansLabel.text = @"粉丝";
    FansLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:FansLabel];
    
    UILabel *FansCountLabel = [[UILabel alloc]init];
    FansCountLabel.text = @"100";
    FansCountLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:FansCountLabel];
    
    UIImageView *WhiteBackIV = [[UIImageView alloc]init];
    WhiteBackIV.image = [UIImage imageNamed:@"my_money_border"];
    WhiteBackIV.userInteractionEnabled = YES;
    [_backView addSubview:WhiteBackIV];
    
    UILabel *ADVLabel = [[UILabel alloc]init];
    ADVLabel.text = @"广告";
    ADVLabel.textAlignment = NSTextAlignmentCenter;
    ADVLabel.textColor = [UIColor grayColor];
    [WhiteBackIV addSubview:ADVLabel];
    
    for (int i=0; i<3; i++)
    {
        UIImageView *AdvIV = [[UIImageView alloc]initWithFrame:CGRectMake(60+70*i+20*i, 10, 70, 60)];
        AdvIV.image = [UIImage imageNamed:@"banner"];
        [WhiteBackIV addSubview:AdvIV];
        UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60+70*i+20*i, 55, 70, 60)];
        TitleLabel.text = @"喜来登酒店大酬宾";
        TitleLabel.textColor = [UIColor grayColor];
        TitleLabel.font = [UIFont systemFontOfSize:12];
        [WhiteBackIV addSubview:TitleLabel];
    }
    
    UIButton *CheckBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [CheckBtn setBackgroundImage:[UIImage imageNamed:@"my_money_border"] forState:(UIControlStateNormal)];
    [CheckBtn setTitle:@"查看更多" forState:(UIControlStateNormal)];
    [CheckBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [CheckBtn addTarget:self action:@selector(CheckClick) forControlEvents:(UIControlEventTouchUpInside)];
    [WhiteBackIV addSubview:CheckBtn];
    
    UIView *LineView = [UIView new];
    LineView.backgroundColor = [UIColor lightGrayColor];
    [_backView addSubview:LineView];
    
    UILabel *CommentListLabel = [UILabel new];
    CommentListLabel.text = @"评论列表";
    CommentListLabel.backgroundColor = BackGroundColor(240, 240, 240, 1);
    CommentListLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:CommentListLabel];
    
    
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
        make.left.equalTo(_backView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/12, WIDTH/12));
    }];
    [NickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX .equalTo(_backView.mas_centerX);
        make.top.equalTo(TopIV.mas_top).with.offset(25);
        make.height.mas_equalTo(20);
    }];
    [certification_IV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NickNameLabel.mas_top);
        make.left.equalTo(NickNameLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [HeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.top.equalTo(NickNameLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, WIDTH/5));
    }];
    [focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NickNameLabel.mas_top);
        make.right.equalTo(TopIV.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeadImage.mas_bottom).with.offset(10);
        make.right.equalTo(HeadImage.mas_centerX);
        make.height.mas_equalTo(20);
    }];
    [integral_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(integralLabel.mas_top);
        make.left.equalTo(integralLabel.mas_right);
        make.height.mas_equalTo(20);
    }];
    [dividerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(1, 20));
    }];
    [FocusCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.right.equalTo(dividerLabel.mas_left).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(WIDTH/8, 20));
    }];
    [FocusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.right.equalTo(FocusCountLabel.mas_left).with.offset(-5);
        make.height.mas_equalTo(20);
    }];
    [FansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.left.equalTo(dividerLabel.mas_right).with.offset(20);
        make.height.mas_equalTo(20);
    }];
    [FansCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.left.equalTo(FansLabel.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(WIDTH/8, 20));
    }];
    [WhiteBackIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom).with.offset(10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/5));
    }];
    [ADVLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(WhiteBackIV.mas_top).with.offset(10);
        make.left.equalTo(WhiteBackIV.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    [CheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(WhiteBackIV.mas_bottom);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/13));
    }];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CheckBtn.mas_bottom).with.offset(20);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/32, 1));
    }];
    [CommentListLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CheckBtn.mas_bottom).with.offset(10);
        make.centerX.equalTo(LineView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 20));
    }];
}
-(void)FocusClick
{
    
}
//查看更多
-(void)CheckClick
{
    
}
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
