//
//  MoreVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/16.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "MoreVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "FAQVC.h"
#import <UMSocial.h>
@interface MoreVC ()
{
    UIImageView *TopIV;
    NSArray *titleArr;
    NSArray *IconArr;
    FAQVC   *faqVC;
    FeedbackView *feedbackView;
    UIView *MaskView;
    
}
@end

@implementation MoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *_backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(returnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    UILabel *TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"更多";
    TitleLabel.textColor = [UIColor whiteColor];
    TitleLabel.font = [UIFont systemFontOfSize:20];
    [TopIV addSubview:TitleLabel];

    titleArr = @[@"常见问题",@"意见反馈",@"联系客服",@"检查更新",@"清理缓存",];
    IconArr = @[@"icon_morequestion_2x",@"icon_feedback_2x",@"icon_connectkefu_2x",@"icon_updata_2x",@"icon_clean_2x",];
    for (int i = 0; i<5; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64+(HEIGHT/11+HEIGHT/48)*i, WIDTH, HEIGHT/11)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:[titleArr objectAtIndex:i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn setTitleEdgeInsets:(UIEdgeInsetsMake(10, 20, 10, 10))];
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setImage:[UIImage imageNamed:[IconArr objectAtIndex:i]] forState:(UIControlStateNormal)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(10,10,10, 70)];
        btn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        btn.tag = i+10;
        [_backView addSubview:btn];
    }
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TopIV.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-HEIGHT/48);
        make.centerX.mas_equalTo(TopIV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/6, HEIGHT/24));
    }];
    
    MaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    MaskView.backgroundColor = [UIColor grayColor];
    MaskView.alpha = 0.3;
    [self.view addSubview:MaskView];
    MaskView.hidden = YES;

}
-(void)BtnClick:(UIButton*)button
{
    switch (button.tag) {
        case 10:
            faqVC = [FAQVC new];
            [self.navigationController pushViewController:faqVC animated:YES];
            break;
        case 11:
            feedbackView = [[FeedbackView alloc]initWithFrame:CGRectMake(10, HEIGHT/4, WIDTH-WIDTH/16, 230)];
            feedbackView.delegate = self;
            MaskView.hidden = NO;
            [self.view addSubview:feedbackView];
            NSLog(@"意见反馈");
            break;
        case 12:
            NSLog(@"3");
            break;
        case 13:
            NSLog(@"4");
            break;
        case 14:
            NSLog(@"5");
            break;
        default:
            break;
    }
    
}
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ClickDismissView:(int)button
{
    MaskView.hidden = YES;
}
@end
