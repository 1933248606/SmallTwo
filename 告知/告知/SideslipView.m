//
//  SideslipView.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/7.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "SideslipView.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "CustomBtn.h"
#import "QueryUserInfo.h"

@interface SideslipView ()
{
    UIView                 *_backView;
    UIView                 *view;
    UILabel                *label;
    CustomBtn              *btn;
}

@end

@implementation SideslipView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UISwipeGestureRecognizer *leftswipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftswipeGestureAction:)];
    
    // 设置清扫手势支持的方向
    leftswipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    // 添加手势
    [self addGestureRecognizer:leftswipeGesture];
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(253, 253, 253, 1);
    //_backView.alpha = 0.8;
    [self addSubview:_backView];
    
    UIButton *headPicbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    headPicbtn.backgroundColor = [UIColor whiteColor];
    [headPicbtn addTarget:self action:@selector(UserInfoClick) forControlEvents:(UIControlEventTouchUpInside)];
    headPicbtn.layer.masksToBounds = YES;
    headPicbtn.layer.cornerRadius = 6;
    [self addSubview:headPicbtn];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"HeadPic"];
    UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
    self.HeadIV = [[UIImageView alloc]init];
    _HeadIV.layer.masksToBounds = YES;
    _HeadIV.layer.cornerRadius = 35;
    _HeadIV.image = [UIImage imageNamed:@"my_Headportrait"];
    if (!savedImage) {
        _HeadIV.image = [UIImage imageNamed:@"my_Headportrait"];
    }
    else{
        _HeadIV.image = savedImage;
    }

    [self addSubview:_HeadIV];
    
    UIImageView *arrowIV = [[UIImageView alloc]init];
    arrowIV.image = [UIImage imageNamed:@"nextstep_button"];
    [headPicbtn addSubview:arrowIV];
    
    UIImageView *dividerIV = [[UIImageView alloc]init];
    dividerIV.image = [UIImage imageNamed:@"bottom_line"];
    [headPicbtn addSubview:dividerIV];
    
    UILabel *UserLabel = [[UILabel alloc]init];
    UserLabel.text = @"用户名：";
    UserLabel.font = [UIFont systemFontOfSize:16];
    UserLabel.textColor = [UIColor grayColor];
    [headPicbtn addSubview:UserLabel];
    
    self.user_NameLabel = [[UILabel alloc]init];
    NSString *userStr = [[NSUserDefaults standardUserDefaults]valueForKey:USERNAME];
    _user_NameLabel.text = userStr;
    _user_NameLabel.font = [UIFont systemFontOfSize:16];
    _user_NameLabel.textColor = [UIColor grayColor];
    [headPicbtn addSubview:_user_NameLabel];
    
    
    UILabel *integralLabel = [UILabel new];
    integralLabel.text = @"积   分：";
    integralLabel.font = [UIFont systemFontOfSize:16];
    integralLabel.textColor = [UIColor grayColor];
    [headPicbtn addSubview:integralLabel];
    
    self.integral_CountLabel = [UILabel new];
    NSString *pointStr = [[NSUserDefaults standardUserDefaults]valueForKey:POINTS];
    _integral_CountLabel.text = pointStr;
    NSLog(@"我的积分有多少%@",pointStr);
    _integral_CountLabel.font = [UIFont systemFontOfSize:16];
    _integral_CountLabel.textColor = [UIColor grayColor];
    [headPicbtn addSubview:_integral_CountLabel];
    
    view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 6;
    [self addSubview:view];

    NSArray *IconArr = @[@"leftnav_my_advertising",@"my_purse",@"my_massage",@"my_group_none",@"leftnav_gift_2x",@"my_more",];
    NSArray *NameArr = @[@"我的广告",@"我的钱包",@"消息中心",@"我的圈子",@"分享给好友",@"更多",];
    for (int i = 0; i<6; i++)
    {
        btn = [[CustomBtn alloc]initWithFrame:CGRectMake(0, HEIGHT/11*i+10, WIDTH/3*2+5, HEIGHT/11)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.titleLabel.font = FONT(14);
        //[btn setTitle:[NameArr objectAtIndex:i] forState:(CustombuttonStateNormal)];
        btn.tag = i+1;
        [view addSubview:btn];
        UIImageView *BtnIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/11, WIDTH/11)];
        BtnIV.center = CGPointMake(WIDTH/15, HEIGHT/22);
        BtnIV.image = [UIImage imageNamed:[IconArr objectAtIndex:i]];
        BtnIV.userInteractionEnabled = YES;
        [btn addSubview:BtnIV];
        
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.text = [NameArr objectAtIndex:i];
        titlelabel.textColor = [UIColor grayColor];
        titlelabel.font = FONT(14);
        [btn addSubview:titlelabel];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btn.mas_centerY);
            make.left.equalTo(BtnIV.mas_right).with.offset(5);
            make.height.mas_equalTo(20);
        }];
        if (i == 1) {
            UILabel *RMB_label = [[UILabel alloc]init];
            RMB_label.text = @"0";
            RMB_label.textColor = [UIColor grayColor];
            RMB_label.font = FONT(12);
            [btn addSubview:RMB_label];
            [RMB_label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btn.mas_centerY);
                make.right.equalTo(btn.mas_right).with.offset(-25);
                make.height.mas_offset(15);
            }];
            UILabel *balancelabel = [[UILabel alloc]init];
            balancelabel.text = @"账务余额:￥";
            balancelabel.font = FONT(12);
            balancelabel.textColor = [UIColor grayColor];
            [btn addSubview:balancelabel];
            [balancelabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btn.mas_centerY);
                make.right.equalTo(RMB_label.mas_left);
                make.height.mas_offset(15);
            }];
            }
        if (i == 3) {
            UILabel *messagelabel = [[UILabel alloc]init];
            messagelabel.text = @"新消息";
            messagelabel.textColor = [UIColor grayColor];
            messagelabel.font = FONT(12);
            [btn addSubview:messagelabel];
            [messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btn.mas_centerY);
                make.right.equalTo(btn.mas_right).with.offset(-30);
                make.height.mas_offset(15);
            }];
        }
    }
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self.mas_left);
        make.size.mas_offset(CGSizeMake(WIDTH/4*3, HEIGHT));
    }];
    [headPicbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).with.offset(HEIGHT/15);
        make.left.equalTo(_backView.mas_left).with.offset(WIDTH/20*3);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3*2-WIDTH/10, HEIGHT/8));
    }];
    [_HeadIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headPicbtn.mas_centerY);
        make.left.equalTo(_backView.mas_left).with.offset(WIDTH/32);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [dividerIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headPicbtn.mas_centerY);
        make.left.equalTo(_HeadIV.mas_right).with.offset(5);
        make.right.equalTo(arrowIV.mas_left).with.offset(-5);
        make.height.mas_equalTo(1);
    }];
    [UserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_HeadIV.mas_right).with.offset(5);
        make.bottom.equalTo(dividerIV.mas_top).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, 20));
    }];
    [_user_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(UserLabel.mas_top);
        make.left.equalTo(UserLabel.mas_right);
        make.height.mas_equalTo(20);
    }];
    [integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_HeadIV.mas_right).with.offset(5);
        make.top.equalTo(dividerIV.mas_top).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, 20));
    }];
    [_integral_CountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(integralLabel.mas_top);
        make.left.equalTo(integralLabel.mas_right);
        make.height.mas_equalTo(20);
    }];
    [arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headPicbtn.mas_centerY);
        make.right.equalTo(headPicbtn.mas_right).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(WIDTH/18, WIDTH/18));
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headPicbtn.mas_bottom).with.offset(20);
        make.left.equalTo(self.mas_left).with.offset(WIDTH/20);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3*2, HEIGHT/6*4));
    }];
    
}
-(void)UserInfoClick
{
    if ([self.delegate respondsToSelector:@selector(delegateClick:)])
    {
        
        [self.delegate delegateClick:8];
    }

}
/*
 侧滑界面的不同按钮，所对应的tag值也不同，代理方法将不同的tag值传递到首页
 首页的属性接收，从而实现首页界面跳转
*/
-(void)btnClick:(UIButton*)button
{
        switch (button.tag) {
            case 1:
                if ([self.delegate respondsToSelector:@selector(delegateClick:)])
                {
                    
                    [self.delegate delegateClick:1];
                }
                NSLog(@"1");
                break;
            case 2:
                if ([self.delegate respondsToSelector:@selector(delegateClick:)])
                {
                    
                    [self.delegate delegateClick:2];
                }
                NSLog(@"2");
                break;
            case 3:
                if ([self.delegate respondsToSelector:@selector(delegateClick:)])
                {
                    
                    [self.delegate delegateClick:3];
                }
                NSLog(@"3");
                break;
            case 4:
                if ([self.delegate respondsToSelector:@selector(delegateClick:)])
                {
                    
                    [self.delegate delegateClick:4];
                }
                NSLog(@"4");
                break;
            case 5:
                if ([self.delegate respondsToSelector:@selector(delegateClick:)])
                {
                    
                    [self.delegate delegateClick:5];
                }
                NSLog(@"6");
                break;
            case 6:
                if ([self.delegate respondsToSelector:@selector(delegateClick:)])
                {
                    
                    [self.delegate delegateClick:6];
                }
                NSLog(@"6");
                break;

            default:
                break;
        }
}
- (void)leftswipeGestureAction:(UISwipeGestureRecognizer *)sender {
    NSLog(@"左滑动");
    if ([self.delegate respondsToSelector:@selector(delegateClick:)])
    {
        
        [self.delegate delegateClick:7];
    }

    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(-WIDTH/4*3, 0, WIDTH/4*3, HEIGHT);
    }];
}

@end
