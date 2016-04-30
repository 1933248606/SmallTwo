//
//  RetrievePswVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/8.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "RetrievePswVC.h"
#import "Masonry.h"
#import "Tool_h.h"

@interface RetrievePswVC ()
{
    UIImageView *TopIV;
    UITextField *textField;
    
}
@end

@implementation RetrievePswVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *_backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    TopIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, TOP_BAR)];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    UILabel *topLabel = [UILabel new];
    topLabel.text = @"找回密码";
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:topLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    NSArray *titleArr = [[NSArray alloc]initWithObjects:@"手  机  号：",@"验  证  码：",@"确认密码：", nil];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/32,HEIGHT/9+HEIGHT/13*i+2*i, WIDTH-WIDTH/16, HEIGHT/13)];
        imageView.image = [UIImage imageNamed:@"my_money_border"];
        imageView.userInteractionEnabled = YES;
        [_backView addSubview:imageView];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(HEIGHT/48, 5, WIDTH/4+10, HEIGHT/22)];
        label.text = [titleArr objectAtIndex:i];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor grayColor];
        [imageView addSubview:label];
        
        textField = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH/3.1,5, WIDTH/2-WIDTH/8, HEIGHT/22)];
        textField.tag = i +1;
        [imageView addSubview:textField];
    }
    
    UIButton *AmendBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    AmendBtn.layer.masksToBounds = YES;
    AmendBtn.layer.cornerRadius = 6;
    [AmendBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [AmendBtn setTitle:@"修改" forState:(UIControlStateNormal)];
    [AmendBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    AmendBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [AmendBtn addTarget:self action:@selector(AmendPsdClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:AmendBtn];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, HEIGHT/20));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom);
        make.left.equalTo(TopIV.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [AmendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.centerY.equalTo(_backView.mas_centerY).with.offset(-HEIGHT/13);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)AmendPsdClick
{
    
}
@end
