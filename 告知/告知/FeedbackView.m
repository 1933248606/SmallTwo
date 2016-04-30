//
//  FeedbackView.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/29.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "FeedbackView.h"
#import "Masonry.h"
#import "Tool_h.h"
@implementation FeedbackView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    UILabel *FeedbackLabel = [[UILabel alloc]init];
    FeedbackLabel.text = @"意见反馈";
    [self addSubview:FeedbackLabel];
    
    UIImageView *FeedIV = [[UIImageView alloc]init];
    FeedIV.image = [UIImage imageNamed:@"my_money_border"];
    FeedIV.userInteractionEnabled = YES;
    [backView addSubview:FeedIV];
    UITextView *FeedTextView = [[UITextView alloc]init];
    [FeedIV addSubview:FeedTextView];
    
    NSArray *nameArr = @[@"取消",@"发送",];
    for (int i = 0; i<2; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((WIDTH-20)/2*i, 160, (WIDTH-20)/2, 50)];
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        [btn setBackgroundImage:[UIImage imageNamed:@"my_money_border"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.tag = i+1;
        [self addSubview:btn];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(1*i+WIDTH/6,15, 40, 20)];
        label.text = [nameArr objectAtIndex:i];
        [btn addSubview:label];
    }
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, 230));
    }];
    [FeedbackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(5);
        make.centerX.equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 20));
    }];
    [FeedIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(FeedbackLabel.mas_top).with.offset(30);
        make.centerX.equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/8, 100));
    }];
    [FeedTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(FeedIV.mas_top).with.offset(2);
        make.centerX.equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/8-4, 90));
    }];

    
}
-(void)Click:(UIButton*)btn
{
    if ([self.delegate respondsToSelector:@selector(ClickDismissView:)]) {
        [self.delegate ClickDismissView:2];
    }

    switch (btn.tag) {
        case 1:
            [self removeFromSuperview];
            break;
        case 2:
            NSLog(@"发送");
            [self removeFromSuperview];
            break;
        default:
            break;
    }
}

@end
